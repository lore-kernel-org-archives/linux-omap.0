From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/9] dt-bindings: ti-sysc: Update binding for timers and capabilities
Date: Fri, 15 Dec 2017 10:08:52 -0800
Message-ID: <20171215180900.3243-2-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215180900.3243-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Matthijs van Duin <matthijsvanduin@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sakari Ailus <sakari.ailus@iki.fi>, Suman Anna <s-anna@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

The ti-sysc binding does not yet describe the capabilities of the
interconnect target module. So to make the ti-sysc binding usable
for configuring the interconnect target module, we need to add few
more properties:

1. To detect between omap2 and omap4 timers, let's add compatibles
   for them for "ti,sysc-omap2-timer" and,sysc-omap4-timer". This
   makes it easier to pick up the already initialized system timers
   later on

2. Let's add "ti,sysc-mask" for a mask of features supported by the
   interconnect target module. This describes what we have available
   in the various SYSCONFIG registers

3. Let's add "ti,sysc-midle" and "ti,sysc-sidle" lists for the master
   and slave idle modes supported by the interconnect target module.
   These describe the values available for MIDLE and SIDLE bits in
   the SYSCONFIG registers

4. Some interconnect target modules need a short delay after reset
   before they can be accessed, let's use "ti,sysc-delay-us" for
   that

5. Let's add "ti,syss-mask" bit to describe the optional SYSSTATUS
   register bits for reset done bits

6. Let's support the two existing custom quirk properties already
   listed in Documentation/devicetree/bindings/arm/omap/omap.txt for
   "ti,no-reset-on-init" and "ti,no-idle-on-init"

7. And finally, let's add a header for the binding for the dts
   files and the driver to use

Cc: Benoît Cousson <bcousson@baylibre.com>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt | 36 +++++++++++++++++++++++
 include/dt-bindings/bus/ti-sysc.h                 | 22 ++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 include/dt-bindings/bus/ti-sysc.h

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -26,6 +26,8 @@ Required standard properties:
 		or one of the following derivative types for hardware
 		needing special workarounds:
 
+		"ti,sysc-omap2-timer"
+		"ti,sysc-omap4-timer"
 		"ti,sysc-omap3430-sr"
 		"ti,sysc-omap3630-sr"
 		"ti,sysc-omap4-sr"
@@ -49,6 +51,26 @@ Required standard properties:
 
 Optional properties:
 
+- ti,sysc-mask	shall contain mask of supported register bits for the
+		SYSCONFIG register as documented in the Technical Reference
+		Manual (TRM) for the interconnect target module
+
+- ti,sysc-midle	list of master idle modes supported by the interconnect
+		target module as documented in the TRM for SYSCONFIG
+		register MIDLEMODE bits
+
+- ti,sysc-sidle	list of slave idle modes supported by the interconnect
+		target module as documented in the TRM for SYSCONFIG
+		register SIDLEMODE bits
+
+- ti,sysc-delay-us	delay needed after OCP softreset before accssing
+			SYSCONFIG register again
+
+- ti,syss-mask	optional mask of reset done status bits as described in the
+		TRM for SYSSTATUS registers, typically 1 with some devices
+		having separate reset done bits for children like OHCI and
+		EHCI
+
 - clocks	clock specifier for each name in the clock-names as
 		specified in the binding documentation for ti-clkctrl,
 		typically available for all interconnect targets on TI SoCs
@@ -61,6 +83,9 @@ Optional properties:
 - ti,hwmods	optional TI interconnect module name to use legacy
 		hwmod platform data
 
+- ti,no-reset-on-init	interconnect target module should not be reset at init
+
+- ti,no-idle-on-init	interconnect target module should not be idled at init
 
 Example: Single instance of MUSB controller on omap4 using interconnect ranges
 using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
@@ -74,6 +99,17 @@ using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
 		reg-names = "rev", "sysc", "syss";
 		clocks = <&l3_init_clkctrl OMAP4_USB_OTG_HS_CLKCTRL 0>;
 		clock-names = "fck";
+		ti,sysc-mask = <(SYSC_OMAP2_ENAWAKEUP |
+				 SYSC_OMAP2_SOFTRESET |
+				 SYSC_OMAP2_AUTOIDLE)>;
+		ti,sysc-midle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>;
+		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>,
+				<SYSC_IDLE_SMART_WKUP>;
+		ti,syss-mask = <1>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0x2b000 0x1000>;
diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
new file mode 100644
--- /dev/null
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -0,0 +1,22 @@
+/* TI sysc interconnect target module defines */
+
+/* Generic sysc found on omap2 and later, also known as type1 */
+#define SYSC_OMAP2_CLOCKACTIVITY	(3 << 8)
+#define SYSC_OMAP2_EMUFREE		(1 << 5)
+#define SYSC_OMAP2_ENAWAKEUP		(1 << 2)
+#define SYSC_OMAP2_SOFTRESET		(1 << 1)
+#define SYSC_OMAP2_AUTOIDLE		(1 << 0)
+
+/* Generic sysc found on omap4 and later, also known as type2 */
+#define SYSC_OMAP4_DMADISABLE		(1 << 16)
+#define SYSC_OMAP4_FREEEMU		(1 << 1)	/* Also known as EMUFREE */
+#define SYSC_OMAP4_SOFTRESET		(1 << 0)
+
+/* SmartReflex sysc found on 36xx and later */
+#define SYSC_OMAP3_SR_ENAWAKEUP		(1 << 26)
+
+/* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
+#define SYSC_IDLE_FORCE			0
+#define SYSC_IDLE_NO			1
+#define SYSC_IDLE_SMART			2
+#define SYSC_IDLE_SMART_WKUP		3
-- 
2.15.0
