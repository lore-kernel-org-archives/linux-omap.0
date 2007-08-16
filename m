From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 23/36] musb_hdrc: Search and replace nBestEnd with best_end
Date: Thu, 16 Aug 2007 02:40:46 -0700
Message-ID: <11872573133142-git-send-email-tony@atomide.com>
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
	<1187257311394-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1187257311394-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace nBestEnd with best_end

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 397b2f0..743284d 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1661,7 +1661,7 @@ static int musb_schedule(
 {
 	int			idle;
 	int			best_diff;
-	int			nBestEnd, nEnd;
+	int			best_end, nEnd;
 	struct musb_hw_ep	*hw_ep = NULL;
 	struct list_head	*head = NULL;
 
@@ -1704,7 +1704,7 @@ static int musb_schedule(
 	 * there is none, and thus none of its complexity...
 	 */
 	best_diff = 4096;
-	nBestEnd = -1;
+	best_end = -1;
 
 	for (nEnd = 1; nEnd < musb->nr_endpoints; nEnd++) {
 		int	diff;
@@ -1722,16 +1722,16 @@ static int musb_schedule(
 
 		if (diff > 0 && best_diff > diff) {
 			best_diff = diff;
-			nBestEnd = nEnd;
+			best_end = nEnd;
 		}
 	}
-	if (nBestEnd < 0)
+	if (best_end < 0)
 		return -ENOSPC;
 
 	idle = 1;
-	hw_ep = musb->endpoints + nBestEnd;
-	musb->periodic[nBestEnd] = qh;
-	DBG(4, "qh %p periodic slot %d\n", qh, nBestEnd);
+	hw_ep = musb->endpoints + best_end;
+	musb->periodic[best_end] = qh;
+	DBG(4, "qh %p periodic slot %d\n", qh, best_end);
 success:
 	qh->hw_ep = hw_ep;
 	qh->hep->hcpriv = qh;
-- 
1.5.2.3
