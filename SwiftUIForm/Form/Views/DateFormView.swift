//
//  DateFormView.swift
//  SwiftUIForm
//
//  Created by Lori Rothermel on 3/30/23.
//

import SwiftUI

struct DateFormView: View {
    @EnvironmentObject var contentBuilder: FormContentBuilderImpl
    @State private var selectedDate = Date()
    @State private var error: ValidationError?
    
    
    let component: DateFormComponent
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker("", selection: $selectedDate, displayedComponents: [component.mode])
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(error?.errorDescription ?? "")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.red)
        }  // VStack
        .onChange(of: selectedDate, perform: { newValue in
            contentBuilder.update(selectedDate, in: component)
            
            // Perform validation
            error = component.validations.compactMap {$0.validate(selectedDate)}.first
        })
         
    }  // some View
}  // DateFormView

struct DateFormView_Previews: PreviewProvider {
    static var previews: some View {
        DateFormView(component: .init(id: .dob, mode: .date))
            .environmentObject(FormContentBuilderImpl())
            .previewLayout(.sizeThatFits)
            .padding(.horizontal)
    }
}
