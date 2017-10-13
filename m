From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Patch 5/6] ARM: DRA7: hwmod: Add VPE nodes
Date: Fri, 13 Oct 2017 12:01:23 -0700
Message-ID: <20171013190122.GT4394@atomide.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-6-bparrot@ti.com>
 <20171013170513.GM4394@atomide.com>
 <20171013180534.GI25400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013180534.GI25400-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [171013 11:06]:
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote on Fri [2017-Oct-13 10:05:13 -0700]:
> > * Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [171012 12:28]:
> > > +static struct omap_hwmod_class_sysconfig dra7xx_vpe_sysc = {
> > > +	.sysc_offs	= 0x0010,
> > > +	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
> > > +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> > > +			   MSTANDBY_FORCE | MSTANDBY_NO |
> > > +			   MSTANDBY_SMART),
> > > +	.sysc_fields	= &omap_hwmod_sysc_type2,
> > > +};
> > 
> > I think checkpatch.pl --strict would complain about unnecessary
> > parentheses, might as well check the whole series while at it.
> 
> I actually ran the whole series through "checkpatch.pl --strict"
> before posting. And other then the usual MAINTAINER file needing
> update warning for the binding patch it no other warning or error.
> 
> Based on the rest of the file I believe the parentheses around those
> flags are at least consistent.

OK fine thanks for checking.

> Now, would the .rev_offs comment also apply here?

I don't think it has it, you might want to dump out the value
at offset 0 and see if it contains anything.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
