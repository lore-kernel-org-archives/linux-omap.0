From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right DMA method
Date: Sun,  2 Oct 2011 16:45:45 +0200
Message-ID: <1317566760-25681-16-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53644 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab1JBOrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Oct 2011 10:47:07 -0400
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>

The logic to allow only one DMA driver in MUSB is currently
flawed, because it also allows picking no DMA driver at all
and also not selecting PIO mode.

Using a choice statement makes this foolproof for now and
also simplifies the Makefile.

Unfortunately, we will have to revisit this when we start
supporting multiple ARM platforms in a single kernel binary,
because at that point we will actually need to select
multiple DMA drivers and pick the right one at run-time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/Kconfig  |   57 ++++++++++++++++++++++++++------------------
 drivers/usb/musb/Makefile |   26 +++-----------------
 2 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index fc34b8b..d596fb2 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -64,46 +64,57 @@ config USB_MUSB_UX500
 
 endchoice
 
-config MUSB_PIO_ONLY
-	bool 'Disable DMA (always use PIO)'
-	depends on USB_MUSB_HDRC
-	default USB_MUSB_TUSB6010 || USB_MUSB_DA8XX || USB_MUSB_AM35X
+choice
+	prompt 'MUSB DMA mode'
+	default USB_UX500_DMA if USB_MUSB_UX500
+	default USB_INVENTRA_DMA if USB_MUSB_OMAP2PLUS || USB_MUSB_BLACKFIN
+	default USB_TI_CPPI_DMA if USB_MUSB_DAVINCI
+	default USB_TUSB_OMAP_DMA if USB_MUSB_TUSB6010
+	default MUSB_PIO_ONLY if USB_MUSB_TUSB6010 || USB_MUSB_DA8XX || USB_MUSB_AM35X
 	help
-	  All data is copied between memory and FIFO by the CPU.
-	  DMA controllers are ignored.
-
-	  Do not select 'n' here unless DMA support for your SOC or board
-	  is unavailable (or unstable).  When DMA is enabled at compile time,
-	  you can still disable it at run time using the "use_dma=n" module
-	  parameter.
+	  Unfortunately, only one option can be enabled here. Ideally one
+	  should be able to build all these drivers into one kernel to
+	  allow using DMA on multiplatform kernels.
 
 config USB_UX500_DMA
-	bool
-	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default USB_MUSB_UX500
+	bool 'ST Ericsson U8500 and U5500'
+	depends on USB_MUSB_HDRC
+	depends on USB_MUSB_UX500
 	help
 	  Enable DMA transfers on UX500 platforms.
 
 config USB_INVENTRA_DMA
-	bool
-	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default USB_MUSB_OMAP2PLUS || USB_MUSB_BLACKFIN
+	bool 'Inventra'
+	depends on USB_MUSB_HDRC
+	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_BLACKFIN
 	help
 	  Enable DMA transfers using Mentor's engine.
 
 config USB_TI_CPPI_DMA
-	bool
-	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default USB_MUSB_DAVINCI
+	bool 'TI CPPI (Davinci)'
+	depends on USB_MUSB_HDRC
+	depends on USB_MUSB_DAVINCI
 	help
 	  Enable DMA transfers when TI CPPI DMA is available.
 
 config USB_TUSB_OMAP_DMA
-	bool
-	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
+	bool 'TUSB 6010'
+	depends on USB_MUSB_HDRC
 	depends on USB_MUSB_TUSB6010
 	depends on ARCH_OMAP
-	default y
 	help
 	  Enable DMA transfers on TUSB 6010 when OMAP DMA is available.
 
+config MUSB_PIO_ONLY
+	bool 'Disable DMA (always use PIO)'
+	depends on USB_MUSB_HDRC
+	help
+	  All data is copied between memory and FIFO by the CPU.
+	  DMA controllers are ignored.
+
+	  Do not choose this unless DMA support for your SOC or board
+	  is unavailable (or unstable).  When DMA is enabled at compile time,
+	  you can still disable it at run time using the "use_dma=n" module
+	  parameter.
+
+endchoice
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index d8fd9d0..88bfb9d 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -24,25 +24,7 @@ obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
 # PIO only, or DMA (several potential schemes).
 # though PIO is always there to back up DMA, and for ep0
 
-ifneq ($(CONFIG_MUSB_PIO_ONLY),y)
-
-  ifeq ($(CONFIG_USB_INVENTRA_DMA),y)
-    musb_hdrc-y			+= musbhsdma.o
-
-  else
-    ifeq ($(CONFIG_USB_TI_CPPI_DMA),y)
-      musb_hdrc-y		+= cppi_dma.o
-
-    else
-      ifeq ($(CONFIG_USB_TUSB_OMAP_DMA),y)
-	musb_hdrc-y		+= tusb6010_omap.o
-
-      else
-        ifeq ($(CONFIG_USB_UX500_DMA),y)
-	  musb_hdrc-y		+= ux500_dma.o
-
-        endif
-      endif
-    endif
-  endif
-endif
+musb_hdrc-$(CONFIG_USB_INVENTRA_DMA)		+= musbhsdma.o
+musb_hdrc-$(CONFIG_USB_TI_CPPI_DMA)		+= cppi_dma.o
+musb_hdrc-$(CONFIG_USB_TUSB_OMAP_DMA)		+= tusb6010_omap.o
+musb_hdrc-$(CONFIG_USB_UX500_DMA)		+= ux500_dma.o
-- 
1.7.5.4

