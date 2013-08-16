From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
Date: Fri, 16 Aug 2013 15:50:48 +0530
Message-ID: <1376648448-27447-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, swarren@wwwdotorg.org, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux@arm.linux.org.uk, ian.campbell@citrix.com, pawel.moll@arm.com, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, kishon@ti.com, balbi@ti.com, rob@landley.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The Palmas device contains only a USB VID detector, so modified the
compatible type to *ti,palmas-usb-vid*.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
* removed the existing compatible types and changed it to *ti,palmas-usb-vid*

 Documentation/devicetree/bindings/extcon/extcon-palmas.txt |    4 ++--
 drivers/extcon/extcon-palmas.c                             |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
index 7dab6a8..00859f6 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
@@ -2,7 +2,7 @@ EXTCON FOR PALMAS/TWL CHIPS
 
 PALMAS USB COMPARATOR
 Required Properties:
- - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
+ - compatible : Should be "ti,palmas-usb-vid".
 
 Optional Properties:
  - ti,wakeup : To enable the wakeup comparator in probe
@@ -10,6 +10,6 @@ Optional Properties:
  - ti,enable-vbus-detection: Perform VBUS detection.
 
 palmas-usb {
-       compatible = "ti,twl6035-usb", "ti,palmas-usb";
+       compatible = "ti,palmas-usb-vid";
        ti,wakeup;
 };
diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 89fdd05..f3ed2d7 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -267,8 +267,7 @@ static const struct dev_pm_ops palmas_pm_ops = {
 };
 
 static struct of_device_id of_palmas_match_tbl[] = {
-	{ .compatible = "ti,palmas-usb", },
-	{ .compatible = "ti,twl6035-usb", },
+	{ .compatible = "ti,palmas-usb-vid", },
 	{ /* end */ }
 };
 
-- 
1.7.10.4
