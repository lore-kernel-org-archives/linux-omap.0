From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 10/11] arm/dts: omap: Add usb_otg and glue data
Date: Mon, 30 Jul 2012 14:39:59 +0530
Message-ID: <1343639400-28725-11-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1343639400-28725-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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
To: kishon-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add usb otg data node in omap4/omap3 device tree file. Also update
the node with board specific setting in omapx-<board>.dts file.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-beagle.dts |    6 ++++++
 arch/arm/boot/dts/omap3-evm.dts    |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi       |    8 ++++++++
 arch/arm/boot/dts/omap4-panda.dts  |    6 ++++++
 arch/arm/boot/dts/omap4-sdp.dts    |    6 ++++++
 arch/arm/boot/dts/omap4.dtsi       |    8 ++++++++
 6 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 5b4506c..f3d7076 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -67,3 +67,9 @@
 &mmc3 {
 	status = "disable";
 };
+
+&usb_otg_hs {
+	interface_type = <0>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 2eee16e..8963b3d 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -18,3 +18,9 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&usb_otg_hs {
+	interface_type = <0>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 99474fa..4b8c142 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -215,5 +215,13 @@
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
 		};
+
+		usb_otg_hs: usb_otg_hs {
+			compatible = "ti,omap3-musb";
+			ti,hwmods = "usb_otg_hs";
+			multipoint = <1>;
+			num_eps = <16>;
+			ram_bits = <12>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 7052422..dd19370 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -93,3 +93,9 @@
 &twlusb {
 	usb-supply = <&vusb>;
 };
+
+&usb_otg_hs {
+	interface_type = <1>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 6326d7c..0fc10d4 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -162,3 +162,9 @@
 &twlusb {
 	usb-supply = <&vusb>;
 };
+
+&usb_otg_hs {
+	interface_type = <1>;
+	mode = <3>;
+	power = <50>;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 15f1890..7886518 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -285,5 +285,13 @@
 				      <0x4a002300 0x1>;
 			};
 		};
+
+		usb_otg_hs: usb_otg_hs {
+			compatible = "ti,omap4-musb";
+			ti,hwmods = "usb_otg_hs";
+			multipoint = <1>;
+			num_eps = <16>;
+			ram_bits = <12>;
+		};
 	};
 };
-- 
1.7.9.5
