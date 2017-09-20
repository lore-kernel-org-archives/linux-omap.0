From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/10] dt-bindings: bus: Minimal TI sysc interconnect target module binding
Date: Wed, 20 Sep 2017 15:46:12 -0700
Message-ID: <20170920224621.16236-2-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920224621.16236-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With the recently introduced omap clkctrl module binding, we can start
moving omap hwmod data to device tree and drivers from arch/arm/mach-omap2.

To start doing this, let's introduce a device tree binding for TI
sysc interconnect target module hardware. The sysc manages module clocks,
idlemodes and interconnect level resets. Each interconnect target module
can have one or more child devices connected to it.

TI sysc interconnect target module hardware is independent of the
interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
and TI L4 interconnect (Sonics s3220).

As all the features may not be supported for a given sysc module, we
need to use device tree configuration for the revision of the interconnect
target module.

Note that the interconnect target module control registers are always
sprinked at varying locations in the unused address space of the first
child device IP block. To avoid device tree reg conflicts, the sysc device
provides ranges for it's children.

For a non-intrusive transition from static hwmod data to using device
tree defined TI interconnect target module binding, we can keep things
working with static hwmod data if device tree property "ti,hwmods" is
specified for the the interconnect target module.

Note that additional properties for sysc capabilities will be added
later on. For now, we can already use this binding for interconnect
target modules that do not have any child device drivers available.
This allows us to idle the unused interconnect target modules during
init without the need for legacy hwmod platform data for doing it.

Cc: Benoît Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt | 88 +++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -0,0 +1,88 @@
+Texas Instruments sysc interconnect target module wrapper binding
+
+Texas Instruments SoCs can have a generic interconnect target module
+hardware for devices connected to various interconnects such as L3
+interconnect (Arteris NoC) and L4 interconnect (Sonics s3220).
+
+Each interconnect target module can have one or more devices connected to
+it. There is a set of control registers for managing interconnect target
+module clocks, idle modes and interconnect level resets for the module.
+
+These control registers are sprinkled into the unused register address
+space of the first child device IP block managed by the interconnect
+target module and typically are named REVISION, SYSCONFIG and SYSSTATUS.
+
+Required standard properties:
+
+- compatible	shall be one of the following generic types:
+
+		"ti,sysc-type1"
+		"ti,sysc-type2"
+		"ti,sysc-type3"
+
+		or one of the following derivative types for hardware
+		needing special workarounds:
+
+		"ti,sysc-omap3430-sr"
+		"ti,sysc-omap3630-sr"
+		"ti,sysc-omap4-sr"
+		"ti,sysc-omap3-sham"
+		"ti,sysc-omap-aes"
+		"ti,sysc-mcasp"
+		"ti,sysc-usb-host-fs"
+
+- reg		shall have register areas implemented for the interconnect
+		target module in question such as revision, sysc and syss
+
+- reg-names	shall contain the register names implemented for the
+		interconnect target module in question such as
+		"rev, "sysc", and "syss"
+
+- ranges	shall contain the interconnect target module IO range
+		available for one or more child device IP blocks managed
+		by the interconnect target module, the ranges may include
+		multiple ranges such as device L4 range for control and
+		parent L3 range for DMA access
+
+Optional properties:
+
+- clocks	clock specifier for each name in the clock-names as
+		specified in the binding documentation for ti-clkctrl,
+		typically available for all interconnect targets on TI SoCs
+		based on omap4 except if it's read-only register in hwauto
+		mode as for example omap4 L4_CFG_CLKCTRL
+
+- clock-names	should contain "clkctrl"
+
+- ti,hwmods	optional TI interconnect module name to use legacy
+		hwmod platform data
+
+
+Example: Single instance of MUSB controller on omap4 using interconnect ranges
+using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
+
+	target-module@2b000 {		/* 0x4a0ab000, ap 84 12.0 */
+		compatible = "ti,sysc-type1";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x2b400 0x4>,
+		      <0x2b404 0x4>,
+		      <0x2b408 0x4>;
+		reg-names = "rev", "sysc", "syss";
+		ranges = <0 0x2b000 0x1000>;
+		clocks = <&l3_init_clkctrl OMAP4_USB_OTG_HS_CLKCTRL 0>;
+		clock-names = "clkctrl";
+
+		usb_otg_hs: otg@0 {
+			compatible = "ti,omap4-musb";
+			reg = <0x0 0x7ff>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			usb-phy = <&usb2_phy>;
+			...
+		};
+	};
+
+Note that other SoCs, such as am335x can have multipe child devices. On am335x
+there are two MUSB instances, two USB PHY instances, and a single CPPI41 DMA
+instance as children of a single interconnet target module.
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
