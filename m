From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 06/11] arm/dts: Add twl6030-usb data
Date: Wed, 18 Jul 2012 16:08:37 +0530
Message-ID: <1342607922-11554-7-git-send-email-kishon@ti.com>
References: <1342607922-11554-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1342607922-11554-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
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

Add twl6030-usb data node in twl6030 device tree file

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |    4 ++++
 arch/arm/boot/dts/omap4-sdp.dts   |    4 ++++
 arch/arm/boot/dts/twl6030.dtsi    |    6 ++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 1efe0c5..7052422 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -89,3 +89,7 @@
 	ti,non-removable;
 	bus-width = <4>;
 };
+
+&twlusb {
+	usb-supply = <&vusb>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index d08c4d1..6326d7c 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -158,3 +158,7 @@
 	bus-width = <4>;
 	ti,non-removable;
 };
+
+&twlusb {
+	usb-supply = <&vusb>;
+};
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 3b2f351..5efd6d3 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -83,4 +83,10 @@
 	clk32kg: regulator@12 {
 		compatible = "ti,twl6030-clk32kg";
 	};
+
+	twlusb: twl6030-usb {
+		compatible = "ti,twl6030-usb";
+		interrupts = < 4 10 >;
+		regulator = "vusb";
+	};
 };
-- 
1.7.5.4
