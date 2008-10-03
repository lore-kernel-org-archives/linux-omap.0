From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Fri, 3 Oct 2008 10:30:24 +0300
Message-ID: <20081003073022.GA25482@atomide.com>
References: <200810010915.46032.david-b@pacbell.net> <20081001.213437.22091635.Hiroshi.DOYU@nokia.com> <200810021350.03739.david-b@pacbell.net> <20081003.092336.243854668.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60931 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbYJCH1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 03:27:32 -0400
Content-Disposition: inline
In-Reply-To: <20081003.092336.243854668.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [081003 09:24]:
> Hi David,
>=20
> From: "ext David Brownell" <david-b@pacbell.net>
> Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
> Date: Thu, 2 Oct 2008 13:50:02 -0700
>=20
> > On Wednesday 01 October 2008, Hiroshi DOYU wrote:
> > > Or, this feature itself can be covered by 'virtual clock(vclk)'?
> > >=20
> > > =A0 =A0 http://marc.info/?l=3Dlinux-omap&m=3D122066992729949&w=3D=
2
> > >=20
> > > which means that,
> > > in this case, if 'vclk' just has a single child, not multiple, it=
 can
> > > be used just as 'aliasing' of clock names, without touching the
> > > contents of 'struct clk', since 'vclk' is a inhritance of 'struct=
 clk'.
> >=20
> <snip>
> >
> > > Some driver may need to control multiple clocks at=20
> > > once. Some may need a clock which has different names between oma=
p1,
> > > omap2/3 or target boards. Or some may need to control multiple cl=
ock
> > > groups from the functional perspective. So I think that a *flexib=
le*
> > > infrastructure would be better to afford such requiments, keeping
> > > 'struct clk' as simple as possible.
> >=20
> > That vclk stuff looked a bit less obvious than I like.
> > Maybe I just haven't seen the need for those particular
> > flavors of flexibility.
>=20
> I've looked around for some examples;). For this abstruction (or
> logical clock view), one of the case which clk_associate doesn't deal
> with is to handle multiple clocks together. There are some cases,
> where multiple clocks are handled(enable/disable) at once as below:
>=20
>  drivers/usb/gadget/omap_udc.c:	omap_udc_enable_clock()
>  drivers/video/omap/rfbi.c:	rfbi_enable_clocks()
>  arch/arm/mach-omap2/mcbsp.c:	omap_mcbsp_clk_enable()*1
>  arch/arm/mach-omap2/serial.c:	omap_serial_enable_clocks()
>  sound/arm/omap/eac.c:		eac_enable_clocks()
>=20
> With vclk, all the above home-brewed functions, *_enable_clocks(), ca=
n
> be replaced by a normal clk_enable(), with grouping the logical set o=
f
> clocks in advance.

Adding something like the enable_clocks() we've already gotten comments
on, and it's considered abuse of the clock framework. So the drivers
should just use clk_enable/disable() and that's it.

Since some drivers may need to set fck and ick separately from PM
point of view, I think it's OK for the driver to handle multiple
clocks in the driver.

But maybe we can find a way to treat multiple clocks as one clock still
with clk_associate?

> For some of the above drivers, omap's "functional clock" and
> "interface clock" doesn't make sense. For such device drivers, those
> clocks may look just a single necessary clock and there's no "one to
> one" correspondence from the omap clock functionality definitions
> ("ick"/"fck") perspective. I think that this is one of the examples,
> where the flexibily is required. Since required functionaliies for
> clocks depends on each device drivers, I think that it would give a
> wider solution to let device drivers to define their logical
> clocks(functionality) flexibly(not 1-to-1), rather than statically
> pre-defined standardized functional names, which is the 1-to-1
> correspondence of ick and fck in the TRM with aliasing.

Maybe a combination of clk_associate() and adding a vclk in some cases
is the way to go?

Adding a vclk has the issue Paul pointed out on how to figure out the
parent. So the vclk would always have to implement custom set_rate()
and parent.

The main advantage I see with clk_associate() is that it solves the
trying to match struct device to struct clk with the name and instance.
Getting the instance right is not obvious as some clocks start numberin=
g
at 0 and some at 1... If the driver does any logic on the instance,
things break easily in mysterious ways. Like the MMC did for hsmmc with
my recent MMC init patches.

> But I agree on that 'vclk' is too flexible and I think that's why Pau=
l
> hasn't taken it yet;)

Or it should be used carefully and only when really needed.

Tony


> *1: http://marc.info/?l=3Dlinux-omap&m=3D122066992729951&w=3D2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
