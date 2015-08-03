From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: musb: Allow building in all the DMA code
Date: Mon,  3 Aug 2015 05:37:10 -0700
Message-ID: <1438605430-26435-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With recent changes to MUSB code, we can now now get rid of
the Kconfig choise for the DMA code and allow building in any
of the desired DMA code. This makes life easier for distros.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

This should be safe to dow now. Felipe, I've ran some randcocnfig
builds on it but it's probably a good idea to run some more.

---
 drivers/usb/musb/Kconfig | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -124,19 +124,20 @@ config USB_MUSB_JZ4740
 config USB_MUSB_AM335X_CHILD
 	tristate
 
-choice
-	prompt 'MUSB DMA mode'
-	default MUSB_PIO_ONLY if ARCH_MULTIPLATFORM || USB_MUSB_JZ4740
-	default USB_UX500_DMA if USB_MUSB_UX500
-	default USB_INVENTRA_DMA if USB_MUSB_OMAP2PLUS || USB_MUSB_BLACKFIN
-	default USB_TI_CPPI_DMA if USB_MUSB_DAVINCI
-	default USB_TUSB_OMAP_DMA if USB_MUSB_TUSB6010
-	default MUSB_PIO_ONLY if USB_MUSB_TUSB6010 || USB_MUSB_DA8XX || USB_MUSB_AM35X \
-				|| USB_MUSB_DSPS
+comment "MUSB DMA mode"
+
+config MUSB_PIO_ONLY
+	bool 'Disable DMA (always use PIO)'
 	help
-	  Unfortunately, only one option can be enabled here. Ideally one
-	  should be able to build all these drivers into one kernel to
-	  allow using DMA on multiplatform kernels.
+	  All data is copied between memory and FIFO by the CPU.
+	  DMA controllers are ignored.
+
+	  Do not choose this unless DMA support for your SOC or board
+	  is unavailable (or unstable).  When DMA is enabled at compile time,
+	  you can still disable it at run time using the "use_dma=n" module
+	  parameter.
+
+if !MUSB_PIO_ONLY
 
 config USB_UX500_DMA
 	bool 'ST Ericsson Ux500'
@@ -168,17 +169,6 @@ config USB_TUSB_OMAP_DMA
 	help
 	  Enable DMA transfers on TUSB 6010 when OMAP DMA is available.
 
-config MUSB_PIO_ONLY
-	bool 'Disable DMA (always use PIO)'
-	help
-	  All data is copied between memory and FIFO by the CPU.
-	  DMA controllers are ignored.
-
-	  Do not choose this unless DMA support for your SOC or board
-	  is unavailable (or unstable).  When DMA is enabled at compile time,
-	  you can still disable it at run time using the "use_dma=n" module
-	  parameter.
