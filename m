From: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/10] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
Date: Mon, 25 Sep 2017 19:21:20 +0200
Message-ID: <20170925172120.xu6k3leg4ac6mjya@squirrel.local>
References: <20170920224621.16236-1-tony@atomide.com>
 <20170920224621.16236-2-tony@atomide.com>
 <20170925063545.nn3gr5drea6o2g6m@squirrel.local>
 <20170925142520.GE4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170925142520.GE4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 25, 2017 at 07:25:20AM -0700, Tony Lindgren wrote:
> * Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [170924 23:36]:
> > Is the meaning of these documented anywhere?  I'm assuming one of them
> > corresponds to the standard omap2/3 sysconfig/sysstatus
>
> Yes that's the type1 sysc.
>
> > and one to the standard omap4/5 sysconfig
>
> Yeah and that's what we call sysc type 2 in the kernel.

Might it then not make more sense to call those something like
ti,omap2-sysc and ti,omap4-sysc respectively?

> The sysc type3 is what we have on am335x/ti81xx, see:
>
> $ git grep -B10 -A1 "&omap_hwmod_sysc_type3" arch/arm/mach-omap2

Ah... three "foreign" modules with an idlemode carelessly thrown into a
register without care for existing layouts.  I think these are more just
exceptional cases which happen to agree by coincidence since they all
just added idlemode in the simplest way possible, but I can understand
how it came to be viewed as a standard type.

> > ISS (omap4/5, dm814x) is also fun since it has top-level sysconfig, but
> > most of the child modules (e.g. isp5 and simcop) also have their own
> > sysconfig, and some child modules of simcop again have sysconfig.
>
> Interesting. Sounds like there's yet another interconnect instance
> lurking there similar to L4 ABE?

ISS has a 32-bit configuration interconnect and a 64/128-bit data
interconnect:
      .......................................
     :              ISS                      :
     :                                       :
L3 --:--> configuration interconnect <-------:-- Cortex-M3/M4 subsystem
     :      ||||||||||        |   |          :
     :      vvvvvvvvvv        |   |          :
     :      submodules        |   '---.      :
     :       ||||||||         |       |      :
     :       vvvvvvvv         v       v      :
     : data interconnect --> BTE --> CBUFF --:--> L3
     '.......................................'

It also has a local prcm controller to manage all this, and an irq
combiner.  See the section "ISS Power Management" (8.1.2.4 in the public
omap5 TRM, SWPU249AF) for a better diagram of all this.  The various
versions of ISS differ somewhat in the submodules but all share the same
overall structure.

One of the ISS submodules, SIMCOP, is itself again a fairly complicated
subsystem with two local interconnects, of which you can find a block
diagram in the "ISS Still Image Coprocessor" chapter (8.4).

Having a local interconnect is itself not a particularly rare thing (you
can find one in ABE, DSS, CPSW, PRUSS, PWMSS, etc), but ISS does have
unusual complexity with its multiple interconnects and nested subsystems.

Matthijs
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
