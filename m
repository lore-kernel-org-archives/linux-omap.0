From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/8] musb_hdrc: Search and replace _bOffset with _offset
Date: Wed, 15 Aug 2007 07:21:42 -0700
Message-ID: <11871877214142-git-send-email-tony@atomide.com>
References: <11871877051923-git-send-email-tony@atomide.com>
	<11871877071348-git-send-email-tony@atomide.com>
	<1187187711983-git-send-email-tony@atomide.com>
	<1187187715940-git-send-email-tony@atomide.com>
	<11871877193281-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11871877193281-git-send-email-tony@atomide.com>
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

Search and replace _bOffset with _offset

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbhdrc.h  |   16 ++++++++--------
 drivers/usb/musb/musbhsdma.c |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
index 225fac9..c862e65 100644
--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -105,17 +105,17 @@
 #define MUSB_CONFIGDATA	MUSB_FIFOSIZE	/* re-used for EP0 */
 
 /* offsets to endpoint registers in indexed model (using INDEX register) */
-#define MGC_INDEXED_OFFSET(_epnum, _bOffset)	\
-	(0x10                   + (_bOffset))
+#define MGC_INDEXED_OFFSET(_epnum, _offset)	\
+	(0x10                   + (_offset))
 
 /* offsets to endpoint registers in flat models */
-#define MGC_FLAT_OFFSET(_epnum, _bOffset)	\
-	(0x100 + (0x10*(_epnum)) + (_bOffset))
+#define MGC_FLAT_OFFSET(_epnum, _offset)	\
+	(0x100 + (0x10*(_epnum)) + (_offset))
 
 #ifdef CONFIG_USB_TUSB6010
 /* TUSB6010 EP0 configuration register is special */
-#define MGC_TUSB_OFFSET(_epnum, _bOffset)	\
-	(0x10 + _bOffset)
+#define MGC_TUSB_OFFSET(_epnum, _offset)	\
+	(0x10 + _offset)
 #include "tusb6010.h"		/* needed "only" for TUSB_EP0_CONF */
 #endif
 
@@ -128,8 +128,8 @@
 #define MUSB_RXHUBADDR	0x06
 #define MUSB_RXHUBPORT	0x07
 
-#define MGC_BUSCTL_OFFSET(_epnum, _bOffset) \
-	(0x80 + (8*(_epnum)) + (_bOffset))
+#define MGC_BUSCTL_OFFSET(_epnum, _offset) \
+	(0x80 + (8*(_epnum)) + (_offset))
 
 /*
  *     MUSBHDRC Register bit masks
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 5292e2d..5b6a42f 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -50,8 +50,8 @@
 #define MGC_O_HSDMA_ADDRESS		0x8
 #define MGC_O_HSDMA_COUNT		0xc
 
-#define MGC_HSDMA_CHANNEL_OFFSET(_bChannel, _bOffset)		\
-		(MGC_O_HSDMA_BASE + (_bChannel << 4) + _bOffset)
+#define MGC_HSDMA_CHANNEL_OFFSET(_bChannel, _offset)		\
+		(MGC_O_HSDMA_BASE + (_bChannel << 4) + _offset)
 
 /* control register (16-bit): */
 #define MUSB_HSDMA_ENABLE_SHIFT		0
-- 
1.5.2.3
