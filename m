From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dra762: hwmod: Add MCAN support
Date: Thu, 17 May 2018 14:04:50 -0700
Message-ID: <20180517210450.GP98604@atomide.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
 <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
 <20180501152615.GB98604@atomide.com>
 <b4d95a08-82fd-9f39-53e7-977351788c88@ti.com>
 <20180515171459.GP98604@atomide.com>
 <20180515171808.GR98604@atomide.com>
 <20180515172324.GS98604@atomide.com>
 <b3456763-2f82-9a0b-d166-ddf7965fc162@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3456763-2f82-9a0b-d166-ddf7965fc162@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180517 08:14]:
> On Tuesday 15 May 2018 10:53 PM, Tony Lindgren wrote:
> > And I'm guessing the top level module with sysconfig related
> > registers is named "adc" :)
> > 
> 
> Yes. The MCAN clocks are controlled by the ADC_CLKCTRL register.
> Please see TRM:
> http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=spruie9&fileType=pdf
> page: 1530

Thanks that helps :) Looks like we have:

MCANSS_PID      rev             0
MCANSS_CTRL     sysconfig       0x4
MCANSS_STAT     sysstatus       0x8

With current Linux next, this should work with just ti-sysc if
we added yet another sysconfig layout.. See

Documentation/devicetree/bindings/bus/ti-sysc.txt

Looks like this is not quite "ti,sysc-omap4" as there are no
ti,sysc-midle or ti,sysc-sidle, and sysstatus reset bit is
inverted..

Anyways, I think the dts part should be similar to this with
the new sysconfig added (untested):

target-module@42c00000 {
	compatible ="ti,sysc-yet-to-be-determined";
	ti,hwmods = "mcan";
	reg = <0x42c00000 4>,
	      <0x42c00004 4>,
	      <0x42c00008 4>;
	reg-names = "rev", "sysc", "syss";
	clocks = <&wkupaon_clkctrl CM_WKUPAON_ADC_CLKCTRL>;
	clock-names = "fck";
	ti,sysc-mask = <(SYSC_OMAP4_SOFTRESET | SYSC_DRA7_ENAWAKEUP)>;
	ti,syss-mask = <1>;
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0x42c00000 0x2000>;

	mcan@0 {
		compatible = "bosch,m_can";
		reg = <0x1a00 0x4000>,
		      <0 0x18fc>;
		reg-names = "m_can", "message_ram";
		interrupt-parent = <&gic>;
		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "int0", "int1";
		clocks = <&mcan_clk>, <&l3_iclk_div>;
		clock-names = "cclk", "hclk";
		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
	};
};

You'd have to add a new struct sysc_regbits to ti-sysc.c similar
to sysc_regbits_omap4 for the .srst_shift = 0. Not sure if the same
register layout is used for other modules, but might be worth checking
the TRM. Also the clock node is missing for wkupaon_clkctrl from
include/dt-bindings/clock/dra7.h.

If the "message_ram" can operate independent of the driver,
it could be a separate child node under the target-module.

In the hwmod you still need the struct omap_hwmod for now,
but clocks should no longer be needed there.

Regards,

Tony
