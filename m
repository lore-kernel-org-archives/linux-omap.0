From: Tero Kristo <t-kristo@ti.com>
Subject: [REPOST PATCH 2/2] regulator: twl: use platform data in the DT based boot also
Date: Fri, 10 Oct 2014 17:06:29 +0300
Message-ID: <1412949989-20186-3-git-send-email-t-kristo@ti.com>
References: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaJJOGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 10:06:47 -0400
In-Reply-To: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, nm@ti.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

This allows to pass platform information during a DT boot also, currently
this is completely ignored. Needed for supporting the platform specific
regulator set_voltage / get_voltage ops for the SMPS regulators.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 0b4f866..2c4fa06 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1103,9 +1103,9 @@ static int twlreg_probe(struct platform_device *pdev)
 	if (match) {
 		template = match->data;
 		id = template->desc.id;
+		drvdata = dev_get_platdata(&pdev->dev);
 		initdata = of_get_regulator_init_data(&pdev->dev,
 						      pdev->dev.of_node);
-		drvdata = NULL;
 	} else {
 		id = pdev->id;
 		initdata = dev_get_platdata(&pdev->dev);
-- 
1.7.9.5

