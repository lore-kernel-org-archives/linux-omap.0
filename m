From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] musb_hdrc: Allow more time for HNP as a_wait_bcon
Date: Sun, 21 Oct 2007 16:20:54 -0700
Message-ID: <11930088611788-git-send-email-tony@atomide.com>
References: musb-2007-10-21 <119300885686-git-send-email-tony@atomide.com>
	<11930088583835-git-send-email-tony@atomide.com>
	<11930088592326-git-send-email-tony@atomide.com>
	<11930088601320-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11930088601320-git-send-email-tony@atomide.com>
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

Allow more time for HNP as a_wait_bcon

Signed-off-by: Tony Lindgren <tony@atomide.com>

---
 drivers/usb/musb/musb_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 33774a6..29732a8 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -668,7 +668,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 						otg_state_string(musb));
 				musb_otg_timer.data = (unsigned long)musb;
 				mod_timer(&musb_otg_timer, jiffies
-					+ msecs_to_jiffies(100));
+					+ msecs_to_jiffies(2000));
 				break;
 			case OTG_STATE_A_PERIPHERAL:
 				musb_hnp_stop(musb);
-- 
1.5.2.5
