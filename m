From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH v5 00/16] OMAP2+ OneNAND driver update
Date: Wed, 10 Jan 2018 22:13:25 +0100
Message-ID: <20180110211325.GA1938@lenoch>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
 <20171130111840.41c92d34@bbrezillon>
 <20171130160936.GO28152@atomide.com>
 <434bd733-0ba2-6e75-9de5-017eef905fd2@ti.com>
 <20180109130812.GA338@lenoch>
 <20180109210114.s66rpdg2jjdps5bc@darkstar.musicnaut.iki.fi>
 <20180110092058.GA25351@lenoch>
 <20180110173519.xyug4egltni4f3qi@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180110173519.xyug4egltni4f3qi-4/PLUo9XfK9owWHViPbQSXlKr5M7+etX9Sl0XMgJPXI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+Rob and the DT ML

On Wed, Jan 10, 2018 at 07:35:19PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jan 10, 2018 at 10:20:58AM +0100, Ladislav Michl wrote:
> > On Tue, Jan 09, 2018 at 11:01:14PM +0200, Aaro Koskinen wrote:
> > > On Tue, Jan 09, 2018 at 02:08:12PM +0100, Ladislav Michl wrote:
> > > > Merge window is really close now and patches seems still to be untested on
> > > > n8x0. So unless someone is going to test it soon, I'll pick used N800 on
> > > > ebay :-/
> > > 
> > > Today I tried to test them on Nokia N810, and I get:
> > > 
> > > [    0.174804] omap-gpmc 6800a000.gpmc: GPMC revision 2.0
> > > [    0.174865] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> > > [    0.177459] omap-gpmc 6800a000.gpmc: /ocp/gpmc@6800a000/onenand@0,0 has no 'bank-width' property
> > > [    0.177612] omap-gpmc 6800a000.gpmc: failed to probe DT child 'onenand': -22
> > > 
> > > With plain v4.15-rc7+ it probes fine.
> > 
> > Thank you for testing. As stated in cover letter, you need also
> > https://patchwork.kernel.org/patch/10043259/
> > which can be also found in Roger's branch
> > https://github.com/rogerq/linux/commits/for-v4.16/gpmc-omap-immutable
> > (see previous replies in this thread and also discussion about OneNAND
> > DT node)
> 
> I applied it, and now get:
> 
> [    0.174987] omap-gpmc 6800a000.gpmc: GPMC revision 2.0
> [    0.175048] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> [    0.177703] omap-gpmc 6800a000.gpmc: Incompatible OneNAND node: missing compatible
> [    0.177764] omap-gpmc 6800a000.gpmc: failed to probe DT child 'onenand': -22

As expected without reading discussion about OneNAND DT node :)

In short, this version expects "ti,omap2-onenand" compatible.

In earlier version of this patchset there was fixup present, so driver
worked even without compatible. Later on (17 Oct 2017 11:46:51 +0300)
Roger objected (https://www.spinics.net/lists/linux-omap/msg139576.html):
"I don't want to fixup broken DTs like this as they will go silently without
being fixed. Let's instead just error out after the dev_warn(). This will
force us to fix all DT nodes."
So fixup was removed. I know N900 support is under heavy development
in mainline, but if n8x0 is considered finished and stable, we should
reintroduce fixup. Thoughts?

Thank you for your patience,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
