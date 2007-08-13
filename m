From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 22/52] musb_hdrc: Get rid of old unused MUSB_EpFifoDescriptor
Date: Mon, 13 Aug 2007 06:48:57 -0700
Message-ID: <1187013022688-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
	<11870129934099-git-send-email-tony@atomide.com>
	<1187012995338-git-send-email-tony@atomide.com>
	<1187012998290-git-send-email-tony@atomide.com>
	<1187013000811-git-send-email-tony@atomide.com>
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
	<1187013007355-git-send-email-tony@atomide.com>
	<11870130103320-git-send-email-tony@atomide.com>
	<11870130122117-git-send-email-tony@atomide.com>
	<11870130153038-git-send-email-tony@atomide.com>
	<11870130183634-git-send-email-tony@atomide.com>
	<11870130203742-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130203742-git-send-email-tony@atomide.com>
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

Get rid of old unused MUSB_EpFifoDescriptor

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -246,26 +246,6 @@ enum musb_g_ep0_state {
 
 #define MUSB_MODE(musb) ((musb)->is_host ? "Host" : "Peripheral")
 
-/************************** Ep Configuration ********************************/
-
-/** The End point descriptor */
-struct MUSB_EpFifoDescriptor {
-	u8 bType;		/* 0 for autoconfig, CNTR, ISOC, BULK, INTR */
-	u8 bDir;		/* 0 for autoconfig, INOUT, IN, OUT */
-	int wSize;		/* 0 for autoconfig, or the size */
-};
-
-#define MUSB_EPD_AUTOCONFIG	0
-
-#define MUSB_EPD_T_CNTRL	1
-#define MUSB_EPD_T_ISOC		2
-#define MUSB_EPD_T_BULK		3
-#define MUSB_EPD_T_INTR		4
-
-#define MUSB_EPD_D_INOUT	0
-#define MUSB_EPD_D_TX		1
-#define MUSB_EPD_D_RX		2
-
 /******************************** TYPES *************************************/
 
 /*
-- 
1.5.2.3
