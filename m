From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 0/6] ARM: dts: am57xx: cl-som-am57x: set of non critical DT fixes
Date: Wed, 30 Dec 2015 15:38:59 +0200
Message-ID: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This pacth set apply a set of non critical DT fixes for CompuLab CL-SOM-AM57x SoM

* Improve Eth functionality
* Pinmux fix for several devices
* Improve SPI flash access
* Set USB2 in HOST mode to enable connection of keyboard/mouse on eval board

Dmitry Lifshitz (6):
  ARM: dts: am57xx: sbc-am57x: fix SB-SOM EEPROM I2C address
  ARM: dts: am57xx: cl-som-am57x: set HOST mode for USB2
  ARM: dts: am57xx: cl-som-am57x: update SPI Flash frequency
  ARM: dts: am57xx: sbc-am57x: fix UART3 pinmux
  ARM: dts: am57xx: cl-som-am57x: fix CPSW EMAC pinmux
  ARM: dts: am57xx: sbc-am57x: correct Eth PHY settings

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 12 ++++++------
 arch/arm/boot/dts/am57xx-sbc-am57x.dts    |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
