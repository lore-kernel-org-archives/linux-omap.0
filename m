From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/12] musb_hdrc: Allow suspend if host is already suspended
Date: Thu, 11 Oct 2007 10:05:24 -0700
Message-ID: <11921223392718-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
	<11921223352146-git-send-email-tony@atomide.com>
	<11921223372253-git-send-email-tony@atomide.com>
	<11921223381405-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223381405-git-send-email-tony@atomide.com>
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

Allow suspend if host is already suspended

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 091ae8f..4eeff91 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2128,6 +2128,9 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 {
 	struct musb	*musb = hcd_to_musb(hcd);
 
+	if (musb->xceiv.state == OTG_STATE_A_SUSPEND)
+		return 0;
+
 	if (is_host_active(musb) && musb->is_active) {
 		WARN("trying to suspend as %s is_active=%i\n",
 			otg_state_string(musb), musb->is_active);
-- 
1.5.2.5
