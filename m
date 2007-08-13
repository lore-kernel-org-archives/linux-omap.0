From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 35/52] musb_hdrc: Search and replace bDelayPortPowerOff with
	delay_port_power_off
Date: Mon, 13 Aug 2007 06:49:10 -0700
Message-ID: <11870130643220-git-send-email-tony@atomide.com>
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
	<11870130371106-git-send-email-tony@atomide.com>
	<11870130411622-git-send-email-tony@atomide.com>
	<1187013048432-git-send-email-tony@atomide.com>
	<11870130521115-git-send-email-tony@atomide.com>
	<11870130543254-git-send-email-tony@atomide.com>
	<11870130573814-git-send-email-tony@atomide.com>
	<1187013062890-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187013062890-git-send-email-tony@atomide.com>
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

Search and replace bDelayPortPowerOff with delay_port_power_off

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbdefs.h |    2 +-
 drivers/usb/musb/plat_uds.c |    2 +-
 drivers/usb/musb/virthub.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -451,7 +451,7 @@ struct musb {
 
 #ifdef CONFIG_USB_MUSB_OTG
 	/* FIXME this can't be OTG-specific ... ? */
-	u8 bDelayPortPowerOff;
+	u8 delay_port_power_off;
 #endif
 
 #ifdef MUSB_CONFIG_PROC_FS
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -557,7 +557,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 		if (is_peripheral_active(musb)) {
 			// REVISIT HNP; just force disconnect
 		}
-		musb->bDelayPortPowerOff = FALSE;
+		musb->delay_port_power_off = FALSE;
 		musb_writew(mbase, MGC_O_HDRC_INTRTXE, musb->wEndMask);
 		musb_writew(mbase, MGC_O_HDRC_INTRRXE, musb->wEndMask & 0xfffe);
 		musb_writeb(mbase, MGC_O_HDRC_INTRUSBE, 0xf7);
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -116,7 +116,7 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 	/* REVISIT this looks wrong for HNP */
 	u8 devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
 
-	if (musb->bDelayPortPowerOff || !(devctl & MGC_M_DEVCTL_HM)) {
+	if (musb->delay_port_power_off || !(devctl & MGC_M_DEVCTL_HM)) {
 		return;
 	}
 #endif
-- 
1.5.2.3
