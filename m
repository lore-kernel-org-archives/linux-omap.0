From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
Date: Tue, 26 Jul 2011 16:17:19 +0300
Message-ID: <20110726131718.GP32582@legolas.emea.dhcp.ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
 <1299338962-5602-4-git-send-email-nm@ti.com>
 <4D738E04.5090207@ru.mvista.com>
 <4D744870.20909@ti.com>
 <4D750673.702@ru.mvista.com>
 <20110308015232.GA4702@maz>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ssZxAlvqSOvXAj81"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52447 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab1GZNRY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jul 2011 09:17:24 -0400
Received: by mail-ey0-f177.google.com with SMTP id 6so679077eyh.22
        for <linux-omap@vger.kernel.org>; Tue, 26 Jul 2011 06:17:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110308015232.GA4702@maz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, linux-arm <linux-arm-kernel@lists.infradead.org>


--ssZxAlvqSOvXAj81
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2011 at 07:22:32AM +0530, Nishanth Menon wrote:
> On Mon, Mar 07, 2011 at 07:23:15PM +0300, Sergei Shtylyov wrote:
> > Hello.
> >=20
> > On 07-03-2011 5:52, Nishanth Menon wrote:
> >=20
> > >>>Blindly setting a 1.2V setting
> >=20
> > >>Hm, seems tautological...
> >=20
> > >As a non native English speaker, I would like to understand how we cou=
ld
> > >improve this. I suppose you mean "Blindly setting 1.2V" is better here=
=2E Am i
> > >correct?
> >=20
> >    Yes.
> OK, here is the update as per the suggestion:
> Regards,
> Nishanth Menon
> From: Nishanth Menon <nm@ti.com>
> Date: Tue, 15 Feb 2011 09:37:18 +0530
> Subject: [PATCH V4 3/19] OMAP3+: voltage: remove initial voltage
>=20
> Blindly setting 1.2V in the initial structure may not even match the
> default voltages stored in the voltage table which are supported for
> the domain. For example, OMAP3430 core domain does not use 1.2V and
> ends up generating a warning on the first transition.
>=20
> Further, since omap2_set_init_voltage is called as part of the pm
> framework's initialization sequence to configure the voltage required
> for the current OPP, the call does(and has to) setup the system
> voltage(curr_volt as a result) using the right mechanisms appropriate
> for the system at that point of time. This also overrides
> initialization we are currently doing in voltage.c making it
> redundant. So, remove the wrong and redundant initialization.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/voltage.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 56961df..1b40aa0 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -116,7 +116,6 @@ static int __init _config_common_vdd_data(struct omap=
_vdd_info *vdd)
>  	sys_clk_speed /=3D 1000;
> =20
>  	/* Generic voltage parameters */
> -	vdd->curr_volt =3D 1200000;
>  	vdd->volt_scale =3D vp_forceupdate_scale_voltage;
>  	vdd->vp_enabled =3D false;
> =20
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--ssZxAlvqSOvXAj81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLr5eAAoJEAv8Txj19kN1CEAH/iVCD7LTtPxzGGgoV2WXQnrs
GPic8L6zfoSEZv5uLqWilnDaGyKBNG5KaZqh1btgmas2FBwcUNZ869xTczDnBAax
30MCj33JIgj8ffxqQeI+gIL1Zwor4Kpl/U5ImX+pynHcMo/Cvlloj+vLYLjVR+0A
b2XJFNI4VmqYE8ZofYT1yPPwFalvle30flZvp6ZEj5WDGfvXpI8FAfpWWg9DII7t
J9R1zitPHLLLnGg7skIFSxcHW7zAcgPEdLtmj1xy9Ds0mMHy4bmgKIgBJmdGvbWc
+eblX9pVskyJj9I5yqoq2Nx9zyFMK3Cq8K5D/iVTsEOj+bBxzaha825a0ZbgBxE=
=0w5I
-----END PGP SIGNATURE-----

--ssZxAlvqSOvXAj81--
