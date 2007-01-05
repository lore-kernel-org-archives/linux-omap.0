From: "Andrzej Zaborowski" <balrog@zabor.org>
Subject: [PATCH] Make omap_bl build again after API change.
Date: Fri,  5 Jan 2007 01:26:27 +0100
Message-ID: <1167956787968-git-send-email-balrog@zabor.org>
Reply-To: balrogg@gmail.com
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

[Oops, I sent this to Dirk eariler and forgot to CC the list.]
Make omap_bl build again after API change.

Breakage spotted by Dirk Behme.
Also remove comment about API glitch which has just been fixed.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
---
 drivers/video/backlight/omap_bl.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/omap_bl.c b/drivers/video/backlight/omap_bl.c
index 22189b1..3b57b27 100644
--- a/drivers/video/backlight/omap_bl.c
+++ b/drivers/video/backlight/omap_bl.c
@@ -152,12 +152,8 @@ static int omapbl_probe(struct platform_
 	if (unlikely(!bl))
 		return -ENOMEM;
 
-	/* REVISIT backlight API glitch:  we can't associate the
-	 * class device with "pdev" ... probably pass &pdev->dev
-	 * instead of a string.
-	 */
-
-	dev = backlight_device_register("omap-bl", bl, &omapbl_data);
+	dev = backlight_device_register("omap-bl", &pdev->dev,
+			bl, &omapbl_data);
 	if (IS_ERR(dev)) {
 		kfree(bl);
 		return PTR_ERR(dev);
-- 
1.4.3.2
