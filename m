From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 4/8] usb: phy: omap-usb3: Don't use omap_get_control_dev()
Date: Thu, 3 Oct 2013 18:12:33 +0300
Message-ID: <1380813157-22311-5-git-send-email-rogerq@ti.com>
References: <1380813157-22311-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380813157-22311-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, thomas.langer@lantiq.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

omap_get_control_dev() is being deprecated as it doesn't support
multiple instances. As control device is present only from OMAP4
onwards which supports DT only, we use phandles to get the
reference to the control device.

As we don't support non-DT boot, we just bail out on probe
if device node is not present.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/phy/phy-omap-usb3.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
index 0824be4..0c6ba29 100644
--- a/drivers/usb/phy/phy-omap-usb3.c
+++ b/drivers/usb/phy/phy-omap-usb3.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/of_platform.h>
 
 #define	PLL_STATUS		0x00000004
 #define	PLL_GO			0x00000008
@@ -196,8 +197,14 @@ static int omap_usb3_init(struct usb_phy *x)
 
 static int omap_usb3_probe(struct platform_device *pdev)
 {
-	struct omap_usb			*phy;
-	struct resource			*res;
+	struct omap_usb *phy;
+	struct resource *res;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
+
+	if (!node)
+		return -EINVAL;
 
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy) {
@@ -239,11 +246,18 @@ static int omap_usb3_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	phy->control_dev = omap_get_control_dev();
-	if (IS_ERR(phy->control_dev)) {
-		dev_dbg(&pdev->dev, "Failed to get control device\n");
-		return -ENODEV;
+	control_node = of_parse_phandle(node, "ctrl-module", 0);
+	if (!control_node) {
+		dev_err(&pdev->dev, "Failed to get control device phandle\n");
+		return -EINVAL;
 	}
+	control_pdev = of_find_device_by_node(control_node);
+	if (!control_pdev) {
+		dev_err(&pdev->dev, "Failed to get control device\n");
+		return -EINVAL;
+	}
+
+	phy->control_dev = &control_pdev->dev;
 
 	omap_control_usb_phy_power(phy->control_dev, 0);
 	usb_add_phy_dev(&phy->phy);
-- 
1.7.4.1
