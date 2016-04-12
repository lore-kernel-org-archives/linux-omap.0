From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/30] ARM: OMAP2+: hwmod module clock type support
Date: Tue, 12 Apr 2016 08:58:30 -0700
Message-ID: <20160412155829.GM5995@atomide.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
 <20160412145819.GA25032@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160412145819.GA25032@rob-hp-laptop>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Rob Herring <robh@kernel.org> [160412 07:59]:
> On Mon, Apr 11, 2016 at 11:18:51AM +0300, Tero Kristo wrote:
> > Hi,
> > 
> > This series transfers the hwmod clkctrl handling from the hwmod core
> > under clock driver, the data is also transferred from hwmod data to
> > devicetree. Done for most of the OMAP2+ platforms, except OMAP2 / OMAP3,
> > where work is still under progress.
> 
> Some high level questions.
> 
> Why a DT node per clock? We've pretty much decided that is a bad idea 
> in the complex cases. TI chips certainly fall in the complex case.

Well the clkctrl instances are separate independent devices under each
clockdomain, so having a proper DT node for them makes sense to me.

It's not like the clkctrl registers are just outputs of a single clock.
A clockdomain typically has multiple inputs that are then routed in
some combination to the clkctrl modules.

I think we can group them though, here's how I'd like to set these up.
This from dts point of view modelling omap4 TRM "3.11.16.1 WKUP_CM
Register Summary":

cm_wkup: clock@1800 {	/* offset from prm_clocks at 0x4a306000 */
	...
	reg = <0x1800 0x100>;
	ranges = <...>;
	...

	gpio1_mod_ck: clock@38 {
		compatible = "ti,clock-abc";
		reg = <0x38 0x10>;
		clocks = <...>;
		ranges = <...>;
		...
		gpio1_dbclk: clock@8 {
			#address-cells = <1>;
			#size-cells = <0>;
			ranges = <...>;
			compatible = "ti,clock-db";
			reg = <8>;	/* bit offset */
			...
		};
	};

	counter_32k_mod_ck: clock@50 {
		compatible = "ti,clock-xyz";
		reg = <0x50 0x10>;
		clocks = <...>;
		...
	};
	...
};

This then allows adding support for the clockdomain CLKSTCTRL and
DYNAMICKDEP registers later on.

Then I'd like to also have consumers be able to reference these using
one of the two methods:

1.	clocks = <&counter_32k_mod_ck>;
2.	clocks = <&cm_wkup 0x50>;

And the gpio1 debounce clock could be addressed with one of:

1.	clocks = <&gpio1_dbclk>;
2.	clocks = <&gpio1_mod_ck 8>;

> You are changing compatible strings and possibly breaking compatibility. 
> Don't do that or justify why.

Yes Tero please check those, we need to support the old behavior too.
Sounds like you figured that out how to do that alreadey by generating
the clock name for the built-in data.

Regards,

Tony
