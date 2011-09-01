From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/7] arm/dts: Add initial device-tree support for OMAP3 SoC
Date: Thu, 1 Sep 2011 19:25:06 +0200
Message-ID: <1314897912-18178-2-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: manjugk-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add initial OMAP3 soc file with empty ocp bus.

Based on initial patch from Manju:
http://www.spinics.net/lists/linux-omap/msg55830.html

Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi |   44 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3.dtsi

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
new file mode 100644
index 0000000..1b27925
--- /dev/null
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -0,0 +1,44 @@
+/*
+ * Device Tree Source for OMAP3 SoC
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "ti,omap3430", "ti,omap3";
+
+	/*
+	 * The soc node represents the soc top level view. It is uses for IPs
+	 * that are not memory mapped in the MPU view or for the MPU itself.
+	 */
+	soc {
+		compatible = "ti,omap-infra";
+	};
+
+	/*
+	 * XXX: Use a flat representation of the OMAP3 interconnect.
+	 * The real OMAP interconnect network is quite complex.
+	 * Since that will not bring real advantage to represent that in DT for
+	 * the moment, just use a fake OCP bus entry to represent the whole bus
+	 * hierarchy.
+	 */
+	ocp {
+		compatible = "ti,l3-smx", "arteris,smx", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		hwmods = "l3_main";
+
+		intc: interrupt-controller@1 {
+			compatible = "ti,omap3-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+	};
+};
-- 
1.7.0.4
