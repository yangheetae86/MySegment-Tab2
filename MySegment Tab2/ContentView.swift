import SwiftUI

struct ContentView: View { //ContentView: 메인
    var body: some View {
        VStack(spacing: 0) {
            Home()
        }
    }
}

struct ContentView_Previews: PreviewProvider { //ContentView로딩
    static var previews: some View {
        ContentView()
    }
}

struct Home : View { // Home: 모든 구성요소의 집합체
    
    @State var index = 1
    @State var offset : CGFloat = UIScreen.main.bounds.width //yh
    var width = UIScreen.main.bounds.width //yh
    
    var body: some View {
        VStack(spacing: 0) {
            
            AppBar(index: $index, offset: $offset) //offset: self.$offset
            
            GeometryReader {g in
                HStack(spacing: 0) {
                    First() //스크롤뷰
                        .frame(width: g.frame(in : .global).width)
//                    .offset(y: self.offset)

                    Scnd()
                        .frame(width: g.frame(in : .global).width)
//                    .offset(y: self.offset)

                    Third()
                        .frame(width: g.frame(in : .global).width)
//                    .offset(y: self.offset)
                }
                .offset(x: self.offset)
            .highPriorityGesture(DragGesture()
            .onEnded({ (value) in
                
                if value.translation.width > 50 { // minimun drag...
                    print("right")
                    self.changeView(left: false)
                }
                if -value.translation.width > 50 {
                    self.changeView(left: true)
                }
            }))
            
                
            }
        }
        .animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
    
    func  changeView(left: Bool){
        if left {
            if self.index != 3 {
                self.index += 1
            }
        }
        else {
            if self.index != 0 {
                self.index -= 1
            }
        }
        if self.index == 1 {
            self.offset = self.width
        }
        else if self.index == 2 {
            self.offset = 0
        }
        else {
            self.offset = -self.width
        }
        // change the width based on the sisze of the tabs...
    }
}

struct AppBar : View { //버튼을 담고있는 바
    
    @Binding var index : Int
    @Binding var offset : CGFloat
    var width = UIScreen.main.bounds.width
    
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Home")
                .font(.title)
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.bottom)
            
            HStack 	{
                Button (action: {
                    self.index = 1
                    self.offset = self.width
                }) {
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            Image("Home")
                                .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.6))
                            Text("Home")
                                .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.6))
                        }
                        Capsule()
                            .fill(self.index == 1 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button (action: {
                    self.index = 2
                    self.offset = 0
                }) {
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            Image("Search")
                                .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.6))
                            Text("Search")
                                .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.6))
                        }
                        Capsule()
                            .fill(self.index == 2 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                Button (action: {
                    self.index = 3
                    self.offset = -self.width
                }) {
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            Image("Profile")
                                .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.6))
                            Text("Account")
                                .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.6))
                        }
                        Capsule()
                            .fill(self.index == 3 ? Color.white : Color.clear)
                            .frame(height: 4)
                    }
                }
            }
        })
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15) //yh
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.red)
    }
}

struct First : View { //첫번째 뷰
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(1...5   , id: \.self) {i in
                    Image("p\(i)")
                    .resizable()
                    .frame(height: 250)
                    .cornerRadius(15)
                    .padding(.top)
                    .padding(.horizontal)
                }
            }
        }
        .padding(.bottom, 18) //보이지않는 화면 아래로 스크롤이 내려감
    }
}

struct Scnd : View { //두번째 뷰
    var body: some View {
        GeometryReader {_ in
            VStack {
                Text("Second View")
            }
        }
        .background(Color.white)
    }
}

struct Third : View { //세번째 뷰
    var body: some View {
        GeometryReader {_ in
            VStack {
                Text("Third View")
            }
        }
        .background(Color.white)
    }
}
