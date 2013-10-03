From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 3/8] usb: phy: omap-usb2: Don't use omap_get_control_dev()
Date: Thu, 3 Oct 2013 12:59:01 +0300
Message-ID: <1380794346-30185-4-git-send-email-rogerq@ti.com>
References: <1380794346-30185-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380794346-30185-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, thomas.langer@lantiq.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

omap_get_control_dev() is being deprecated as it doesn't support
multiple instances. As control device is present only from OMAP4
onwards which supports DT only, we use phandles to get the
reference to the control device.

As we don't support non-DT boot, we just bail out on probe
if device node is not present.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/phy-omap-usb2.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index 4d7b4e5..bfc5c33 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/usb/omap_control_usb.h>
 #include <linux/phy/phy.h>
+#include <linux/of_platform.h>
 
 /**
  * omap_usb2_set_comparator - links the comparator present in the sytem with
@@ -145,10 +146,16 @@ static struct phy_ops ops = {
 
 static int omap_usb2_probe(struct platform_device *pdev)
 {
-	struct omap_usb			*phy;
-	struct phy			*generic_phy;
-	struct usb_otg			*otg;
-	struct phy_provider		*phy_provider;
+	struct omap_usb	*phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct usb_otg *otg;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
+
+	if (!node)
+		return -EINVAL;
 
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy) {
@@ -175,12 +182,20 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(phy_provider))
 		return PTR_ERR(phy_provider);
 
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
+
 	phy->is_suspended	= 1;
 	omap_control_usb_phy_power(phy->control_dev, 0);
 
-- 
1.7.4.1
