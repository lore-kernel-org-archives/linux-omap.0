From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 03/12] mfd: omap-usb-host: Use clock names as per function
 for reference clocks
Date: Wed, 12 Feb 2014 12:18:44 +0200
Message-ID: <1392200333-28397-4-git-send-email-rogerq@ti.com>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392200333-28397-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, bcousson@baylibre.com, lee.jones@linaro.org
Cc: nm@ti.com, devicetree@vger.kernel.org, khilman@linaro.org, Samuel Ortiz <sameo@linux.intel.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Use a meaningful name for the reference clocks so that it indicates the function.

CC: Lee Jones <lee.jones@linaro.org>
CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 60a3bed..ce620a8 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -714,21 +714,21 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		goto err_mem;
 	}
 
-	omap->xclk60mhsp1_ck = devm_clk_get(dev, "xclk60mhsp1_ck");
+	omap->xclk60mhsp1_ck = devm_clk_get(dev, "refclk_60m_ext_p1");
 	if (IS_ERR(omap->xclk60mhsp1_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp1_ck);
 		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
 		goto err_mem;
 	}
 
-	omap->xclk60mhsp2_ck = devm_clk_get(dev, "xclk60mhsp2_ck");
+	omap->xclk60mhsp2_ck = devm_clk_get(dev, "refclk_60m_ext_p2");
 	if (IS_ERR(omap->xclk60mhsp2_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp2_ck);
 		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
 		goto err_mem;
 	}
 
-	omap->init_60m_fclk = devm_clk_get(dev, "init_60m_fclk");
+	omap->init_60m_fclk = devm_clk_get(dev, "refclk_60m_int");
 	if (IS_ERR(omap->init_60m_fclk)) {
 		ret = PTR_ERR(omap->init_60m_fclk);
 		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
-- 
1.8.3.2
