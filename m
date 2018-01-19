From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Fri, 19 Jan 2018 15:49:38 -0800
Message-ID: <20180119234938.GB4180@atomide.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de>
 <20180116150314.GC4042@atomide.com>
 <d32d9836-5edd-d43d-547b-f22384950f2c@ti.com>
 <20180116232243.GD4042@atomide.com>
 <10dab35c-9c79-5a77-0654-1e99621e4c0f@ti.com>
 <20180119213310.GA4180@atomide.com>
 <06882c43-d689-2b85-a1c4-ae4e13a73046@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06882c43-d689-2b85-a1c4-ae4e13a73046@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [180119 23:30]:
> On 01/19/2018 03:33 PM, Tony Lindgren wrote:
> > OK let's do some tests on that, I'll take a look at doing a dts
> > file over next few weeks.
> 
> You can look up the patches folder in the above repo, there are some
> example nodes there already, they are rather straight-forward.

Just for reference, here's what I played with but keep getting
-EPROBE_DEFER somewhere during init.

Regards,

Tony

	prm: prm@6000 {
		...
		ranges = <0 0x6000 0x3000>;

		prm_dsp: prm@400 {
			compatible = "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x400 0x100>;

			dsp_rstctrl: rstctrl@10 {
				compatible = "ti,rstctrl";
				reg = <0x10 0x4>;
				#reset-cells = <1>;
			};
		};
		...
	};

	target-module@4a066000 {
		compatible = "ti,sysc-omap2", "ti,sysc";
		ti,hwmods = "mmu_dsp";
		reg = <0x4a066000 0x4>,
		      <0x4a066010 0x4>,
		      <0x4a066014 0x4>;
		reg-names = "rev", "sysc", "syss";
		ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
				 SYSC_OMAP2_SOFTRESET |
				 SYSC_OMAP2_AUTOIDLE)>;
		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
				<SYSC_IDLE_NO>,
				<SYSC_IDLE_SMART>;
		clocks = <&tesla_clkctrl OMAP4_DSP_CLKCTRL 0>;
		clock-names = "fck";
		resets = <&dsp_rstctrl 1>,
			 <&dsp_rstctrl 0>;
		reset-names = "rst2", "rst1";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 0x4a066000 0x1000>;

		mmu_dsp: mmu@0 {
			compatible = "ti,omap4-iommu";
			reg = <0 0x100>;
			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
			#iommu-cells = <0>;
		};
	};
