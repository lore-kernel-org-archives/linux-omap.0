From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Thu, 12 May 2016 13:26:57 -0700
Message-ID: <20160512202656.GU5995@atomide.com>
References: <20160504172634.GS5995@atomide.com>
 <572A38FD.9050801@ti.com>
 <20160505184609.GB5995@atomide.com>
 <2822D1C2B9B19F4A8261F756A13373F801BEF7B4@DFLE11.ent.ti.com>
 <CAPjucKb+4vd8Ar3MATCuTx+9R36PeB0hbvwDaAD1KTZFCiVJEA@mail.gmail.com>
 <2822D1C2B9B19F4A8261F756A13373F801BF86D2@DFLE11.ent.ti.com>
 <2822D1C2B9B19F4A8261F756A13373F801BF8703@DFLE11.ent.ti.com>
 <CAPjucKb2PLSZcD3YZ9xQk1F62ugFaGAkBBqMp5GmoWFd0H8Vfg@mail.gmail.com>
 <20160512165755.GR5995@atomide.com>
 <5734D733.9060400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5734D733.9060400@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Eduard Gavin <egavin@iseebcn.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>, =?utf-8?Q?Agust=C3=AD?= Fontquerni <af@iseebcn.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160512 12:21]:
> On 05/12/2016 11:57 AM, Tony Lindgren wrote:
> > + * LDO7 is used for HDMI: VDDA_DSIPORTA - ball AA33, VDDA_DSIPORTC - ball AE33
> > + * VDDA_HDMI - ball AN25. LDO4 is: VPP1 - ball AD9.
> 
> We should set ldo4_reg as 2v as well (default in omap5-board-common is
> 1.8v). VPP1 should be 2v to prevent efuse from being messed up.

Oh OK, here's the patch updated for ldo4.

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 12 May 2016 09:51:51 -0700
Subject: [PATCH] ARM: dts: Fix ldo7 source for HDMI on igepv5

Fix ldo7 source for HDMI on igepv5.

Suggested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -35,6 +35,22 @@
 	};
 };
 
+/* LDO4 is VPP1 - ball AD9 */
+&ldo4_reg {
+	regulator-min-microvolt = <2000000>;
+	regulator-max-microvolt = <2000000>;
+};
+
+/*
+ * LDO7 is used for HDMI: VDDA_DSIPORTA - ball AA33, VDDA_DSIPORTC - ball AE33,
+ * VDDA_HDMI - ball AN25
+ */
+&ldo7_reg {
+	status = "okay";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
 &omap5_pmx_core {
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
