From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] omapfb: Fix potential NULL pointer dereference in kmalloc
Date: Sat,  2 Mar 2019 14:40:04 -0600
Message-ID: <20190302204006.9953-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Memory allocated, using kmalloc, for new_compat may fail. This patch
checks for such an error and prevents potential NULL pointer
dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
index 136d30484d02..0592c436b2da 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
@@ -111,6 +111,8 @@ static void __init omapdss_omapify_node(struct device_node *node)
 
 	new_len = prop->length + strlen(prefix) * num_strs;
 	new_compat = kmalloc(new_len, GFP_KERNEL);
+	if (!new_compat)
+		return;
 
 	omapdss_prefix_strcpy(new_compat, new_len, prop->value, prop->length);
 
-- 
2.17.1
