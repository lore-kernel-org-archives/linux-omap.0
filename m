From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 02/14] USB: phy: nop: Defer probe if device needs VCC/RESET
Date: Thu, 7 Feb 2013 18:02:42 +0200
Message-ID: <1360252974-7912-3-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1360252974-7912-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, stern@rowland.harvard.edu, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Add 2 flags, needs_vcc and needs_reset to platform data.
If the flag is set and the regulator couldn't be found
then we bail out with -EPROBE_DEFER.

For device tree boot we depend on presensce of vcc-supply/
reset-supply properties to decide if we should bail out
with -EPROBE_DEFER or just continue in case the regulator
can't be found.

This is required for proper functionality in cases where the
regulator is needed but is probed later than the PHY device.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/otg/nop-usb-xceiv.c   |   11 +++++++++++
 include/linux/usb/nop-usb-xceiv.h |    4 ++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 6b7a9a0..7b0e8a8 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -43,6 +43,8 @@ struct nop_usb_xceiv {
 	struct regulator *vcc;
 	struct regulator *reset;
 	u32 clk_rate;
+	unsigned int needs_vcc:1;
+	unsigned int needs_reset:1;
 };
 
 static struct platform_device *pd;
@@ -163,9 +165,14 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 		if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
 			nop->clk_rate = clk_rate;
 
+		nop->needs_vcc = of_property_read_bool(node, "vcc-supply");
+		nop->needs_reset = of_property_read_bool(node, "reset-supply");
+
 	} else if (pdata) {
 		type = pdata->type;
 		nop->clk_rate = pdata->clk_rate;
+		nop->needs_vcc = pdata->needs_vcc;
+		nop->needs_reset = pdata->needs_reset;
 	}
 
 	nop->clk = devm_clk_get(&pdev->dev, "main_clk");
@@ -194,12 +201,16 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 	if (IS_ERR(nop->vcc)) {
 		dev_dbg(&pdev->dev, "Error getting vcc regulator: %ld\n",
 					PTR_ERR(nop->vcc));
+		if (nop->needs_vcc)
+			return -EPROBE_DEFER;
 	}
 
 	nop->reset = devm_regulator_get(&pdev->dev, "reset");
 	if (IS_ERR(nop->reset)) {
 		dev_dbg(&pdev->dev, "Error getting reset regulator: %ld\n",
 					PTR_ERR(nop->reset));
+		if (nop->needs_reset)
+			return -EPROBE_DEFER;
 	}
 
 	nop->dev		= &pdev->dev;
diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
index 3265b61..148d351 100644
--- a/include/linux/usb/nop-usb-xceiv.h
+++ b/include/linux/usb/nop-usb-xceiv.h
@@ -6,6 +6,10 @@
 struct nop_usb_xceiv_platform_data {
 	enum usb_phy_type type;
 	unsigned long clk_rate;
+
+	/* if set fails with -EPROBE_DEFER if can't get regulator */
+	unsigned int needs_vcc:1;
+	unsigned int needs_reset:1;
 };
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
-- 
1.7.4.1
