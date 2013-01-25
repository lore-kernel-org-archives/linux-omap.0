From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 1/3] mtd: omap-onenand: pass device_node in platform data
Date: Fri, 25 Jan 2013 09:23:09 -0300
Message-ID: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47754 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3AYMXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 07:23:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, zonque@gmail.com, tony@atomide.com, matthias.bgg@googlemail.com, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-mtd@lists.infradead.org, b-cousson@ti.com, grant.likely@secretlab.ca, jon-hunter@ti.com, Artem Bityutskiy <dedekind1@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Pass an optional device_node pointer in the platform data,
which in turn will be put into a mtd_part_parser_data.
This way, code that sets up the platform devices can pass
along the node from DT so that the partitions can be parsed.

For non-DT boards, this change has no effect.

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/onenand/omap2.c                     |    4 +++-
 include/linux/platform_data/mtd-onenand-omap2.h |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 065f3fe..eec2aed 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -637,6 +637,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	struct onenand_chip *this;
 	int r;
 	struct resource *res;
+	struct mtd_part_parser_data ppdata = {};
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -767,7 +768,8 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	if ((r = onenand_scan(&c->mtd, 1)) < 0)
 		goto err_release_regulator;
 
-	r = mtd_device_parse_register(&c->mtd, NULL, NULL,
+	ppdata.of_node = pdata->of_node;
+	r = mtd_device_parse_register(&c->mtd, NULL, &ppdata,
 				      pdata ? pdata->parts : NULL,
 				      pdata ? pdata->nr_parts : 0);
 	if (r)
diff --git a/include/linux/platform_data/mtd-onenand-omap2.h b/include/linux/platform_data/mtd-onenand-omap2.h
index 685af7e..e9a9fb1 100644
--- a/include/linux/platform_data/mtd-onenand-omap2.h
+++ b/include/linux/platform_data/mtd-onenand-omap2.h
@@ -29,5 +29,8 @@ struct omap_onenand_platform_data {
 	u8			flags;
 	u8			regulator_can_sleep;
 	u8			skip_initial_unlocking;
+
+	/* for passing the partitions */
+	struct device_node	*of_node;
 };
 #endif
-- 
1.7.8.6

