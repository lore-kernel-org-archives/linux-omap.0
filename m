From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/5] ARM: dts: OMAP2+: Enable USB dual-role on supported boards
Date: Wed, 8 Jul 2015 13:42:29 +0300
Message-ID: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Enables dual-role feaure on supported boards.

Depends on
[1] - core USB DRD support - http://thread.gmane.org/gmane.linux.kernel/1991413
[2] - dwc3 DRD support - http://thread.gmane.org/gmane.linux.usb.general/127890

Tested on am437x-gp-evm and dra7-evm.

cheers,
-roger

Felipe Balbi (1):
  ARM: dts: am4372: Add named interrupt property for dwc3

Roger Quadros (4):
  ARM: dts: omap5: Add named interrupt property for dwc3
  ARM: dts: dra7: Add named interrupt property for dwc3
  ARM: dts: dra7*-evm: Enable dual-role for usb1
  ARM: dts: am43xx: Enable dual-role on USB1

 arch/arm/boot/dts/am4372.dtsi        | 14 ++++++++++++--
 arch/arm/boot/dts/am437x-gp-evm.dts  |  2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts  |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts |  2 +-
 arch/arm/boot/dts/dra7-evm.dts       |  2 +-
 arch/arm/boot/dts/dra7.dtsi          | 21 ++++++++++++++++++---
 arch/arm/boot/dts/dra72-evm.dts      |  2 +-
 arch/arm/boot/dts/dra74x.dtsi        |  7 ++++++-
 arch/arm/boot/dts/omap5.dtsi         |  7 ++++++-
 9 files changed, 47 insertions(+), 12 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
