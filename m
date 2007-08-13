From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 20/52] musb_hdrc: Search and replace _pthis with _musb
Date: Mon, 13 Aug 2007 06:48:55 -0700
Message-ID: <11870130183634-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130153038-git-send-email-tony@atomide.com>
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

Search and replace _pthis with musb

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -236,10 +236,10 @@ enum musb_g_ep0_state {
 
 /****************************** FUNCTIONS ********************************/
 
-#define MUSB_HST_MODE(_pthis)\
-	{ (_pthis)->bIsHost=TRUE; }
-#define MUSB_DEV_MODE(_pthis) \
-	{ (_pthis)->bIsHost=FALSE; }
+#define MUSB_HST_MODE(_musb)\
+	{ (_musb)->bIsHost=TRUE; }
+#define MUSB_DEV_MODE(_musb) \
+	{ (_musb)->bIsHost=FALSE; }
 
 #define test_devctl_hst_mode(_x) \
 	(musb_readb((_x)->mregs, MGC_O_HDRC_DEVCTL)&MGC_M_DEVCTL_HM)
-- 
1.5.2.3
