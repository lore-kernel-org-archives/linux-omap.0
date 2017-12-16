From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/9] dt-bindings: ti-sysc: Update binding for timers and
 capabilities
Date: Sat, 16 Dec 2017 11:22:22 -0800
Message-ID: <20171216192222.GH3875@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
 <20171215180900.3243-2-tony@atomide.com>
 <20171216183059.ipsftfnvsyamv6fd@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171216183059.ipsftfnvsyamv6fd@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [171216 18:33]:
> >  Optional properties:
> >  
> > +- ti,sysc-mask	shall contain mask of supported register bits for the
> > +		SYSCONFIG register as documented in the Technical Reference
> > +		Manual (TRM) for the interconnect target module
> > +
> > +- ti,sysc-midle	list of master idle modes supported by the interconnect
> > +		target module as documented in the TRM for SYSCONFIG
> > +		register MIDLEMODE bits
> > +
> > +- ti,sysc-sidle	list of slave idle modes supported by the interconnect
> > +		target module as documented in the TRM for SYSCONFIG
> > +		register SIDLEMODE bits
> > +
> > +- ti,sysc-delay-us	delay needed after OCP softreset before accssing
> > +			SYSCONFIG register again
> > +
> > +- ti,syss-mask	optional mask of reset done status bits as described in the
> > +		TRM for SYSSTATUS registers, typically 1 with some devices
> > +		having separate reset done bits for children like OHCI and
> > +		EHCI
> > +
> 
> Seems like a lot of this should be implied by specific compatible 
> strings.

Unfortunately that would still explode the permutations to almost
one compatible per module especially for types "ti,sysc-omap2" and
"ti,sysc-omap4". And the features and idle modes supported by the
module are all over the place for "ti,sysc-mask", "ti,sysc-midle",
"ti,sysc-sidle" and "ti,syss-mask"..

I was planning to have "ti,sysc-delay-us" only in the driver, but
the same IP needs it set on dm814x while not on omap4 for OTG
for example. I could add SoC specific quirks to the driver
for that one if you prefer that instead?

I do have a patch also I'm testing to use the revision register
value for handling further quirks, but unfortunately that
register is not populated or updated for many modules. And it's
only usable after the module is already configured to accessible :)

> Are the bits you've defined all of them or there's more?

That's it, with this binding I've allocated the data from dts
for the tests I've done. So that should allow us to replace the
static data to start with as seen with the following command:

$ git grep -A10 "struct omap_hwmod_class_sysconfig" \
	arch/arm/*hwmod*data*.c
...

So that's to configure a big pile of different module
configurations we currently have as can be seen with:

$ git grep "struct omap_hwmod_class_sysconfig" \
	arch/arm/*hwmod*data*.c | wc -l
194

I'm sure there's still few duplicates there though..

The only pending binding change I'm aware of is the optional
extra clocks, but that still pending and just uses the
standard clock binding.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
