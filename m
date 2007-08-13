From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 21/52] musb_hdrc: Search and replace bIsHost with is_host
Date: Mon, 13 Aug 2007 06:48:56 -0700
Message-ID: <11870130203742-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130183634-git-send-email-tony@atomide.com>
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

Search and replace bIsHost with is_host

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -85,8 +85,8 @@ struct musb_ep;
 /* NOTE:  otg and peripheral-only state machines start at B_IDLE.
  * OTG or host-only go to A_IDLE when ID is sensed.
  */
-#define is_peripheral_active(m)		(!(m)->bIsHost)
-#define is_host_active(m)		((m)->bIsHost)
+#define is_peripheral_active(m)		(!(m)->is_host)
+#define is_host_active(m)		((m)->is_host)
 
 #else
 #define	is_peripheral_enabled(musb)	is_peripheral_capable()
@@ -237,14 +237,14 @@ enum musb_g_ep0_state {
 /****************************** FUNCTIONS ********************************/
 
 #define MUSB_HST_MODE(_musb)\
-	{ (_musb)->bIsHost=TRUE; }
+	{ (_musb)->is_host=TRUE; }
 #define MUSB_DEV_MODE(_musb) \
-	{ (_musb)->bIsHost=FALSE; }
+	{ (_musb)->is_host=FALSE; }
 
 #define test_devctl_hst_mode(_x) \
 	(musb_readb((_x)->mregs, MGC_O_HDRC_DEVCTL)&MGC_M_DEVCTL_HM)
 
-#define MUSB_MODE(musb) ((musb)->bIsHost ? "Host" : "Peripheral")
+#define MUSB_MODE(musb) ((musb)->is_host ? "Host" : "Peripheral")
 
 /************************** Ep Configuration ********************************/
 
@@ -416,7 +416,7 @@ struct musb {
 	unsigned		is_active:1;
 
 	unsigned bIsMultipoint:1;
-	unsigned bIsHost:1;
+	unsigned is_host:1;
 	unsigned bIgnoreDisconnect:1;	/* during bus resets */
 
 	int			a_wait_bcon;	/* VBUS timeout in msecs */
-- 
1.5.2.3
