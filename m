From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 04/19] OMAP3+: voltage: remove spurious pr_notice for
 debugfs
Date: Tue, 26 Jul 2011 16:18:03 +0300
Message-ID: <20110726131802.GQ32582@legolas.emea.dhcp.ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
 <1299338962-5602-5-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nWEzmRaGLXxZdI3i"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51418 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242Ab1GZNSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jul 2011 09:18:07 -0400
Received: by mail-ey0-f176.google.com with SMTP id 28so729192eya.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jul 2011 06:18:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1299338962-5602-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>


--nWEzmRaGLXxZdI3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 05, 2011 at 08:59:07PM +0530, Nishanth Menon wrote:
> cat of debugfs entry for vp_volt provides voltage. The additional pr_noti=
ce
> is just spam on console and provides no additional information.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/voltage.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 1b40aa0..53c399f 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -150,7 +150,6 @@ static int vp_volt_debug_get(void *data, u64 *val)
>  	}
> =20
>  	vsel =3D vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
> -	pr_notice("curr_vsel =3D %x\n", vsel);
> =20
>  	if (!vdd->pmic_info->vsel_to_uv) {
>  		pr_warning("PMIC function to convert vsel to voltage"
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--nWEzmRaGLXxZdI3i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLr6KAAoJEAv8Txj19kN1nQ8H/0awwTLVOk9LMQ0YzhY7idl+
WEGh2DJgROHAnhf4OUT0iR3pxbeDTnR5MmtuDeaQoCG1no/j0jnGroRnDkwv4g8z
c3xHXfdcPDsvmpuXf0JFVun5fkWn/8TJYPtbMM9cLytTLQj+eZIeDvAD43PKRyww
ecSHZbB3LtSd/bfQHggij6hNTm2WWhlZVq1kLJtaxbKZtWPbR/zYVFowpH4cC+pa
IgHETLptVH8DDa1iyAucuOARyJwPw+/6I7F+fwzro/GuZtwC8ORMSPvzC+Rrtn4E
dJKAjpaBuYbPXBu6ETPN5ezhJM74GkclHdSxzjActubaTIJW7Z/t/QTqBsSA/bY=
=l7w4
-----END PGP SIGNATURE-----

--nWEzmRaGLXxZdI3i--
