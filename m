From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: omap5: describe control for ckobuffer
Date: Thu, 28 Apr 2016 11:03:32 +0300
Message-ID: <5721C3D4.7040401@ti.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com>
 <20160426172710.GI5995@atomide.com>
 <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
 <5720B107.4000907@ti.com>
 <A90F1BFC-A834-4EC0-81F9-2C8222AAA010@goldelico.com>
 <5720C85B.9010701@ti.com> <ce9a7840-e86f-0d0c-3ed6-a571eec6659d@ti.com>
 <40536322-073F-48BD-9D07-32B9A9F07AF2@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40536322-073F-48BD-9D07-32B9A9F07AF2@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On 27/04/16 17:35, H. Nikolaus Schaller wrote:
> HI,
>
>> Am 27.04.2016 um 16:23 schrieb Peter Ujfalusi <peter.ujfalusi@ti.com>:
>>
>> On 04/27/2016 05:10 PM, Tero Kristo wrote:
>>> On 27/04/16 16:10, H. Nikolaus Schaller wrote:
>>>>
>>>>> Am 27.04.2016 um 14:31 schrieb Tero Kristo <t-kristo@ti.com>:
>>>>>
>>>>> On 27/04/16 09:04, H. Nikolaus Schaller wrote:
>>>>>>
>>>>>>> Am 26.04.2016 um 19:27 schrieb Tony Lindgren <tony@atomide.com>:
>>>>>>>
>>>>>>> Tero,
>>>>>>>
>>>>>>> * H. Nikolaus Schaller <hns@goldelico.com> [160418 11:23]:
>>>>>>>> OMAP5 has a register to control if the ckobuffer is enabled
>>>>>>>> and defines the polarity. ckobuffer is required to drive a twl6040
>>>>>>>> with the system clock. Hence, add the pinctrl,single to the
>>>>>>>> OMAP5 SoC description so that omap5-board-common can
>>>>>>>> set up the ckobuffer as required.
>>>>>>>
>>>>>>> Is this really a mux or should it be a mux clock?
>>>>>>
>>>>>> It is a pinmux setting for the clock out buffer to choose what signal
>>>>>> (and polarity) is presented on the fref_xtal_clk pad.
>>>>>>
>>>>>> The register is part of the CTRL_MODULE_WKUP.
>>>>>> The clock signal is the xtal master clock of the whole SoC.
>>>>>>
>>>>>> Although there is a bit to choose an alternate clock, there is no
>>>>>> alternate in the OMAP5 silicon.
>>>>>>
>>>>>> Therefore I would say it is about padconf and not clock or clock mux
>>>>>> related.
>>>>>>
>>>>>> It just happens to be a clock signal which can be routed to this
>>>>>> pad.
>>>>>
>>>>> The two could very well be implemented as clock nodes, a mux and a gate.
>>>>> This would describe the hardware functionality better imo, if the
>>>>> assumptions made here are correct. Implementing the control as pinctrl
>>>>> hacks looks rather weird to me.
>>>>
>>>> Why do you consider it a "pinctrl hack"? IMHO it is not a hack, but 100%
>>>> proper use of pinctrl.
>>>
>>> It is just the level of abstraction we are talking about here. If it is a
>>> clock we are controlling, we should rather control it as a clock (higher level
>>> abstraction), not a pin.
>>
>> I second this. I think it is better to have a simple gate clock and handle
>> only CONTROL_CKOBUFFER:CKOBUFFER_CLK_EN (bit 28) only as the other bits does
>> not have real use.
>>
>> Then we can add clk API support for this. On most OMAP4 devices the clock is
>> always on,
>
> this is why I am raising the question if we really want to control it on the omap5 or just
> turn it on for all omap5 boards like the omap4 appears to do... I.e. if turning the pin on
> as a pinctrl is IMHO sufficient for all practical purposes.
>
>> so the board DTS file need to provide a dummy clock, or we can make
>> the high precision clock also as optional (on panda both OMAP4 and twl6040
>> uses the same reference clock).
>
> Hm. It looks as if implementing this (and clock gating) is beyond my experiences.
> But I am happy to test a proposal on our omap5 board.
>
> BR and thanks,
> Nikolaus

