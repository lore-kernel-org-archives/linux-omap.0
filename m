From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 1/8] usb: phy: omap-control: Get rid of platform data
Date: Thu, 3 Oct 2013 18:12:30 +0300
Message-ID: <1380813157-22311-2-git-send-email-rogerq@ti.com>
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

omap-control device is present from OMAP4 onwards which
support device tree boots only. So get rid of platform data.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/phy/phy-omap-control.c   |   12 +++---------
 include/linux/usb/omap_control_usb.h |    4 ----
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
index a4dda8e..9772592 100644
--- a/drivers/usb/phy/phy-omap-control.c
+++ b/drivers/usb/phy/phy-omap-control.c
@@ -197,8 +197,6 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	struct device_node *np = pdev->dev.of_node;
-	struct omap_control_usb_platform_data *pdata =
-			dev_get_platdata(&pdev->dev);
 
 	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
 		GFP_KERNEL);
@@ -207,14 +205,10 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (np) {
+	if (np)
 		of_property_read_u32(np, "ti,type", &control_usb->type);
-	} else if (pdata) {
-		control_usb->type = pdata->type;
-	} else {
-		dev_err(&pdev->dev, "no pdata present\n");
-		return -EINVAL;
-	}
+	else
+		return -EINVAL;	/* We only support DT boot */
 
 	control_usb->dev	= &pdev->dev;
 
diff --git a/include/linux/usb/omap_control_usb.h b/include/linux/usb/omap_control_usb.h
index 27b5b8c..e2416b4 100644
--- a/include/linux/usb/omap_control_usb.h
+++ b/include/linux/usb/omap_control_usb.h
@@ -31,10 +31,6 @@ struct omap_control_usb {
 	u32 type;
 };
 
-struct omap_control_usb_platform_data {
-	u8 type;
-};
-
 enum omap_control_usb_mode {
 	USB_MODE_UNDEFINED = 0,
 	USB_MODE_HOST,
-- 
1.7.4.1
