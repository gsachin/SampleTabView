//
//  ContentView.swift
//  TabViewSample
//
//  Created by Sachin Gupta on 9/9/21.
//

import SwiftUI

struct TabViewSample: View {
    @StateObject private var viewModel = TabViewSampleModel()
    //@State private var badgeNumber: Int = 3
    private var badgePosition: CGFloat = 3
    private var tabsCount: CGFloat = 3
    var body: some View {
        GeometryReader { geometry in
              ZStack(alignment: .bottomLeading) {
        TabView (selection: $viewModel.selectedTab,
                 content:  {
                    Text("Tab Content 1").tabItem { Text("Tab 1") }.tag(Tab.tab1)
                    Text("Tab Content 2").tabItem { Text("Tab 2") }.tag(Tab.tab2)
                    Text("Tab Content 3").tabItem { Text("Tab 3") }.tag(Tab.tab3)
                 })
               ZStack {
                 Circle()
                   .foregroundColor(.red)
               }
               .frame(width: 20, height: 20)
               .offset(x: ( ( 2 * self.badgePosition) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
               .opacity(viewModel.showBadge ? 1 : 0)
              }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewSample()
    }
}

final class TabViewSampleModel: ObservableObject {
    @Published var showBadge: Bool = true
    @Published var selectedTab = Tab.tab1 {
        didSet {
            if selectedTab == Tab.tab3, showBadge {
                showBadge = false
            }
        }
    }
}

enum Tab: Int{
    case tab1
    case tab2
    case tab3
}