See the inline patch, this implements the fref_xtal_ck. I had to add 
some kernel code also to cope with the new SCM area, but the same area 
can now be accessed via syscon also if needed.

From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 28 Apr 2016 11:00:57 +0300
Subject: [PATCH] ARM: omap5: add support for fref_xtal_ck

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
  arch/arm/boot/dts/omap5.dtsi           | 22 ++++++++++++++++++++++
  arch/arm/boot/dts/omap54xx-clocks.dtsi | 10 ++++++++++
  arch/arm/mach-omap2/control.c          | 20 ++++++++++++++++----
  include/linux/clk/ti.h                 |  1 +
  4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 38805eb..bdc6528 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -277,6 +277,28 @@
  				pinctrl-single,register-width = <16>;
  				pinctrl-single,function-mask = <0x7fff>;
  			};
+
+			omap5_scm_wkup_pad_conf: omap5_scm_wkup_pad_conf@cda0 {
+				compatible = "ti,omap5-scm-wkup-pad-conf",
+					     "simple-bus";
+				reg = <0xcda0 0x60>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0xcda0 0x60>;
+
+				scm_wkup_pad_conf: scm_conf@0 {
+					compatible = "syscon", "simple-bus";
+					reg = <0x0 0x60>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x0 0x60>;
+
+					scm_wkup_pad_conf_clocks: clocks@0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+			};
  		};

  		ocmcram: ocmcram@40300000 {
diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi 
b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 83b425f..f970dac 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -1388,3 +1388,13 @@
  		reg = <0x021c>;
  	};
  };
+
+&scm_wkup_pad_conf_clocks {
+	fref_xtal_ck: fref_xtal_ck {
+		#clocks-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin>;
+		ti,bit-shift = <28>;
+		reg = <0x14>;
+	};
+};
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1662071..5956641 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -623,6 +623,7 @@ void __init omap3_ctrl_init(void)

  struct control_init_data {
  	int index;
+	void __iomem *mem;
  	s16 offset;
  };

@@ -635,6 +636,10 @@ static const struct control_init_data 
omap2_ctrl_data = {
  	.offset = -OMAP2_CONTROL_GENERAL,
  };

+static const struct control_init_data ctrl_aux_data = {
+	.index = TI_CLKM_CTRL_AUX,
+};
+
  static const struct of_device_id omap_scrm_dt_match_table[] = {
  	{ .compatible = "ti,am3-scm", .data = &ctrl_data },
  	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
@@ -644,6 +649,7 @@ static const struct of_device_id 
omap_scrm_dt_match_table[] = {
  	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
  	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
  	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },
+	{ .compatible = "ti,omap5-scm-wkup-pad-conf", .data = &ctrl_aux_data },
  	{ .compatible = "ti,dra7-scm-core", .data = &ctrl_data },
  	{ }
  };
@@ -660,15 +666,21 @@ int __init omap2_control_base_init(void)
  	struct device_node *np;
  	const struct of_device_id *match;
  	struct control_init_data *data;
+	void __iomem *mem;

  	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
  		data = (struct control_init_data *)match->data;

-		omap2_ctrl_base = of_iomap(np, 0);
-		if (!omap2_ctrl_base)
+		mem = of_iomap(np, 0);
+		if (!mem)
  			return -ENOMEM;

-		omap2_ctrl_offset = data->offset;
+		if (data->index == TI_CLKM_CTRL) {
+			omap2_ctrl_base = mem;
+			omap2_ctrl_offset = data->offset;
+		}
+
+		data->mem = mem;
  	}

  	return 0;
@@ -713,7 +725,7 @@ int __init omap_control_init(void)
  		} else {
  			/* No scm_conf found, direct access */
  			ret = omap2_clk_provider_init(np, data->index, NULL,
-						      omap2_ctrl_base);
+						      data->mem);
  			if (ret)
  				return ret;
  		}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index dc5164a..be25aa8 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -195,6 +195,7 @@ enum {
  	TI_CLKM_PRM,
  	TI_CLKM_SCRM,
  	TI_CLKM_CTRL,
+	TI_CLKM_CTRL_AUX,
  	TI_CLKM_PLLSS,
  	CLK_MAX_MEMMAPS
  };
