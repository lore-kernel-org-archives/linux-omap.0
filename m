From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 04/14] mfd: omap-usb-tll: Add device tree support
Date: Thu, 7 Feb 2013 18:02:44 +0200
Message-ID: <1360252974-7912-5-git-send-email-rogerq@ti.com>
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
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, stern@rowland.harvard.edu, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Enable this driver to probe in device tree boot.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 +++++++++++++++++
 drivers/mfd/omap-usb-tll.c                         |    9 +++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt

diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
new file mode 100644
index 0000000..62fe697
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
@@ -0,0 +1,17 @@
+OMAP HS USB Host TLL (Transceiver-Less Interface)
+
+Required properties:
+
+- compatible : should be "ti,usbhs-tll"
+- reg : should contain one register range i.e. start and length
+- interrupts : should contain the TLL module's interrupt
+- ti,hwmod : must contain "usb_tll_hs"
+
+Example:
+
+	usbhstll: usbhstll@4a062000 {
+		compatible = "ti,usbhs-tll";
+		reg = <0x4a062000 0x1000>;
+		interrupts = <78>;
+		ti,hwmods = "usb_tll_hs";
+	  };
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index f7d2568..f7afb22 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/usb-omap.h>
+#include <linux/of.h>
 
 #define USBTLL_DRIVER_NAME	"usbhs_tll"
 
@@ -311,10 +312,18 @@ static int usbtll_omap_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id usbtll_omap_dt_ids[] = {
+	{ .compatible = "ti,usbhs-tll" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, usbtll_omap_dt_ids);
+
 static struct platform_driver usbtll_omap_driver = {
 	.driver = {
 		.name		= (char *)usbtll_driver_name,
 		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(usbtll_omap_dt_ids),
 	},
 	.probe		= usbtll_omap_probe,
 	.remove		= usbtll_omap_remove,
-- 
1.7.4.1
