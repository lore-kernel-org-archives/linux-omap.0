From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: Bug in linux omap clock framework?
Date: Thu, 11 Dec 2008 11:19:34 +0200
Message-ID: <87wse7rrvd.fsf@trdhcp146196.ntc.nokia.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	<alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
	<1228726770.8668.66.camel@tubuntu>
	<alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
	<1228831086.31061.9.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61491 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYLKJVg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 04:21:36 -0500
In-Reply-To: <1228831086.31061.9.camel@tubuntu> (ext Tomi Valkeinen's message
	of "Tue, 09 Dec 2008 15:58:06 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: ext Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

"ext Tomi Valkeinen" <tomi.valkeinen@nokia.com> writes:

> Hi,
>
> On Mon, 2008-12-08 at 02:24 -0700, ext Paul Walmsley wrote:
>> Hi Tomi,
>>=20
>> On Mon, 8 Dec 2008, Tomi Valkeinen wrote:
>>=20
>> > On Sat, 2008-12-06 at 16:51 -0700, ext Paul Walmsley wrote:
>> > > Hi Tomi,
>> > >=20
>> > > nice test case.
>> > >=20
>> > > On Fri, 5 Dec 2008, Tomi.Valkeinen@nokia.com wrote:
>> > >=20
>> > > > I have had strange clk_enable() crashes with DSS2, and now I m=
anaged to
>> > > > isolate it. With the included patch, on OMAP3 SDP board, with =
default
>> > > > kernel config, I always get the crash below. In this example c=
ase it
>> > > > happens at specific time on boot, but with DSS2 it happens ran=
domly at
>> > > > runtime, when I enable the DSS clocks.
>> > >=20
>>=20
>> At this point my guess would be that it is a DSS driver problem, but=
 I=20
>> don't think it is clear yet.
>>=20
>
> I don't know much about power and clock domains, but I believe I foun=
d
> the reason and fix for this. At least this should point to the right
> direction.
>
> It looks to me that when I do clk_enable() to a clock which is inside=
 a
> turned off powerdomain, clk_enable() function will return before the
> powerdomain is fully turned on. Reading PM_PWSTST_DSS shows that the
> powerdomain is still in transition state.

I debugged this a bit and I think patch written by Tomi is partly
fixing this issue. It seems to be related to accessing cm_*
registers while there is transition ongoing in pwrdm_*. I
changed test_init to emulate what ckfw is currently doing:

static int __init test_init(void)
{
	struct clk *c1 =3D clk_get(NULL, "dss_ick");

	while(1) {
/* 		clk_enable(c1); */
/* 		clk_disable(c1); */

                /* Add sleep and wkdeps */
                omap_writel(0x2, 0x48004e44);
                omap_writel(0x2, 0x48306ec8);

                /* Enable dss_ick */
		omap_writel(0x1, 0x48004e10);

                /* disable dss_ick */
		omap_writel(0x0, 0x48004e10);

                /* Remove sleep and wkdeps */
		omap_writel(0x0, 0x48004e44);
		omap_writel(0x0, 0x48306ec8);
	}
	return 0;
}

This code crashes, but if I remove sleep/wkdep addition/removel from
the code it doesn't. It doesn't crash either if I add
"while((omap_readl(0x48306ee4)&0x100000));" after sleep/wkdep
addition/removel.

So it seems that cm_* register should not be written while there is
powerstate transition ongoing in * domain. Patch by Tomi is fixing
this. As it seems to be transition related rather than pwrdm state,
same line should be added into omap2_clkdm_clk_disable also.

>
> The following change waits until the powerdomain has finished the
> transition. At least it fixed the problem for me, and other things se=
em
> to be still working =3D).
>
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/=
clockdomain.c
> index fa62f14..f713d0b 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *cl=
kdm, struct clk *clk)
>         else
>                 omap2_clkdm_wakeup(clkdm);
> =20
> +       pwrdm_wait_transition(clkdm->pwrdm.ptr);
> +
>         return 0;
>  }
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
