From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/9] dt-bindings: ti-sysc: Update binding for timers and
 capabilities
Date: Wed, 20 Dec 2017 12:10:51 -0600
Message-ID: <20171220181051.eoftsww6463hyak3@rob-hp-laptop>
References: <20171215180900.3243-1-tony@atomide.com>
 <20171215180900.3243-2-tony@atomide.com>
 <20171216183059.ipsftfnvsyamv6fd@rob-hp-laptop>
 <20171216192222.GH3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171216192222.GH3875@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 16, 2017 at 11:22:22AM -0800, Tony Lindgren wrote:
> * Rob Herring <robh@kernel.org> [171216 18:33]:
> > >  Optional properties:
> > >  
> > > +- ti,sysc-mask	shall contain mask of supported register bits for the
> > > +		SYSCONFIG register as documented in the Technical Reference
> > > +		Manual (TRM) for the interconnect target module
> > > +
> > > +- ti,sysc-midle	list of master idle modes supported by the interconnect
> > > +		target module as documented in the TRM for SYSCONFIG
> > > +		register MIDLEMODE bits
> > > +
> > > +- ti,sysc-sidle	list of slave idle modes supported by the interconnect
> > > +		target module as documented in the TRM for SYSCONFIG
> > > +		register SIDLEMODE bits
> > > +
> > > +- ti,sysc-delay-us	delay needed after OCP softreset before accssing
> > > +			SYSCONFIG register again
> > > +
> > > +- ti,syss-mask	optional mask of reset done status bits as described in the
> > > +		TRM for SYSSTATUS registers, typically 1 with some devices
> > > +		having separate reset done bits for children like OHCI and
> > > +		EHCI
> > > +
> > 
> > Seems like a lot of this should be implied by specific compatible 
> > strings.
> 
> Unfortunately that would still explode the permutations to almost
> one compatible per module especially for types "ti,sysc-omap2" and
> "ti,sysc-omap4". And the features and idle modes supported by the
> module are all over the place for "ti,sysc-mask", "ti,sysc-midle",
> "ti,sysc-sidle" and "ti,syss-mask"..

Okay.

> I was planning to have "ti,sysc-delay-us" only in the driver, but
> the same IP needs it set on dm814x while not on omap4 for OTG
> for example. I could add SoC specific quirks to the driver
> for that one if you prefer that instead?

No, I don't have a preference.

> I do have a patch also I'm testing to use the revision register
> value for handling further quirks, but unfortunately that
> register is not populated or updated for many modules. And it's
> only usable after the module is already configured to accessible :)
> 
> > Are the bits you've defined all of them or there's more?
> 
> That's it, with this binding I've allocated the data from dts
> for the tests I've done. So that should allow us to replace the
> static data to start with as seen with the following command:
> 
> $ git grep -A10 "struct omap_hwmod_class_sysconfig" \
> 	arch/arm/*hwmod*data*.c
> ...
> 
> So that's to configure a big pile of different module
> configurations we currently have as can be seen with:
> 
> $ git grep "struct omap_hwmod_class_sysconfig" \
> 	arch/arm/*hwmod*data*.c | wc -l
> 194
> 
> I'm sure there's still few duplicates there though..

Okay, then I guess I'm okay with this.

Reviewed-by: Rob Herring <robh@kernel.org>
