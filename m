From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH] Documentation: dt: bindings: TI WiLink modules
Date: Fri, 28 Jun 2013 12:53:35 +0300
Message-ID: <1372413215.21065.41.camel@cumari.coelho.fi>
References: <1372149330-24335-1-git-send-email-coelho@ti.com>
	 <20130628093848.GA2139@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130628093848.GA2139@e106331-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-arm@vger.kernel.org" <linux-arm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2013-06-28 at 10:38 +0100, Mark Rutland wrote:
> On Tue, Jun 25, 2013 at 09:35:30AM +0100, Luciano Coelho wrote:
> > +Optional properties:
> > +--------------------
> > +
> > +- refclock: the internal WLAN reference clock frequency (required for
> > +  WiLink6 and WiLink7; not used for WiLink8).  Must be one of the
> > +  following:
> > +	0 = 19.2 MHz
> > +	1 = 26.0 MHz
> > +	2 = 38.4 MHz
> > +	3 = 52.0 MHz
> > +	4 = 38.4 MHz, XTAL
> > +	5 = 26.0 MHz, XTAL
> > +
> > +- tcxoclock: the internal WLAN TCXO clock frequency (required for
> > +  WiLink7 not used for WiLink6 and WiLink8).  Must be one of the
> > +  following:
> > +	0 = 19.200 MHz
> > +	1 = 26.000 MHz
> > +	2 = 38.400 MHz
> > +	3 = 52.000 MHz
> > +	4 = 16.368 MHz
> > +	5 = 32.736 MHz
> > +	6 = 16.800 MHz
> > +	7 = 33.600 MHz
> 
> This looks suspiciously like what we have the common clock bindings for:
> 
> refclk {
> 	compatible = "fixed-clock";
> 	#clock-cells = <0>;
> 	clock-frequency = <19200000>;
> }
> 
> wilink {
> 	compatible = "ti,wilink7";
> 	interrupt-parent = <&some_interrupt_controller>;
> 	interrupts = <0 1 1>;
> 	clocks = <&refclk>, <&refclk>;
> 	clock-names = "refclk", "txoclk";
> };
> 
> Could you not use them?

Hmmm... this actually does look good.  But these are internal clocks in
the modules, they cannot be accessed from outside.  Does it make sense
to register them with the clock framework?

--
Luca.

