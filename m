From: syzbot <syzbot+7b6206fb525c1f5ec3f8@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_port_ext_cleanup
Date: Sun, 19 Jan 2020 01:35:01 -0800
Message-ID: <00000000000095fe43059c7ae3f9@google.com>
References: <000000000000e0ab4c059c79f014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <000000000000e0ab4c059c79f014@google.com>
Sender: netdev-owner@vger.kernel.org
To: a@unstable.cc, andrew@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org, davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de, grygorii.strashko@ti.com, j-keerthy@ti.com, jeremy@azazel.net, johannes.berg@intel.com, kadlec@netfilter.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
List-Id: linux-omap@vger.kernel.org

syzbot has bisected this bug to:

commit 2f9b0d93a9d3ec64558537ab5d7cff820886afa4
Author: Keerthy <j-keerthy@ti.com>
Date:   Mon Jun 24 05:16:19 2019 +0000

    net: ethernet: ti: cpsw: Fix suspend/resume break

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fcf959e00000
start commit:   e02d9c4c Merge branch 'bnxt_en-fixes'
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1402f959e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1002f959e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=7b6206fb525c1f5ec3f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16551cc9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a04966e00000

Reported-by: syzbot+7b6206fb525c1f5ec3f8@syzkaller.appspotmail.com
Fixes: 2f9b0d93a9d3 ("net: ethernet: ti: cpsw: Fix suspend/resume break")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
