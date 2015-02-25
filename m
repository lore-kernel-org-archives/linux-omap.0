From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 03/35] ARM: OMAP2+: PRM: add generic API for
 clear_mod_irqs
Date: Wed, 25 Feb 2015 13:08:04 -0600
Message-ID: <20150225190804.GM11136@saruman.tx.rr.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
 <1424891085-10392-4-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbbBYTIv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:08:51 -0500
Content-Disposition: inline
In-Reply-To: <1424891085-10392-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--yaap9KN+GmBP785v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 25, 2015 at 09:04:13PM +0200, Tero Kristo wrote:
> +int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
> +{
> +	if (!prm_ll_data->clear_mod_irqs) {
> +		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
> +			  __func__);

you can combine these:

	if (WARN_ONCE(!prm_ll_data->clear_mod_irqs,
		"prm: %s: no mapping function defined\n",
		__func__))

--=20
balbi

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7h2UAAoJEIaOsuA1yqRETlUP/itI+03uW2GerNlt4eEmSYL0
qmoMle+5xrWV8yfjVFYSoAH7By6AtxJjI6IqjvEWnJxQKL4umxDVXrvrXN41FQLS
iDf+lURaM7TNWwYT+brHxXOv8N1AG9ZBLBp2WO7hM5CsC1lYWSStnn/A+3fYTUeU
l1oR6oHOZTIMjAXzkVDpfKMQdiZ77tEdrKAQXzPoo9mmR6Uvl71r/L819FFngVjG
KI1KS3VUS9wz+fHosQMoFf+BxsmetT6HHWPbey9NHwq0Z1LupP3o4ad8ZHbwJ/eX
XpNXOgnkunncFctb9oCoIv/YQRSOSwYBhPzdvW+8sleBGlYSBmvQeJhScz3dq1ZX
75rPC1sHPSn8Sa6rgUX2R5RK2d0S/5E9ltDNBKhwfYxMdsT9njsya9mV8tNpbTFj
TDtAfjjEnLctiFHxR0LmDUVWnGRizIDH5guXuW/rQQtTe3yR31z2hgcgInNSs0k5
2o1ZeJPKB02nRa/CjvuRS1y18vlo2BYN9R+DP/YalhyqwkzgQ+mZsKrolkq+83wV
dQayee/amJwV+Gycd2UkfZRXlpWdA/slspkI4ZHtbrEAU5C377VvMNkGQ5ZqK1KI
n44lHaLn5cJkArCrfK191c2aiaENhGOrrv6TUsyr6rKFEyM4W8xP8ktUCBmdL7Bf
6UmYzvDyYEKFNDL1ZvLz
=aqih
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--
