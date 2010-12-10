From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/8 V3] usb: musb: TWL6030: Selecting TWL6030_USB transceiver
Date: Fri, 10 Dec 2010 18:09:35 +0530
Message-ID: <1291984775-25919-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Selecting the twl6030-usb for OMAP4430SDP and OMAP4PANDA boards and
adding OMAP4 internal phy code for compilation

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/Makefile |    6 ++++--
 drivers/usb/musb/Kconfig     |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: usb/arch/arm/mach-omap2/Makefile
===================================================================
--- usb.orig/arch/arm/mach-omap2/Makefile
+++ usb/arch/arm/mach-omap2/Makefile
@@ -168,9 +168,11 @@ obj-$(CONFIG_MACH_IGEP0030)		+= board-ig
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
-					   hsmmc.o
+					   hsmmc.o \
+					   omap_phy_internal.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
-					   hsmmc.o
+					   hsmmc.o \
+					   omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
 
Index: usb/drivers/usb/musb/Kconfig
===================================================================
--- usb.orig/drivers/usb/musb/Kconfig
+++ usb/drivers/usb/musb/Kconfig
@@ -12,6 +12,7 @@ config USB_MUSB_HDRC
 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
 	select TWL4030_USB if MACH_OMAP_3430SDP
+	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
 	select USB_OTG_UTILS
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
 	help
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
