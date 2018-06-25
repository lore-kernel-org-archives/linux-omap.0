From: Adam Ford <aford173@gmail.com>
Subject: [RFC 2/5] usb: musb: am35x: Match clock assignements to hwmods
Date: Sun, 24 Jun 2018 19:12:30 -0500
Message-ID: <20180625001233.9785-3-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adam.ford@logicpd.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

There are two clocks that fail when attempting to use them.  This
patch patches the clock names to match those in hwmods.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index a55db15a8457..56f8e13f4c1b 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -455,14 +455,14 @@ static int am35x_probe(struct platform_device *pdev)
 	if (!glue)
 		goto err0;
 
-	phy_clk = clk_get(&pdev->dev, "fck");
+	phy_clk = clk_get(&pdev->dev, "hsotgusb_fck");
 	if (IS_ERR(phy_clk)) {
 		dev_err(&pdev->dev, "failed to get PHY clock\n");
 		ret = PTR_ERR(phy_clk);
 		goto err3;
 	}
 
-	clk = clk_get(&pdev->dev, "ick");
+	clk = clk_get(&pdev->dev, "hsotgusb_ick");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
-- 
2.17.1
