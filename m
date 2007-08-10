From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: [PATCH 02/22 - Reverse] omap2 osc & sys clock calculation.
Date: Fri, 10 Aug 2007 16:08:20 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429019C4FDA@dlee13.ent.ti.com>
References: <20070802181002.792550043@pwsan.com>
	<20070802181141.557025493@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070802181141.557025493@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

Can you reverse this patch?  Or should a fixed one be submitted?

With this the system gets the wrong osc speed and ends up setting the =
system speed wrongly.  This results in OMAP running to slow, can't have =
that.

As explained in another mail the APLLS tuning speed is used to set the =
rate of these clocks with out having to do gauging again.  The boot =
loader should use the 32KHz clock and a gptimer to figure out the input =
speed and set the APLL properly.  You then use the APLL multipled with =
the divider to get the osc clocks speed.  The divider is only 1 or 2.

1 step back with 22 ones forward is still pretty good ;)

Regards,
Richard W.

> Subject: [PATCH 02/22] omap2 clock: fix incorrect rate calculation
> forosc_ck, sys_ck
>=20
> omap2_get_crystal_rate() calculates osc_ck and sys_ck rates
> incorrectly.  osc_ck runs at the same rate as the external clock
> source.  Also, sys_ck's rate derives from osc_ck's rate, divided (not
> multiplied) by PRCM_CLKSRC_CTRL:SYSCLKDIV.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>=20
> ---
>  arch/arm/mach-omap2/clock.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Index: linux-omap/arch/arm/mach-omap2/clock.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap.orig/arch/arm/mach-omap2/clock.c
> +++ linux-omap/arch/arm/mach-omap2/clock.c
> @@ -1126,8 +1126,8 @@ static void __init omap2_get_crystal_rat
>  	div &=3D OMAP_SYSCLKDIV_MASK;
>  	div >>=3D sys->rate_offset;
>=20
> -	osc->rate =3D sclk * div;
> -	sys->rate =3D sclk;
> +	osc->rate =3D sclk;
> +	sys->rate =3D osc->rate / div;
>  }
>=20
>  /*
>=20
> --
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
