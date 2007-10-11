From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/12] musb_hdrc: Don't idle as host if VBUS timeout is 0
Date: Thu, 11 Oct 2007 10:05:20 -0700
Message-ID: <11921223331118-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223321890-git-send-email-tony@atomide.com>
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

VBUS must be on all the time in this case.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 16eaa48..3008b6d 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -482,7 +482,9 @@ void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
 	if (timeout == 0)
 		timeout = default_timeout;
 
-	if (musb->is_active) {
+	/* Never idle if active, or when VBUS timeout is not set as host */
+	if (musb->is_active || ((musb->a_wait_bcon == 0)
+			&& (musb->xceiv.state == OTG_STATE_A_WAIT_BCON))) {
 		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
 		del_timer(&musb_idle_timer);
 		last_timer = jiffies;
-- 
1.5.2.5
