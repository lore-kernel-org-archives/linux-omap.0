From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: am335x: no multicast reception over VLAN
Date: Wed, 16 Mar 2016 16:05:24 +0100
Message-ID: <CAGm1_ktOqB4QBMy2G4XeHTkaP+WvG8GOc8maVv3dDoxM+-F+ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev <netdev@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "N, Mugunthan V" <mugunthanvnm@ti.com>, drivshin@allworx.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

I have an am335x based board using CPSW in Dual EMAC mode. Without
VLAN IDs I can receive and send multicast packets [1]. When I create
VLAN ID:

ip link add link eth1 name eth1.100 type vlan id 100
ip addr add 192.168.100.2/24 brd 192.168.100.255 dev eth1.100
route add -net 224.0.0.0 netmask 224.0.0.0 eth1.100

I can successfully send multicast packets, but not receive them. On
the other side of the Ethernet cable I've used Pandaboard. Pandaboard
could both receive and send multicast packets via VLAN.

This setup was tested with both 3.18.21 and 4.5 kernels.

Any idea?

[1] https://pymotw.com/2/socket/multicast.html

Regards,
Yegor
