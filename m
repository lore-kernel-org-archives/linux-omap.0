From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ethernet: cpsw-phy-sel: Delete an error message for a failed
 memory allocation in cpsw_phy_sel_probe()
Date: Tue, 2 Jan 2018 21:48:54 +0100
Message-ID: <3addaad6-2767-8a2f-cde3-a25148780f36@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jan 2018 21:41:25 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/ti/cpsw-phy-sel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
index 18013645e76c..d29bc349bfc4 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -213,10 +213,8 @@ static int cpsw_phy_sel_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "unable to alloc memory for cpsw phy sel\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	priv->dev = &pdev->dev;
 	priv->cpsw_phy_sel = of_id->data;
-- 
2.15.1
