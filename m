From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Wed, 10 Dec 2008 09:59:50 +0200
Message-ID: <1228895990.31061.13.camel@tubuntu>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
	 <1228726770.8668.66.camel@tubuntu>
	 <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
	 <1228831086.31061.9.camel@tubuntu>
	 <87prk0cwfy.fsf@trdhcp146196.ntc.nokia.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57326 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbYLJIAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 03:00:17 -0500
In-Reply-To: <87prk0cwfy.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Wed, 2008-12-10 at 09:37 +0200, H=F6gander Jouni wrote:
> "ext Tomi Valkeinen" <tomi.valkeinen@nokia.com> writes:
>=20
> > Hi,
> >
> > On Mon, 2008-12-08 at 02:24 -0700, ext Paul Walmsley wrote:
> >> Hi Tomi,
> >>=20
> >> On Mon, 8 Dec 2008, Tomi Valkeinen wrote:
> >>=20
> >> > On Sat, 2008-12-06 at 16:51 -0700, ext Paul Walmsley wrote:
> >> > > Hi Tomi,
> >> > >=20
> >> > > nice test case.
> >> > >=20
> >> > > On Fri, 5 Dec 2008, Tomi.Valkeinen@nokia.com wrote:
> >> > >=20
> >> > > > I have had strange clk_enable() crashes with DSS2, and now I=
 managed to
> >> > > > isolate it. With the included patch, on OMAP3 SDP board, wit=
h default
> >> > > > kernel config, I always get the crash below. In this example=
 case it
> >> > > > happens at specific time on boot, but with DSS2 it happens r=
andomly at
> >> > > > runtime, when I enable the DSS clocks.
> >> > >=20
> >>=20
> >> At this point my guess would be that it is a DSS driver problem, b=
ut I=20
> >> don't think it is clear yet.
> >>=20
> >
> > I don't know much about power and clock domains, but I believe I fo=
und
> > the reason and fix for this. At least this should point to the righ=
t
> > direction.
> >
> > It looks to me that when I do clk_enable() to a clock which is insi=
de a
> > turned off powerdomain, clk_enable() function will return before th=
e
> > powerdomain is fully turned on. Reading PM_PWSTST_DSS shows that th=
e
> > powerdomain is still in transition state.
> >
> > The following change waits until the powerdomain has finished the
> > transition. At least it fixed the problem for me, and other things =
seem
> > to be still working =3D).
> >
> >
> > diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap=
2/clockdomain.c
> > index fa62f14..f713d0b 100644
> > --- a/arch/arm/mach-omap2/clockdomain.c
> > +++ b/arch/arm/mach-omap2/clockdomain.c
> > @@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *=
clkdm, struct clk *clk)
> >         else
> >                 omap2_clkdm_wakeup(clkdm);
> > =20
> > +       pwrdm_wait_transition(clkdm->pwrdm.ptr);
> > +
>=20
> Altough this patch is fixing the problem, I'll guess it's because of
> delay it causes rather than waiting for
> PM_PWSTST_DSS. omap2_clkdm_clk_enable alone doesn't switch pwrdm to
> on. This is because clockdomain/powerdomains are controlled by HW (hw
> supervised).
>=20
> I think the right answer is to use ST_*_IDLE & ST_*_STDBY bits in
> omap2_clk_wait_ready.

But ST_DSS_IDLE says active only after both interface and functional
clock are on, so it doesn't help here.

Why is it wrong to wait for PM_PWSTST_DSS? Do you mean that this crash
is not caused by the DSS being not powered on, but by something else,
and so the small delay just accidentally fixes the problem?

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
