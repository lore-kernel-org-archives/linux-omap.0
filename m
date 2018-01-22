From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Mon, 22 Jan 2018 09:03:43 -0800
Message-ID: <20180122170343.GD4180@atomide.com>
References: <1516095054.9022.1.camel@pengutronix.de>
 <20180116150314.GC4042@atomide.com>
 <d32d9836-5edd-d43d-547b-f22384950f2c@ti.com>
 <20180116232243.GD4042@atomide.com>
 <10dab35c-9c79-5a77-0654-1e99621e4c0f@ti.com>
 <20180119213310.GA4180@atomide.com>
 <06882c43-d689-2b85-a1c4-ae4e13a73046@ti.com>
 <20180119234938.GB4180@atomide.com>
 <d5e1dda3-fb89-9280-6d68-b02996b5cd0c@ti.com>
 <20180120005551.GC4180@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180120005551.GC4180-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Parsons <lost.distance-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishant Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [180120 00:56]:
> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [180120 00:43]:
> > We definitely do not want the two resets here for sure, as the rst2
> > belongs to the dsp core (I believe it would be a sibling node to mmu_dsp
> > here), and cannot be released from reset without programming the MMU and
> > loading the code.
> 
> OK thanks, I'll give that a try next week at some point.

Actually there is only the DSP MMU in the interconnect
target module at 0x4a066000. It's size is just the usual 4K,
and there is no sibling to DSP MMU in that interconnect target
module between 0x4a0660100 and 0x4a066ffff.

So it seems the DSP MMU dts should become as below, and I've
confirmed it works for me for taking DSP MMU out of reset,
dumping out the revision register while not taking the DSP
out of reset. The rst2 is for MMU and rst1 is for DSP at
least on omap4. Taking rst1 out of reset will cause tons of
L3 interrupts as the DSP starts booting at some uncofigured
address :)

The following patch still needs my yet to be posted patches
to do anything, so just for reference for now. The
-EPROBE_DEFER I was getting earlier was the missing
"simple-bus" for probing children at the prm level.

And it seems that the interconnect target module driver ti-sysc
can claim rst2 and the ocp softreset, and if the iommu driver
ever needs to do a reset on the whole module for some reason,
it can call device_reset(dev->parent, 0);

Regards,

Tony

8< -------------------
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -249,13 +249,26 @@
 				};
 
 				prm: prm@6000 {
-					compatible = "ti,omap4-prm";
+					compatible = "ti,omap4-prm", "simple-bus";
 					reg = <0x6000 0x3000>;
 					interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					ranges = <0 0x6000 0x3000>;
 
+					prm_dsp: prm@400 {
+						compatible = "simple-bus";
+						#address-cells = <1>;
+						#size-cells = <1>;
+						ranges = <0 0x400 0x100>;
+
+						dsp_rstctrl: rstctrl@10 {
+							compatible = "ti,rstctrl";
+							reg = <0x10 0x4>;
+							#reset-cells = <1>;
+						};
+					};
+
 					prm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -892,12 +905,36 @@
 			};
 		};
 
-		mmu_dsp: mmu@4a066000 {
-			compatible = "ti,omap4-iommu";
-			reg = <0x4a066000 0x100>;
-			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		target-module@4a066000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "mmu_dsp";
-			#iommu-cells = <0>;
+			reg = <0x4a066000 0x4>,
+			      <0x4a066010 0x4>,
+			      <0x4a066014 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			clocks = <&tesla_clkctrl OMAP4_DSP_CLKCTRL 0>;
+			clock-names = "fck";
+			/* rst2 is for mmu, rst1 is for dsp */
+			resets = <&dsp_rstctrl 1>;
+			reset-names = "rst2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a066000 0x1000>;
+
+			mmu_dsp: mmu@0 {
+				compatible = "ti,omap4-iommu";
+				reg = <0 0x100>;
+				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				resets = <&dsp_rstctrl 0>;
+				reset-names = "rst1";
+				#iommu-cells = <0>;
+			};
 		};
 
 		target-module@52000000 {
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
