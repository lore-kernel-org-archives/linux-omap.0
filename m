From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] mfd: twl6040: fix child-node lookup
Date: Sat, 11 Nov 2017 16:38:44 +0100
Message-ID: <20171111153844.16741-2-johan@kernel.org>
References: <20171111153844.16741-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171111153844.16741-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent node was prematurely freed, while the
child node was leaked.

Note that the CONFIG_OF compile guard can be removed as
of_get_child_by_name() provides a !CONFIG_OF implementation which always
fails.

Fixes: 37e13cecaa14 ("mfd: Add support for Device Tree to twl6040")
Fixes: ca2cad6ae38e ("mfd: Fix twl6040 build failure")
Cc: stable <stable@vger.kernel.org>     # 3.5
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl6040.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index d66502d36ba0..dd19f17a1b63 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -97,12 +97,16 @@ static struct reg_sequence twl6040_patch[] = {
 };
 
 
-static bool twl6040_has_vibra(struct device_node *node)
+static bool twl6040_has_vibra(struct device_node *parent)
 {
-#ifdef CONFIG_OF
-	if (of_find_node_by_name(node, "vibra"))
+	struct device_node *node;
+
+	node = of_get_child_by_name(parent, "vibra");
+	if (node) {
+		of_node_put(node);
 		return true;
-#endif
+	}
+
 	return false;
 }
 
-- 
2.15.0
