From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH 0/3] ARM: dts: am335x-chili*: Move nodes to proper place and add poweroff
Date: Wed, 13 Apr 2016 10:44:14 +0200
Message-ID: <1460537057-23513-1-git-send-email-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

These patches move board-specific device-tree nodes from ChiliSOM to
ChiliBoard dts files. These include uart and ethernet configuration.
Additionally add poweroff support for all ChiliSOM devices.

Developed and tested on ChiliBoard using v4.6-rc3.

Marcin Niestroj (3):
  ARM: dts: am335x-chili*: Move uart0 description from SOM to board
  ARM: dts: am335x-chili*: Move Ethernet MAC description from SOM to
    board
  ARM: dts: am335x-chilisom: Enable poweroff PMIC sequence using RTC
    signal

 arch/arm/boot/dts/am335x-chiliboard.dts | 75 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-chilisom.dtsi  | 76 +--------------------------------
 2 files changed, 77 insertions(+), 74 deletions(-)

-- 
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
