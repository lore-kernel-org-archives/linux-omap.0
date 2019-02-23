From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 06/12] omapfb: add missing of_node_put after of_device_is_available
Date: Sat, 23 Feb 2019 14:20:37 +0100
Message-ID: <1550928043-14889-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add an of_node_put when a tested device node is not available.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
identifier f;
local idexpression e;
expression x;
@@

e = f(...);
... when != of_node_put(e)
    when != x = e
    when != e = x
    when any
if (<+...of_device_is_available(e)...+>) {
  ... when != of_node_put(e)
(
  return e;
|
+ of_node_put(e);
  return ...;
)
}
// </smpl>

Fixes: f76ee892a99e6 ("omapfb: copy omapdss & displays for omapfb")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -u -p a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
--- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
@@ -193,8 +193,10 @@ static int __init omapdss_boot_init(void
 
 	dss = of_find_matching_node(NULL, omapdss_of_match);
 
-	if (dss == NULL || !of_device_is_available(dss))
+	if (dss == NULL || !of_device_is_available(dss)) {
+		of_node_put(dss);
 		return 0;
+	}
 
 	omapdss_walk_device(dss, true);
 
