From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Fri, 03 Oct 2008 09:23:36 +0300 (EEST)
Message-ID: <20081003.092336.243854668.Hiroshi.DOYU@nokia.com>
References: <200810010915.46032.david-b@pacbell.net>
	<20081001.213437.22091635.Hiroshi.DOYU@nokia.com>
	<200810021350.03739.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62777 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbYJCGY2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 02:24:28 -0400
In-Reply-To: <200810021350.03739.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david-b@pacbell.net
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com

Hi David,

=46rom: "ext David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Thu, 2 Oct 2008 13:50:02 -0700

> On Wednesday 01 October 2008, Hiroshi DOYU wrote:
> > Or, this feature itself can be covered by 'virtual clock(vclk)'?
> >=20
> > =A0 =A0 http://marc.info/?l=3Dlinux-omap&m=3D122066992729949&w=3D2
> >=20
> > which means that,
> > in this case, if 'vclk' just has a single child, not multiple, it c=
an
> > be used just as 'aliasing' of clock names, without touching the
> > contents of 'struct clk', since 'vclk' is a inhritance of 'struct c=
lk'.
>=20
<snip>
>
> > Some driver may need to control multiple clocks at=20
> > once. Some may need a clock which has different names between omap1=
,
> > omap2/3 or target boards. Or some may need to control multiple cloc=
k
> > groups from the functional perspective. So I think that a *flexible=
*
> > infrastructure would be better to afford such requiments, keeping
> > 'struct clk' as simple as possible.
>=20
> That vclk stuff looked a bit less obvious than I like.
> Maybe I just haven't seen the need for those particular
> flavors of flexibility.

I've looked around for some examples;). For this abstruction (or
logical clock view), one of the case which clk_associate doesn't deal
with is to handle multiple clocks together. There are some cases,
where multiple clocks are handled(enable/disable) at once as below:

 drivers/usb/gadget/omap_udc.c:	omap_udc_enable_clock()
 drivers/video/omap/rfbi.c:	rfbi_enable_clocks()
 arch/arm/mach-omap2/mcbsp.c:	omap_mcbsp_clk_enable()*1
 arch/arm/mach-omap2/serial.c:	omap_serial_enable_clocks()
 sound/arm/omap/eac.c:		eac_enable_clocks()

With vclk, all the above home-brewed functions, *_enable_clocks(), can
be replaced by a normal clk_enable(), with grouping the logical set of
clocks in advance.

=46or some of the above drivers, omap's "functional clock" and
"interface clock" doesn't make sense. For such device drivers, those
clocks may look just a single necessary clock and there's no "one to
one" correspondence from the omap clock functionality definitions
("ick"/"fck") perspective. I think that this is one of the examples,
where the flexibily is required. Since required functionaliies for
clocks depends on each device drivers, I think that it would give a
wider solution to let device drivers to define their logical
clocks(functionality) flexibly(not 1-to-1), rather than statically
pre-defined standardized functional names, which is the 1-to-1
correspondence of ick and fck in the TRM with aliasing.

But I agree on that 'vclk' is too flexible and I think that's why Paul
hasn't taken it yet;)

*1: http://marc.info/?l=3Dlinux-omap&m=3D122066992729951&w=3D2

     Hiroshi DOYU

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
