From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: Move DISPC L3 firewall to happen in
 omap_display_init()
Date: Wed, 22 Feb 2012 10:09:51 +0200
Message-ID: <1329898191.2070.6.camel@deskari>
References: <20120221233619.18709.87982.stgit@kaulin.local>
	 <20120221234035.18709.40664.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-rJRzNWAO1aqhLCz7RkQE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55240 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750783Ab2BVIJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 03:09:57 -0500
In-Reply-To: <20120221234035.18709.40664.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-rJRzNWAO1aqhLCz7RkQE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-02-21 at 15:40 -0800, Tony Lindgren wrote:
> Otherwise we cannot move most of plat/io.h to be a local
> iomap.h for mach-omap2.
>=20
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/display.c   |    3 +++
>  drivers/video/omap2/dss/dispc.c |    5 -----
>  2 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.=
c
> index 3677b1f..5a7f12f 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -191,6 +191,9 @@ int __init omap_display_init(struct omap_dss_board_in=
fo *board_data)
>  	memset(&pdata, 0, sizeof(pdata));
> =20
>  	if (cpu_is_omap24xx()) {
> +		/* L3 firewall setting: enable access to OCM RAM */
> +		__raw_writel(0x402000b0, OMAP2_L3_IO_ADDRESS(0x680050a0));
> +
>  		curr_dss_hwmod =3D omap2_dss_hwmod_data;
>  		oh_count =3D ARRAY_SIZE(omap2_dss_hwmod_data);
>  	} else if (cpu_is_omap34xx()) {
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index e1626a1..cce0820 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -3272,11 +3272,6 @@ static void _omap_dispc_initial_config(void)
>  	if (dss_has_feature(FEAT_FUNCGATED))
>  		REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
> =20
> -	/* L3 firewall setting: enable access to OCM RAM */
> -	/* XXX this should be somewhere in plat-omap */
> -	if (cpu_is_omap24xx())
> -		__raw_writel(0x402000b0, OMAP2_L3_IO_ADDRESS(0x680050a0));
> -
>  	_dispc_setup_color_conv_coef();
> =20
>  	dispc_set_loadmode(OMAP_DSS_LOAD_FRAME_ONLY);
>=20

I think the whole raw_writel line can be removed. It's been copied from
the old omapfb, and my understanding is that it's about using SRAM for
framebuffer. Using SRAM for fb is no longer supported, and I have a
patch set that removes the remaining SRAM code from omapfb/omapdss.

 Tomi


--=-rJRzNWAO1aqhLCz7RkQE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPRKLLAAoJEPo9qoy8lh71a5MQAIPg6GS7nN/voES3ZR65JH+b
uev7//Nxg7HmZ3//cUs826aDSKbf7r34IoU2ycB+rqyOwzJBbdagRwt5R2tp5h2K
bMKbN9RKGiAKOIRpdHBrc01uNouDn5UFT758qR8WV4ugWiwihhtofsefbQGvAseQ
K+xIwIG4bfK2vqltAJLVMOFdBG+S52hDDpHLRDxcXyMShlOubM4nybItz2M5hCja
pLDmkaJpJLI1rEF+yAjb1UQRyOQZtQ9uRQG8tyiJvw+ugefaroaF3/C+3cdRduMn
X+jiSuexukvTcpOnPUYyKiRfYL3iYYV51weMLkQNPWnImCQKo/adKC1R/cUy0yr+
TXfKNviviakK4wM3r/1zuJ8oIo4GgXk2PcMicBp05ih6dxL8s71LegjAP0Lt/SvD
yEHeDjZWVE5AzMZgW5k7A3gXVP4C+LijUNmZj1Mr7+n8yy3sBCN1BuCLza0qRaix
vZ9q8tzQZlNu0QtWfWCAaPomiZK8gC3OpPlzHplUXJd/mR5SB0r2eInAYBc5Xwvv
FUWRMSvnvAnG6oiUJdySGwBygZPStaADnxoLkKx0XawfqRWtqxLeSn0Y8/Y5gWBb
ir0p4+c7IxF/1wtnHFyPu63kEbqM8t0yv3PGZHmt/fhx66p4Y3KGZ1663QFAdH8v
WO/ConOpxUsQCxreKAhV
=8dVX
-----END PGP SIGNATURE-----

--=-rJRzNWAO1aqhLCz7RkQE--

