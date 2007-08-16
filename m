From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 22/36] musb_hdrc: Search and replace wBestDiff with best_diff
Date: Thu, 16 Aug 2007 02:40:45 -0700
Message-ID: <1187257311394-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
	<11872573092269-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573092269-git-send-email-tony@atomide.com>
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

Search and replace wBestDiff with best_diff

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 837fbbf..397b2f0 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1660,7 +1660,7 @@ static int musb_schedule(
 	int			is_in)
 {
 	int			idle;
-	int			wBestDiff;
+	int			best_diff;
 	int			nBestEnd, nEnd;
 	struct musb_hw_ep	*hw_ep = NULL;
 	struct list_head	*head = NULL;
@@ -1703,7 +1703,7 @@ static int musb_schedule(
 	 * that simplistic approach makes TT scheduling a lot simpler;
 	 * there is none, and thus none of its complexity...
 	 */
-	wBestDiff = 4096;
+	best_diff = 4096;
 	nBestEnd = -1;
 
 	for (nEnd = 1; nEnd < musb->nr_endpoints; nEnd++) {
@@ -1720,8 +1720,8 @@ static int musb_schedule(
 		else
 			diff = hw_ep->max_packet_sz_tx - qh->maxpacket;
 
-		if (diff > 0 && wBestDiff > diff) {
-			wBestDiff = diff;
+		if (diff > 0 && best_diff > diff) {
+			best_diff = diff;
 			nBestEnd = nEnd;
 		}
 	}
-- 
1.5.2.3
