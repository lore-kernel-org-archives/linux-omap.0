From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ti-soc-thermal: Use devm_kcalloc() in ti_bandgap_build()
Date: Wed, 26 Apr 2017 17:34:45 +0200
Message-ID: <071d2e92-0bcc-5ccc-ad28-b05a72538d6b@users.sourceforge.net>
References: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 26 Apr 2017 16:45:25 +0200

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "devm_kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ba9c302454fb..f19cb7612a65 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1224,8 +1224,8 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
 		bgp->conf = of_id->data;
 
 	/* register shadow for context save and restore */
-	bgp->regval = devm_kzalloc(&pdev->dev, sizeof(*bgp->regval) *
-				   bgp->conf->sensor_count, GFP_KERNEL);
+	bgp->regval = devm_kcalloc(&pdev->dev, bgp->conf->sensor_count,
+				   sizeof(*bgp->regval), GFP_KERNEL);
 	if (!bgp->regval) {
 		dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
 		return ERR_PTR(-ENOMEM);
-- 
2.12.2

