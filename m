From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 17/17] i2c: omap: get rid of the "complete" label
Date: Mon, 2 Jul 2012 14:59:05 +0300
Message-ID: <20120702115904.GE2730@arwen.pp.htv.fi>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
 <1340964817-8599-18-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340964817-8599-18-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 29, 2012 at 03:43:37PM +0530, Shubhrajyoti D wrote:
> @@ -962,7 +972,7 @@ complete:
>  			ret =3D omap_i2c_transmit_data(dev, num_bytes, true);
>  			stat =3D omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);

this isn't needed anymore. please remove.

>  			if (ret < 0)
> -				goto complete;
> +				goto out;
> =20
>  			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
>  			continue;
> @@ -978,7 +988,7 @@ complete:
>  			ret =3D omap_i2c_transmit_data(dev, num_bytes, false);
>  			stat =3D omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);

this isn't needed anymore. please remove.

--=20
balbi

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8Y0IAAoJEIaOsuA1yqRE9qwQAJDivGFaqQbnP/QCbo1iN1Pi
fNssA846cvLhD62fEPmZmAJFsqsy+18l9DW0rYbQ61ntK+8bpYwkUIxthuYbOo+n
s8waeo9rwk4TAEUV4UNLrVOBEhcvI5yr9jlB+27EJuEy/X1TfVVeziQ7ydYhAuuq
5++W1c0nbZ5jhfFKW7EJEQPuM4XOJ31vTDas/7nC8UWQZZgOyMfdD8kQTSB2EPtv
MrobISMH8ld4XK8S/w6MPNH3ZkqxpoWTt+db6Boff8Fip07yLGukealTkrVquTfP
sYDx0bboxphOkEloYR579IQZTcSXKksV0R4bLPBDDq3nmCAx0Ehk1LBPfqEhCR14
IBzZqI0PFzaQlqEVOoSBbvAu7pyZOCGhWwrYxiXDEYNMgOOIzPboWdkh2cakSjBq
aNWh/+hKj79IOs/Ls86F+krTT53x9clPsETz7UZMr6Iak5A/HfyxUaRc9QAqqr8c
ncPpvL63iD4Luk5WwlQ6hIVttS6Y2Zv1zW1bFaDBZ/eFMnEwqJuWWTDOFW9NXKPe
oQTtJVRxC9z9WknjTNrBViCpfvtR9PEMRr+83ugVa1QNOnuOgGcnjwzrLeM98gVU
8Ffn39kDtQrMjBeS9akxjSM9349lhLD3+f7xgKSIjCtEJEqm0x3mYQiWg9GqZ++I
uD5cO0P+/yyVXeZ1RTPU
=6r26
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
