From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] usb: musb: enable support for am335x
Date: Mon, 26 Sep 2011 15:33:13 +0530
Message-ID: <1317031393-9333-3-git-send-email-ajay.gupta@ti.com>
References: <1317031393-9333-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1317031393-9333-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Enabled the flag so that musb_dsps glue file can be used for am335x

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index d6abdec..4e21aee 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -8,7 +8,7 @@ config USB_MUSB_HDRC
 	depends on USB && USB_GADGET
 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
-	select NOP_USB_XCEIV if SOC_OMAPTI81XX
+	select NOP_USB_XCEIV if (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
 	select TWL4030_USB if MACH_OMAP_3430SDP
 	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
 	select USB_OTG_UTILS
@@ -57,7 +57,7 @@ config USB_MUSB_AM35X
 
 config USB_MUSB_DSPS
 	tristate "TI DSPS platforms"
-	depends on SOC_OMAPTI81XX
+	depends on (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
 
 config USB_MUSB_BLACKFIN
 	tristate "Blackfin"
@@ -73,7 +73,7 @@ config MUSB_PIO_ONLY
 	bool 'Disable DMA (always use PIO)'
 	depends on USB_MUSB_HDRC
 	default USB_MUSB_TUSB6010 || USB_MUSB_DA8XX || USB_MUSB_AM35X
-	default SOC_OMAPTI81XX
+	default SOC_OMAPTI81XX || SOC_OMAPAM33XX
 	help
 	  All data is copied between memory and FIFO by the CPU.
 	  DMA controllers are ignored.
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
