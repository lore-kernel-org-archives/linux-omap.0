From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC patch] ARM: OMAP: Fix typo in drivers/usb/musb/Kconfig
Date: Mon, 19 Nov 2007 03:42:00 +0200
Message-ID: <1195436521-10519-3-git-send-email-felipe.lima@indt.org.br>
References: <1195436521-10519-1-git-send-email-felipe.lima@indt.org.br>
	<1195436521-10519-2-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1195436521-10519-2-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: david-b@pacbel.net
List-Id: linux-omap@vger.kernel.org

We don't have ARCH_OMAP343X. Change to ARCH_OMAP34XX

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/usb/musb/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 2e030b9..c795b01 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -30,7 +30,7 @@ config USB_MUSB_SOC
 	depends on USB_MUSB_HDRC
 	default y if ARCH_DAVINCI
 	default y if ARCH_OMAP2430
-	default y if ARCH_OMAP343X
+	default y if ARCH_OMAP34XX
 	help
 	  Use a static <asm/arch/hdrc_cnf.h> file to describe how the
 	  controller is configured (endpoints, mechanisms, etc) on the
@@ -43,7 +43,7 @@ comment "OMAP 243x high speed USB support"
 	depends on USB_MUSB_HDRC && ARCH_OMAP2430
 
 comment "OMAP 343x high speed USB support"
-	depends on USB_MUSB_HDRC && ARCH_OMAP343X
+	depends on USB_MUSB_HDRC && ARCH_OMAP34XX
 
 config USB_TUSB6010
 	boolean "TUSB 6010 support"
@@ -145,7 +145,7 @@ config MUSB_PIO_ONLY
 config USB_INVENTRA_DMA
 	bool
 	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default ARCH_OMAP2430 || ARCH_OMAP343X
+	default ARCH_OMAP2430 || ARCH_OMAP34XX
 	help
 	  Enable DMA transfers using Mentor's engine.
 
-- 
1.5.3.5.666.gfb5f
