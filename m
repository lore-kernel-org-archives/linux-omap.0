From: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] ARM: dts: OMAP4+: Add DMM bindings
Date: Fri, 13 Sep 2013 14:44:37 +0530
Message-ID: <1379063679-4869-3-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379063679-4869-1-git-send-email-archit-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 devices. DMM
only requires address and irq information.

Add documentation for the DMM bindings.

Originally worked on by Andy Gross.

Cc: Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/omap/dmm.txt | 17 +++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
 3 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Documentation/devicetree/bindings/arm/omap/dmm.txt
new file mode 100644
index 0000000..237cd83
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
@@ -0,0 +1,17 @@
+OMAP Dynamic Memory Manager (DMM) bindings
+
+Required properties:
+- compatible:	Must be "ti,omap4-dmm" for OMAP4 family
+		Must be "ti,omap5-dmm" for OMAP5 family
+- reg:		Contains timer register address range (base address and length)
+- interrupts:	Contains interrupt information (source, etc) for the DMM IRQ
+- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
+		"dmm"
+
+Example:
+
+dmm: dmm@4e000000 {
+	compatible = "ti,omap4-dmm";
+	reg = <0x4e000000 0x800>;
+	ti,hwmods = "dmm";
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..24f388e 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -487,6 +487,13 @@
 			ti,hwmods = "kbd";
 		};
 
+		dmm: dmm@4e000000 {
+			compatible = "ti,omap4-dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
+
 		emif1: emif@4c000000 {
 			compatible = "ti,emif-4d";
 			reg = <0x4c000000 0x100>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index ac1f1e0..33b4fea 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -604,6 +604,13 @@
 			ti,hwmods = "wd_timer2";
 		};
 
+		dmm: dmm@4e000000 {
+			compatible = "ti,omap5-dmm";
+			reg = <0x4e000000 0x800>;
+			interrupts = <0 113 0x4>;
+			ti,hwmods = "dmm";
+		};
+
 		emif1: emif@0x4c000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif1";
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
