From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] mailbox/omap: use of_device_get_match_data() to get match data
Date: Wed, 11 Jul 2018 18:42:12 -0500
Message-ID: <20180711234212.7756-3-s-anna@ti.com>
References: <20180711234212.7756-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711234212.7756-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The OMAP Mailbox driver is directly using an integer value as
match data for distinguishing the interrupt register layout
between OMAP2 and OMAP4+ SoCs. Introduce a dedicated structure
for storing this match data, and simplify the probe function by
using the of_device_get_match_data() function. This allows the
driver to scale for 64-bit platforms by eliminating the unnecessary
type-casting between a u32 and a void pointer types.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 97c7d9b7f46f..db66e952a871 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -69,6 +69,10 @@ struct omap_mbox_queue {
 	bool full;
 };
 
+struct omap_mbox_match_data {
+	u32 intr_type;
+};
+
 struct omap_mbox_device {
 	struct device *dev;
 	struct mutex cfg_lock;
@@ -638,18 +642,21 @@ static const struct dev_pm_ops omap_mbox_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
 };
 
+static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1 };
+static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2 };
+
 static const struct of_device_id omap_mailbox_of_match[] = {
 	{
 		.compatible	= "ti,omap2-mailbox",
-		.data		= (void *)MBOX_INTR_CFG_TYPE1,
+		.data		= &omap2_data,
 	},
 	{
 		.compatible	= "ti,omap3-mailbox",
-		.data		= (void *)MBOX_INTR_CFG_TYPE1,
+		.data		= &omap2_data,
 	},
 	{
 		.compatible	= "ti,omap4-mailbox",
-		.data		= (void *)MBOX_INTR_CFG_TYPE2,
+		.data		= &omap4_data,
 	},
 	{
 		/* end */
@@ -692,7 +699,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	struct omap_mbox_fifo *fifo;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *child;
-	const struct of_device_id *match;
+	const struct omap_mbox_match_data *match_data;
 	u32 intr_type, info_count;
 	u32 num_users, num_fifos;
 	u32 tmp[3];
@@ -704,10 +711,10 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	match = of_match_device(omap_mailbox_of_match, &pdev->dev);
-	if (!match)
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data)
 		return -ENODEV;
-	intr_type = (u32)match->data;
+	intr_type = match_data->intr_type;
 
 	if (of_property_read_u32(node, "ti,mbox-num-users", &num_users))
 		return -ENODEV;
-- 
2.17.1
