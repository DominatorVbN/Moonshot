//
//  ContentView.swift
//  Moonshot
//
//  Created by dominator on 11/11/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronuats: [Astronaut] = Bundle.main.loadFile("astronauts.json")
    let missions: [Mission] = Bundle.main.loadFile("missions.json")
    init(){
        UITableView.appearance().separatorColor = .clear
    }
    var body: some View {
        NavigationView{
            List(missions){ mission in
                NavigationLink(destination: MissionView(mission: mission)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading){
                       
                        Text(mission.displayName)
                            .font(.title)
                        Text(mission.formattedDate)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(
                            Color(UIColor.systemGroupedBackground)))
            }.navigationBarTitle("Moonshoot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
