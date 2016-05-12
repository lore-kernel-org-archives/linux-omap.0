From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
Date: Thu, 12 May 2016 09:57:56 -0700
Message-ID: <20160512165755.GR5995@atomide.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com>
 <572A38FD.9050801@ti.com>
 <20160505184609.GB5995@atomide.com>
 <2822D1C2B9B19F4A8261F756A13373F801BEF7B4@DFLE11.ent.ti.com>
 <CAPjucKb+4vd8Ar3MATCuTx+9R36PeB0hbvwDaAD1KTZFCiVJEA@mail.gmail.com>
 <2822D1C2B9B19F4A8261F756A13373F801BF86D2@DFLE11.ent.ti.com>
 <2822D1C2B9B19F4A8261F756A13373F801BF8703@DFLE11.ent.ti.com>
 <CAPjucKb2PLSZcD3YZ9xQk1F62ugFaGAkBBqMp5GmoWFd0H8Vfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPjucKb2PLSZcD3YZ9xQk1F62ugFaGAkBBqMp5GmoWFd0H8Vfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduard Gavin <egavin@iseebcn.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>, =?utf-8?Q?Agust=C3=AD?= Fontquerni <af@iseebcn.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Eduard Gavin <egavin@iseebcn.com> [160509 07:43]:
> Dear Nishanth,
>   In igepV5 the LDO7 is connected to:
>     VDDA_DSIPORTA - ball AA33
>     VDDA_DSIPORTC - ball AE33
>     VDDA_HDMI - ball AN25
>   LDO4 is connected to:
>     VPP1 - ball AD9

Thanks for the info, here's an updated patch with comments and now
using 1.8V instead of the 2.0V omap5-board-common.dtsi.

Regards,

Tony

8< -----------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 9 May 2016 07:51:00 -0700
Subject: [PATCH] ARM: dts: Fix ldo7 source for HDMI on igepv5

Fix ldo7 source for HDMI on igepv5.

Suggested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -35,6 +35,16 @@
 	};
 };
 
+/*
+ * LDO7 is used for HDMI: VDDA_DSIPORTA - ball AA33, VDDA_DSIPORTC - ball AE33
+ * VDDA_HDMI - ball AN25. LDO4 is: VPP1 - ball AD9.
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
