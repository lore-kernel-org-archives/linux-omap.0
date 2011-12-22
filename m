From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] OMAP4: mcbsp: Clock reparenting support
Date: Thu, 22 Dec 2011 18:23:53 +0200
Message-ID: <4EF35999.5040607@ti.com>
References: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com> <1323941859-7946-3-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1112161730080.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:60130 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753854Ab1LVQXw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 11:23:52 -0500
Received: by lagv3 with SMTP id v3so1508723lag.28
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 08:23:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112161730080.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 12/17/2011 02:37 AM, Paul Walmsley wrote:
> What do you think about using clkdev alias lines and hwmod optional c=
lks=20
> for this instead?  With these mechanisms, you can give clocks a consi=
stent=20
> "role name" for a given device, even if the underlying clock changes =
on=20
> different platforms.

I need to look into the clock framework, but sounds promising.
I can see quite big difference between the clock3xxx_data, and
clock44xx_data regarding to McBSPs.
Need to understand why, and what need to be changed to achieve what I w=
ant.

> So in the mach-omap2/clock*_data.c files, you'd do something like
>=20
> 	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,  CK_3XXX),
>=20
> for OMAP3, and=20
>=20
> 	CLK("omap-mcbsp.1",	"pad_fck",	&pad_clks_clk,  CK_44XX),
>=20
> for OMAP4.
>=20
> Then in the hwmod data files, you'd add them as optional clocks -=20
> something like:
>=20
> static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] =3D {
> 	{ .role =3D "pad_fck", .clk =3D "mcbsp_clks" },
> };
>=20
> for OMAP3, and
>=20
> static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] =3D {
> 	{ .role =3D "pad_fck", .clk =3D "pad_clks_clk" },
> };
>=20
> for OMAP4.
>=20
> I think this might work for your needs?

Is it OK if I do this as an incremental patch as soon as I figured out
the way to do it nicely?

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
