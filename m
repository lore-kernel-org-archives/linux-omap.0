From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 7/7] usb: dwc3: core: add dt support for dwc3 core
Date: Mon, 15 Oct 2012 18:58:00 +0530
Message-ID: <1350307680-24938-8-git-send-email-kishon@ti.com>
References: <1350307680-24938-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1350307680-24938-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added dwc3 support for dwc3 core and update the documentation with
device tree binding information.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |   23 +++++++++++++++++++++++
 drivers/usb/dwc3/core.c                        |   14 ++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3.txt

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
new file mode 100644
index 0000000..9ec9316
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -0,0 +1,23 @@
+synopsys DWC3 CORE
+
+DWC3- USB3 CONTROLLER
+
+Required properties:
+ - compatible: must be "synopsys,dwc3"
+ - reg : Address and length of the register set for the device
+ - interrupts: Interrupts used by the dwc3 controller.
+ - interrupt-parent: the phandle for the interrupt controller that
+   services interrupts for this device.
+
+Optional properties:
+ - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+
+This is usually a subnode to DWC3 glue to which it is connected.
+
+dwc3@4a030000 {
+	compatible = "synopsys,dwc3";
+	reg = <0x4a030000 0xcfff>;
+	interrupts = <0 92 4>
+	interrupt-parent = <&gic>
+	tx-fifo-resize;
+};
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b923183..c76d8e9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -491,8 +491,7 @@ static int __devinit dwc3_probe(struct platform_device *pdev)
 	else
 		dwc->maximum_speed = DWC3_DCFG_SUPERSPEED;
 
-	if (of_get_property(node, "tx-fifo-resize", NULL))
-		dwc->needs_fifo_resize = true;
+	dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -619,11 +618,22 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id of_dwc3_match[] = {
+	{
+		.compatible = "synopsys,dwc3"
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_dwc3_match);
+#endif
+
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
 	.remove		= __devexit_p(dwc3_remove),
 	.driver		= {
 		.name	= "dwc3",
+		.of_match_table	= of_match_ptr(of_dwc3_match),
 	},
 };
 
-- 
1.7.9.5
