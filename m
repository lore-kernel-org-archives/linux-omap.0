From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] mfd: twl4030-audio: fix sibling-node lookup
Date: Sat, 11 Nov 2017 16:38:43 +0100
Message-ID: <20171111153844.16741-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

A helper purported to look up a child node based on its name was using
the wrong of-helper and ended up prematurely freeing the parent of-node
while leaking any matching node.

To make things worse, any matching node would not even necessarily be a
child node as the whole device tree was searched depth-first starting at
the parent.

Fixes: 019a7e6b7b31 ("mfd: twl4030-audio: Add DT support")
Cc: stable <stable@vger.kernel.org>     # 3.7
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl4030-audio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index da16bf45fab4..dc94ffc6321a 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -159,13 +159,18 @@ unsigned int twl4030_audio_get_mclk(void)
 EXPORT_SYMBOL_GPL(twl4030_audio_get_mclk);
 
 static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
-			      struct device_node *node)
+			      struct device_node *parent)
 {
+	struct device_node *node;
+
 	if (pdata && pdata->codec)
 		return true;
 
-	if (of_find_node_by_name(node, "codec"))
+	node = of_get_child_by_name(parent, "codec");
+	if (node) {
+		of_node_put(node);
 		return true;
+	}
 
 	return false;
 }
-- 
2.15.0
