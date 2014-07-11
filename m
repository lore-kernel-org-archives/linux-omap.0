From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 01/11] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 10 Jul 2014 21:55:39 -0500
Message-ID: <1405047349-15101-2-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaGKC5G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jul 2014 22:57:06 -0400
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>, Dave Gerlach <d-gerlach@ti.com>

From: Daniel Mack <zonque@gmail.com>

This patch makes the edma driver resume correctly after suspend. Tested
on an AM33xx platform with cyclic audio streams and omap_hsmmc.

All information can be reconstructed by already known runtime
information.

As we now use some functions that were previously only used from __init
context, annotations had to be dropped.

[nm@ti.com: added error handling for runtime + suspend_late/early_resume]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Daniel Mack <zonque@gmail.com>
Tested-by: Joel Fernandes <joelf@ti.com>
Acked-by: Joel Fernandes <joelf@ti.com>
[d-gerlach@ti.com: updated to remove queue_tc_mapping use]
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/common/edma.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 485be42..8b1b9aa 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -244,6 +244,8 @@ struct edma {
 	/* list of channels with no even trigger; terminated by "-1" */
 	const s8	*noevent;
 
+	struct edma_soc_info *info;
+
 	/* The edma_inuse bit for each PaRAM slot is clear unless the
 	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
 	 */
@@ -295,7 +297,7 @@ static void map_dmach_queue(unsigned ctlr, unsigned ch_no,
 			~(0x7 << bit), queue_no << bit);
 }
 
-static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
+static void assign_priority_to_queue(unsigned ctlr, int queue_no,
 		int priority)
 {
 	int bit = queue_no * 4;
@@ -314,7 +316,7 @@ static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
  * included in that particular EDMA variant (Eg : dm646x)
  *
  */
-static void __init map_dmach_param(unsigned ctlr)
+static void map_dmach_param(unsigned ctlr)
 {
 	int i;
 	for (i = 0; i < EDMA_MAX_DMACH; i++)
@@ -1762,15 +1764,95 @@ static int edma_probe(struct platform_device *pdev)
 			edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
 			edma_write_array(j, EDMA_QRAE, i, 0x0);
 		}
+		edma_cc[j]->info = info[j];
 		arch_num_cc++;
 	}
 
 	return 0;
 }
 
+static int edma_pm_suspend(struct device *dev)
+{
+	int j, r;
+
+	r = pm_runtime_get_sync(dev);
+	if (r < 0) {
+		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
+		return r;
+	}
+
+	for (j = 0; j < arch_num_cc; j++) {
+		struct edma *ecc = edma_cc[j];
+
+		disable_irq(ecc->irq_res_start);
+		disable_irq(ecc->irq_res_end);
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static int edma_pm_resume(struct device *dev)
+{
+	int i, j, r;
+
+	r = pm_runtime_get_sync(dev);
+	if (r < 0) {
+		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
+		return r;
+	}
+
+	for (j = 0; j < arch_num_cc; j++) {
+		struct edma *cc = edma_cc[j];
+
+		s8 (*queue_priority_mapping)[2];
+
+		queue_priority_mapping = cc->info->queue_priority_mapping;
+
+		/* Event queue priority mapping */
+		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
+			assign_priority_to_queue(j,
+						 queue_priority_mapping[i][0],
+						 queue_priority_mapping[i][1]);
+
+		/*
+		 * Map the channel to param entry if channel mapping logic
+		 * exist
+		 */
+		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
+			map_dmach_param(j);
+
+		for (i = 0; i < cc->num_channels; i++) {
+			if (test_bit(i, cc->edma_inuse)) {
+				/* ensure access through shadow region 0 */
+				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
+					       BIT(i & 0x1f));
+
+				setup_dma_interrupt(i,
+						    cc->intr_data[i].callback,
+						    cc->intr_data[i].data);
+			}
+		}
+
+		enable_irq(cc->irq_res_start);
+		enable_irq(cc->irq_res_end);
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops edma_pm_ops = {
+	.suspend_late	= edma_pm_suspend,
+	.resume_early	= edma_pm_resume,
+};
+
 static struct platform_driver edma_driver = {
 	.driver = {
 		.name	= "edma",
+		.pm	= &edma_pm_ops,
 		.of_match_table = edma_of_ids,
 	},
 	.probe = edma_probe,
-- 
1.9.0

