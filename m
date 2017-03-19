From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] mfd: cpcap: Fix bad use of IRQ sense register
Date: Sun, 19 Mar 2017 03:01:18 +0100
Message-ID: <20170319020118.4oh6sny5phqpatit@earth>
References: <20170317003633.7361-1-tony@atomide.com>
 <20170317003633.7361-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qpruqyzgkmcuilyo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317003633.7361-5-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--qpruqyzgkmcuilyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 05:36:33PM -0700, Tony Lindgren wrote:
> The cpcap INTS registers are for getting the value of the line,
> not for configuring the type.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

> Signed-off-by: Tony Lindgrne <tony@atomide.com>

https://lwn.net/Articles/717281/ ;)

-- Sebastian

> ---
>  drivers/mfd/motorola-cpcap.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -115,7 +115,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR=
_IRQ_CHIPS] =3D {
>  		.status_base =3D CPCAP_REG_INT1,
>  		.ack_base =3D CPCAP_REG_INT1,
>  		.mask_base =3D CPCAP_REG_INTM1,
> -		.type_base =3D CPCAP_REG_INTS1,
>  		.use_ack =3D true,
>  		.handle_reread =3D true,
>  		.ack_invert =3D true,
> --=20
> 2.11.1

--qpruqyzgkmcuilyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljN5mwACgkQ2O7X88g7
+poaXQ/+KqpPHU7H8LmgzLNjZOK63zF5IhtyoqpGFHBKdZtuta4LcZyJhQMASK7m
KpzGtdKHbM5KnGT2DByondBL1pD5B8oJb3jLyvWe9UMJZEwad3FSPKSZAXSVFsez
PLNbt7rHTiMgiE0UtkzZ3shQDRSxeZJdwLC78J46P6cC7w98CkSpOBs3RYDyob6L
M3myk3YRfYfEmwAcLW7BHsDYGfQYTOj/K8nLTqXZZ7ku56fjEJdjVmEK9vlMt/pH
TKn+XEnTQ6iSf7zBozOwU/tlSdmWuM9TvToBtqQlIql98SBOrv3kJf7ul08/QBlG
g1ruFruK7C1UMxeEWA+Zya/VjMPAm2rqKQgdNFBTRz6O6RcQ7j05PqNDVWByLrvS
e9P46sJxurguoSCQHHN+PW/TlqvG4tMYIpQU0mngWFCY8vF6GfkOX+kxFO25PzYp
Ibx5b5sLhIP08EBkdzB+CISjtsz4LRtwxyX/jxW++NY2+Uavq+jE43cuTThnFIs4
MFXkBkvCnbT9qI5H9yDa57jTtmQ4SVdZhp2NWVkY6CpPfL2cnBJ4RP9LuaDvycM3
WNJ5HYcCP3TP9oFlDJpMIRDIZr2M/vEFJakVisGph8cfnif5RALbC144nURSq3Mt
kgC7TbRQQsMPKFYcevfYtFzrul2CzueJHZkUKrZNTNwSrnilq38=
=Q7D4
-----END PGP SIGNATURE-----

--qpruqyzgkmcuilyo--
