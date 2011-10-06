From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] mfd: omap: cleanup: use macros to check for TLL mode
Date: Thu, 6 Oct 2011 12:30:44 +0300
Message-ID: <20111006093041.GE1714@legolas.emea.dhcp.ti.com>
References: <1316010433-6024-1-git-send-email-kishon@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1316010433-6024-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2011 at 07:57:13PM +0530, Kishon Vijay Abraham I wrote:
> In one particular place the old form of checking for TLL mode is used.
> This patch fixes the same by using macros to check for TLL mode.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

looks good to me, but this should go via Samuel Ortiz's MFD tree.

--=20
balbi

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOjXVBAAoJEAv8Txj19kN1Qo8IAKPJNGkiEJm2F7Dy0PykJE1m
hVEBzUnuUxmEDAb9MH8beyfKVYrj+GUyD+Fac4Pj/x8lyMWXfs7lw/tbFULconnI
5y5uYj+isZzzG/5FO+KOOEN4suIdXuVKq1FKH4d1E1Enups9pFgstVyEXEhdlO8e
P0X7dmLbrerJMU4jXhj1RDNmiXnxqcunhH66eFdLQS3h0s1h61JlgypDuoZzVHIw
JuulCKgKE9SKZyF+w7TjH5kFbp51k4Vg9UBtIz8rllp8Y+EAfP0tmoOzVl9Q2zci
SERLuT3i8PIFb+sPp7T5WSv1Bif81TDjpeA+mEqwdhVjLOvDlm4MwcovGahbwdA=
=m68N
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
