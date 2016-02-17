From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: adpll: Add binding documentation
 for TI adpll
Date: Wed, 17 Feb 2016 09:28:36 -0800
Message-ID: <20160217172836.GA21202@atomide.com>
References: <1455312009-808-1-git-send-email-tony@atomide.com>
 <1455312009-808-2-git-send-email-tony@atomide.com>
 <20160217010440.2278.62327@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160217010440.2278.62327@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Michael Turquette <mturquette@baylibre.com> [160216 17:17]:
> Quoting Tony Lindgren (2016-02-12 13:20:08)
> > +Required properties:
> > +- compatible : shall be one of "ti,dm814-adpll-s-clock" or
> > +  "ti,dm814-adpll-lj-clock" depending on the type of the ADPLL
> > +- #clock-cells : from common clock binding; shall be set to 0.
> 
> Thanks for the patch.
> 
> clock-cells = 1 in both of the examples below (which looks right).

Oops thanks, will update to 1.

> > +- clocks : link phandles of parent clocks clkinp and clkinpulow, note
> > +  that the adpll-s-clock also has an optional clkinphif
> > +- reg : address and length of the register set for controlling the ADPLL.
> > +
> > +Examples:
> > +       adpll_mpu_ck: adpll@40 {
> > +               #clock-cells = <1>;
> > +               compatible = "ti,dm814-adpll-s-clock";
> > +               reg = <0x40 0x40>;
> > +               clocks = <&devosc_ck &devosc_ck &devosc_ck>;
> > +               clock-names = "clkinp", "clkinpulow", "clkinphif";
> > +               clock-indices = <0>, <1>, <2>, <3>;
> 
> Why is clock-indices necessary?

Hmm yeah I don't think it's needed, so will drop.

Regards,

Tony

