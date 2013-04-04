From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/1] smiapp-pll: Take existing divisor into account in minimum divisor check
Date: Thu, 04 Apr 2013 16:33:23 +0200
Message-ID: <3177012.uWqskAv3dr@avalon>
References: <201303281524.10538@pali> <201303311203.39975@pali> <20130331200741.GA10541@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:41646 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761692Ab3DDOcX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 10:32:23 -0400
In-Reply-To: <20130331200741.GA10541@valkosipuli.retiisi.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>, Mike Turquette <mturquette@linaro.org>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Hi Sakari,

(CC'ing linux-omap and Rajendra Nayak)

On Sunday 31 March 2013 23:07:42 Sakari Ailus wrote:
> Hi Pali and Laurent,
>=20
> Laurent: Pali has been working to get N900 working again with (almost=
)
> mainline kernel.
>=20
> On Sun, Mar 31, 2013 at 12:03:39PM +0200, Pali Roh=E1r wrote:
> > On Sunday 31 March 2013 10:44:08 Sakari Ailus wrote:
> > > Required added multiplier (and divisor) calculation did not
> > > take into account the existing divisor when checking the
> > > values against the minimum divisor. Do just that.
> > >=20
> > > Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > ---
> > > Hi Pali,
> > >=20
> > > This looks like a bug in the PLL calculator. Could you try if thi=
s patch
> > > fixes it? It's written on an N950 and also is fully untested. :)
> > >=20
> > > If it works for you I'll submit it to mainline as well.
> > >=20
> > > Happy Easter! :)
> > >=20
> > >  drivers/media/i2c/smiapp-pll.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> >=20
> > Hi,
> >=20
> > now I tried smiapp again with 3.9 kernel on n900 and it failing wit=
h this
> > error messae (smiapp driver is not loaded):
> >=20
> > [   22.164001] omap3isp omap3isp: Revision 2.0 found
> > [   22.166900] omap3isp omap3isp: clk_set_rate for cam_mclk
> > failed
> >=20
> > I bisected git commit 6d1aa02f10497b138e01ebe6eafabd6071729334
> > "omap3isp: Set cam_mclk rate directly" and after reverting it 3.9
> > kernel started loading smiapp driver. When I applied your patch
>=20
> This shouldn't happen.
>=20
> Laurent: did you test the patch on 3430 back then? I only tested 3630=
=2E AFAIR
> you did, but I don't remember for sure.

I can't remember for sure, but it seems I haven't, or at least not prop=
erly=20
:-(

> I don't have time to debug this in the coming days unfortunately. If =
this
> turns out to be a non-trivial issue then it's probably good to contin=
ue on
> linux-omap.

It might not be too complex to fix, but linux-omap is a good idea nonet=
heless.

Could you try debugging the problem ? The starting point is clk_set_rat=
e() in=20
drivers/clk/clk.c. My guess is that clk_calc_new_rates() returns NULL, =
and=20
that it does so because it walks to clock tree up to dpll4_m5x2_ck whic=
h has=20
neither a round_rate operation nor the CLK_SET_RATE_PARENT flag set. Co=
uld you=20
please confirm that ?

I wonder if the dpll4_m5x2_ck clock (in arch/arm/mach-omap2/cclock3xxx_=
data.c)=20
should just have the CLK_SET_RATE_PARENT flag set as the dpll4_m5x2_ck_=
3630=20
clock.

--=20
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
