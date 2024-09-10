import Foundation
import SwiftUI

struct MainListView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    @Binding var importance: Importance
    @Binding var deadline: Date?
    @Binding var selectedImportanceIndex: Int
    @Binding var switchIsOn: Bool
    @Binding var datePickerIsOn: Bool
    @Binding var todoItem: TodoItem?
    @EnvironmentObject var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode
    

    var body: some View {
        List {
            Section {
                textEditor
            }
            Section {
                importanceHStack
                deadlineHStack
                
                if datePickerIsOn {
                    datePicker
                }
            }
            Section {
                removeButton
            }
        }
        .listSectionSpacing(16)
        .listStyle(.insetGrouped)
        .listRowBackground(Resources.LightTheme.Back.primaryColor)
        .frame(minHeight: 112.5)
    }

    var textEditor: some View {
        TextEditor(text: $text)
            .foregroundStyle(self.text == "Что надо сделать?" ?
                                (colorScheme == .light ?
                                 Resources.LightTheme.Label.TetiaryColor
                                 :Resources.DarkTheme.Label.TetiaryColor)
                             :(colorScheme == .light ?
                               Resources.LightTheme.Label.blackColor
                               :Resources.DarkTheme.Label.primaryColor))
            .frame(minHeight: 120)
            
            .cornerRadius(16)
            .onTapGesture {
                if self.text == "Что надо сделать?" {
                    self.text = ""
                }
            }
    }
    
    var importanceHStack: some View {
        HStack {
            Text("Важность")
                .font(.system(size: 17))
            Spacer()
            
            Picker("importance", selection: $selectedImportanceIndex) {
                Image(systemName: "arrow.down").tag(0)
                Text("нет").tag(1)
                Image(Resources.LightTheme.Images.exclamationMark).tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 150)
            .accentColor(.red)
        }
    }

    var deadlineHStack: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Сделать до")
                    .font(.system(size: 17))
                if switchIsOn && deadline != nil {
                    Text("\(deadline!.formattedDate())")
                        .bold()
                        .font(.system(size: 13))
                        .foregroundColor(Resources.LightTheme.blueColor)
                        .onTapGesture {
                            datePickerIsOn.toggle()
                        }
                }
            }
            Spacer()
            Toggle(isOn: $switchIsOn.animation()) {
                EmptyView()
            }
            .labelsHidden()
            .onChange(of: switchIsOn) { newValue in
                if newValue {
                    if deadline == nil {
                        deadline = Date().nextDayFormatted()
                        datePickerIsOn = true
                    }
                } else {
                    deadline = nil
                    datePickerIsOn = false
                }
            }
        }
    }

    var datePicker: some View {
        DatePicker(
            "",
            selection: Binding(
                get: { deadline ?? Date() },
                set: { newDate in
                    deadline = newDate
                    datePickerIsOn = false
                }
            ),
            displayedComponents: [.date]
        )
        .datePickerStyle(GraphicalDatePickerStyle())
        .labelsHidden()
        .padding(.horizontal)
    }

    var removeButton: some View {
        Button {
            viewModel.removeItem(item: todoItem)
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Удалить")
                .foregroundColor(Resources.LightTheme.redColor)
                .frame(maxHeight: 70)
                .frame(maxWidth: .infinity)
        }
        .cornerRadius(16)
    }
}
