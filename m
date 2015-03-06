From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 4/7] drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_endpoint
Date: Fri, 6 Mar 2015 17:36:32 +0200
Message-ID: <e0701e8376cd917fb2640fea18713b5b434677e5.1425656120.git.jsarha@ti.com>
References: <cover.1425656120.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35047 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080AbbCFPhN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 10:37:13 -0500
In-Reply-To: <cover.1425656120.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

This patch should be dropped/reverterd if/after "of: Decrement refcount
of previous endpoint in of_graph_get_next_endpoint" patch has been
merged.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_external.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
index 61f8aee..1dd6c20 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -83,6 +83,7 @@ int tilcdc_get_external_components(struct device *dev,
 		struct device_node *node;
 
 		node = of_graph_get_remote_port_parent(ep);
+		of_node_put(ep);
 		if (!node && !of_device_is_available(node)) {
 			of_node_put(node);
 			continue;
-- 
1.9.1

