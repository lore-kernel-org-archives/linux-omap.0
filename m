From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] can: c_can: use regmap_update_bits() to modify RAMINIT
 register
Date: Fri, 9 Jan 2015 15:50:40 +0200
Message-ID: <54AFDCB0.5060908@ti.com>
References: <1420641162-8634-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="nqjjQkNAXs4GWvmH1HQ1h2jFuxa4tPI3g"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38497 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbbAINu4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2015 08:50:56 -0500
In-Reply-To: <1420641162-8634-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org, wsa@the-dreams.de, kernel@pengutronix.de, linux-omap@vger.kernel.org

--nqjjQkNAXs4GWvmH1HQ1h2jFuxa4tPI3g
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/01/15 16:32, Roger Quadros wrote:
> use of regmap_read() and regmap_write() in c_can_hw_raminit_syscon()
> is not safe as the RAMINIT register can be shared between different dri=
vers
> at least for TI SoCs.
>=20
> To make the modification atomic we switch to using regmap_update_bits()=
=2E
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/net/can/c_can/c_can_platform.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index f363972..364209a 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -110,6 +110,10 @@ static void c_can_hw_raminit_syscon(const struct c=
_can_priv *priv, bool enable)
>  	 */
>  	ctrl &=3D ~(1 << raminit->bits.start);
>  	ctrl |=3D 1 << raminit->bits.done;
> +
> +	/* we can't use regmap_update_bits here as it will bypass the write
> +	 * if START is already 0 and DONE is already 1.
> +	 */
>  	regmap_write(raminit->syscon, raminit->reg, ctrl);

Can you first use update_bits to change either bit, so that this update
will be done?

 Tomi



--nqjjQkNAXs4GWvmH1HQ1h2jFuxa4tPI3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUr9ywAAoJEPo9qoy8lh712+EP/jKguosT/RNHYoUsfRuEY9+9
wGW8w6WRRoB73pWC/C5nzac0zoGKhIJl7QnOHNnGcnpZoybpIOnK4pO/TMyR8j2C
whXzPyW4fzH8jWMN2BgtEIfiyR8ZStQaKydc9dPfPBlD8OkrbAEAEe7TGiOULkKv
T+B7Cl1CgneG6Aq433wjF1Qi4e2NUR/QEDLqX9/txsHSB+4L+uNHHgu8wAngsBCD
OBAjMSaljA8lfTQV/V6XwyMrjyAZYQA+TM3fD8DMDCt2eSK0IjFubUQGzDWk3YAF
tQKKv+R36QdHMV4lKNCr7Kmb0ZW/Q1fmVthZXSHpVsNcZlS+ag8Uo5wv/2rL+kQr
LO6XbfpgTpGNN9sAcq9wSfkvFIdDC91zKNMBlPeQHFUeoexY2BW4RNOwPC86ulRY
VwaBC7D1SLeGKrNPThwRtNI5rN3y9izxsYXZXx6TyVlWUh5LXVC6XHLZO99ixQaD
5pbnjsoi23D2S29HYn506OMnvF8Gor4MzAdjf1Ki/cF/VWqu8XzB4JhyMygbF7HV
ubedACPya+9DgOV5wyzPdwhkSA7QOfPLPshM590RwnCP3rel5dYpb7MYs2Rtoa4x
tobe0O30A6RLnlnPwK6+RIXBOTQokLfkHVU3/XAjIxv+hPmPpN6MabwOJTc0Dwsc
ikHCRFxme+Z6T7HBIN1F
=Ok4V
-----END PGP SIGNATURE-----

--nqjjQkNAXs4GWvmH1HQ1h2jFuxa4tPI3g--
