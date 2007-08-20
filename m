From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] musb_hdrc: Search and replace USB_INVENTRA_HCD_LOGGING
	with USB_MUSB_LOGLEVEL
Date: Mon, 20 Aug 2007 02:10:20 -0700
Message-ID: <11876010322255-git-send-email-tony@atomide.com>
References: <11876010273160-git-send-email-tony@atomide.com>
	<11876010292224-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11876010292224-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace USB_INVENTRA_HCD_LOGGING with USB_MUSB_LOGLEVEL

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/Kconfig  |    2 +-
 drivers/usb/musb/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 8e5430a..ed800a0 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -165,7 +165,7 @@ config USB_TUSB_OMAP_DMA
 	help
 	  Enable DMA transfers on TUSB 6010 when OMAP DMA is available.
 
-config	USB_INVENTRA_HCD_LOGGING
+config	USB_MUSB_LOGLEVEL
 	depends on USB_MUSB_HDRC
 	int  'Logging Level (0 - none / 3 - annoying / ... )'
 	default 0
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index fbff415..93c3f40 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -60,7 +60,7 @@ endif
 
 # Debugging
 
-MUSB_DEBUG:=$(CONFIG_USB_INVENTRA_HCD_LOGGING)
+MUSB_DEBUG:=$(CONFIG_USB_MUSB_LOGLEVEL)
 
 ifeq ("$(strip $(MUSB_DEBUG))","")
     ifdef CONFIG_USB_DEBUG
-- 
1.5.2.3
