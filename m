From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
 regulator_init_data
Date: Mon, 24 Oct 2011 11:07:34 +0200
Message-ID: <20111024090734.GD8708@ponder.secretlab.ca>
References: <20111019053354.GB31162@S2100-06.ap.freescale.net>
 <20111019144734.GI18713@sirena.org.uk>
 <20111019150448.GB32007@S2100-06.ap.freescale.net>
 <20111019151031.GA4275@opensource.wolfsonmicro.com>
 <4E9F9892.9070007@ti.com>
 <20111020094140.GK18713@sirena.org.uk>
 <20111020162743.GB31337@atomide.com>
 <20111020164006.GA10155@sirena.org.uk>
 <20111020170534.GC31337@atomide.com>
 <20111020172218.GE31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111020172218.GE31337@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 20, 2011 at 10:22:19AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [111020 09:31]:
> > 
> > That's where a DT entry specific configuration string might be the best
> > option as it still allows describing the hardware using DT standards,
> > while also allowing board specific configuration too.
> 
> Hmm, actually, can't we just pass the board specific configuration in
> the board specific .dts file and then it gets merged in with the
> arch independent DT node?

It would be fine to, say, have a omap-specific board configuration
node for collecting things that really don't fit anywhere else.  That
would be in some ways analogous to the way we've decided to use top a
top level node for describing a machines audio complex.

g.
