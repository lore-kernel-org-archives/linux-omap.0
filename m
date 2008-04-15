From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from plat-omap to mach-omap
Date: Tue, 15 Apr 2008 09:52:31 -0700
Message-ID: <200804150952.31303.david-b@pacbell.net>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br> <1208203891-11225-2-git-send-email-edubezval@gmail.com> <00c101c89f07$f363a380$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:46352 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755709AbYDOQwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Apr 2008 12:52:37 -0400
In-Reply-To: <00c101c89f07$f363a380$318918ac@ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandra shekhar <x0044955@ti.com>
Cc: 'Eduardo Valentin' <edubezval@gmail.com>, linux-omap@vger.kernel.org, 'Eduardo Valentin' <eduardo.valentin@indt.org.br>

I've not been following these McBSP issues, but this
comment suggests to me that the clock API is just not
being used "correctly" here:

On Tuesday 15 April 2008, Chandra shekhar wrote:
> 1>=20
> Clock structure can be moved to header file and create a structure.
> So that instead of calling each clock by its name,( big problem for 2=
430 and 34xx
> Which has 5 mcbsp instances) =A0it can be called by Using mcbsp id.=20
>=20
> Something like this can be done...=20
>=20
> static char omap_mcbsp_ick[][12] =3D {"mcbsp1_ick\0",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0"mcbsp2_ick\0",.........
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0};
>=20
> static char omap_mcbsp_fck[][12] =3D {"mcbsp1_fck\0",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0"mcbsp2_fck\0",.........
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0};
>=20
> static struct omap_mcbsp_clocks {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0struct clk *ick;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0struct clk *fck;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0} omap_mcbsp_clk[OMAP_MAX_MCBSP_COUNT];=20
>=20
> clk_enable(omap_mcbsp_clk[id].ick);
>=20
> Clk_get or clk_enable/disable will be much simplified.

The "correct" way to use the clock ACPI would be like:

	struct device *mcbsp =3D ... something ... ;
	struct clk *ick, *mck;

	ick =3D clk_get(mcbsp, "ick");
	fck =3D clk_get(mcbsp, "fck");

That is, don't expect clients to use names like "mcbsp2_fck" and
know which McBSP they're using ... just expect them to know
they have *some* module, and that its clock has generic names
such as "ick" and "fck".

Of course, working that way may involve a bunch of other changes...

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
