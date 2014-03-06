From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 06/13] phy: ti-pipe3: Don't get 'wkupclk' and 'refclk' for
 SATA PHY
Date: Thu, 6 Mar 2014 16:22:58 +0200
Message-ID: <1394115785-28301-7-git-send-email-rogerq@ti.com>
References: <1394115785-28301-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394115785-28301-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kishon@ti.comg, tony@atomide.com, balbi@ti.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, balajitk@ti.com, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

SATA PHY doesn't need 'wkupclk; and 'refclk' so don't
try to get them for SATA PHY.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-ti-pipe3.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index f141237..baa3f78d 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -294,16 +294,22 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 	phy->dev		= &pdev->dev;
 
-	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
-	if (IS_ERR(phy->wkupclk)) {
-		dev_err(&pdev->dev, "unable to get wkupclk\n");
-		return PTR_ERR(phy->wkupclk);
-	}
+	if (!of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+
+		phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
+		if (IS_ERR(phy->wkupclk)) {
+			dev_err(&pdev->dev, "unable to get wkupclk\n");
+			return PTR_ERR(phy->wkupclk);
+		}
 
-	phy->refclk = devm_clk_get(phy->dev, "refclk");
-	if (IS_ERR(phy->refclk)) {
-		dev_err(&pdev->dev, "unable to get refclk\n");
-		return PTR_ERR(phy->refclk);
+		phy->refclk = devm_clk_get(phy->dev, "refclk");
+		if (IS_ERR(phy->refclk)) {
+			dev_err(&pdev->dev, "unable to get refclk\n");
+			return PTR_ERR(phy->refclk);
+		}
+	} else {
+		phy->wkupclk = ERR_PTR(-ENODEV);
+		phy->refclk = ERR_PTR(-ENODEV);
 	}
 
 	phy->sys_clk = devm_clk_get(phy->dev, "sysclk");
-- 
1.8.3.2
