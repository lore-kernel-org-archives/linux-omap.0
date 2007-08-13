From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 28/52] musb_hdrc: Search and replace bIgnoreDisconnect with
	ignore_disconnect
Date: Mon, 13 Aug 2007 06:49:03 -0700
Message-ID: <11870130371106-git-send-email-tony@atomide.com>
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
	<1187013022688-git-send-email-tony@atomide.com>
	<1187013024836-git-send-email-tony@atomide.com>
	<11870130272865-git-send-email-tony@atomide.com>
	<1187013029823-git-send-email-tony@atomide.com>
	<11870130314189-git-send-email-tony@atomide.com>
	<11870130343298-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130343298-git-send-email-tony@atomide.com>
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

Search and replace bIgnoreDisconnect with ignore_disconnect

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h |    2 +-
 drivers/usb/musb/plat_uds.c |    2 +-
 drivers/usb/musb/virthub.c  |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -397,7 +397,7 @@ struct musb {
 
 	unsigned is_multipoint:1;
 	unsigned is_host:1;
-	unsigned bIgnoreDisconnect:1;	/* during bus resets */
+	unsigned ignore_disconnect:1;	/* during bus resets */
 
 	int			a_wait_bcon;	/* VBUS timeout in msecs */
 	unsigned long		idle_timeout;	/* Next timeout in jiffies */
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -690,7 +690,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 	}
 #endif
 
-	if ((bIntrUSB & MGC_M_INTR_DISCONNECT) && !musb->bIgnoreDisconnect) {
+	if ((bIntrUSB & MGC_M_INTR_DISCONNECT) && !musb->ignore_disconnect) {
 		DBG(1, "DISCONNECT (%s) as %s, devctl %02x\n",
 				otg_state_string(musb),
 				MUSB_MODE(musb), devctl);
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -145,7 +145,7 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 			msleep(1);
 		}
 
-		musb->bIgnoreDisconnect = TRUE;
+		musb->ignore_disconnect = TRUE;
 		power &= 0xf0;
 		musb_writeb(mbase, MGC_O_HDRC_POWER,
 				power | MGC_M_POWER_RESET);
@@ -158,7 +158,7 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 		musb_writeb(mbase, MGC_O_HDRC_POWER,
 				power & ~MGC_M_POWER_RESET);
 
-		musb->bIgnoreDisconnect = FALSE;
+		musb->ignore_disconnect = FALSE;
 
 		power = musb_readb(mbase, MGC_O_HDRC_POWER);
 		if (power & MGC_M_POWER_HSMODE) {
-- 
1.5.2.3
