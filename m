From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 5/8] usb: otg: palmas-usb: use bool to read property
 instead of u32
Date: Fri, 25 Jan 2013 08:42:28 +0530
Message-ID: <1359083551-8524-6-git-send-email-kishon@ti.com>
References: <1359083551-8524-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359083551-8524-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

properies like wakeup and no_control_vbus can be represented in boolean,
so read those properties using of_property_read_bool.

Also updated the documentation with device tree binding information for
palmas-usb.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/usb/twlxxxx-usb.txt        |   24 ++++++++++++++++++++
 drivers/usb/otg/palmas-usb.c                       |   15 +++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
index 36b9aed..fa037ad 100644
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
@@ -38,3 +38,27 @@ twl4030-usb {
 	usb3v1-supply = <&vusb3v1>;
 	usb_mode = <1>;
 };
+
+PALMAS USB COMPARATOR
+Required Properties:
+ - compatible : Should be "ti,palmas-usb"
+ - interrupts : Four interrupt numbers to the cpu should be specified. First
+   interrupt number is the otg interrupt number that raises ID interrupts when
+   the controller has to act as host and the second interrupt number is the
+   ID wakeup interrupt number, third interrupt is VBUS interrupt and fourth
+   interrupt is VBUS wakeup interrupt.
+-  interrupt-name : the name corresponding to each interrupt populated in
+   interrupts property.
+ - vbus-supply : phandle to the regulator device tree node.
+
+Optional Properties:
+ - ti,wakeup : To enable the wakeup comparator in probe
+ - ti,no_control_vbus: if the platform wishes its own vbus control
+
+palmas-usb {
+	compatible = "ti,palmas-usb";
+	interrupts = <20 0>, <21 0>, <22 0>, <23 0>;
+	interrupt-names = "ID", "ID_WAKEUP", "VBUS", "VBUS_WAKEUP";
+	vbus-supply = <&smps10_reg>;
+	ti,wakeup;
+};
diff --git a/drivers/usb/otg/palmas-usb.c b/drivers/usb/otg/palmas-usb.c
index 1bd8b15..2377836 100644
--- a/drivers/usb/otg/palmas-usb.c
+++ b/drivers/usb/otg/palmas-usb.c
@@ -235,18 +235,9 @@ static int palmas_start_srp(struct phy_companion *comparator)
 static void palmas_dt_to_pdata(struct device_node *node,
 		struct palmas_usb_platform_data *pdata)
 {
-	int ret;
-	u32 prop;
-
-	ret = of_property_read_u32(node, "ti,no_control_vbus", &prop);
-	if (!ret) {
-		pdata->no_control_vbus = prop;
-	}
-
-	ret = of_property_read_u32(node, "ti,wakeup", &prop);
-	if (!ret) {
-		pdata->wakeup = prop;
-	}
+	pdata->no_control_vbus = of_property_read_bool(node,
+					"ti,no_control_vbus");
+	pdata->wakeup = of_property_read_bool(node, "ti,wakeup");
 }
 
 static int palmas_usb_probe(struct platform_device *pdev)
-- 
1.7.9.5
