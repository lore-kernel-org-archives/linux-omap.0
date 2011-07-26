From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] mfd: omap-usb-host: fix clock API usage on
 usbhs_disable()
Date: Tue, 26 Jul 2011 17:34:34 +0300
Message-ID: <20110726143433.GX32582@legolas.emea.dhcp.ti.com>
References: <1311340170-28773-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NAuYj0K7Umiq33rm"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1311340170-28773-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--NAuYj0K7Umiq33rm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2011 at 06:39:30PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>=20
> usbhs_disable function was invoking clk_enable() instead of
> clk_disable(), thus only increasing the clock usage counter and
> preventing this particular clock from being ever turned off.
> Because of this, the power domain of omap4 the USB Host subsystem
> would never reach lower power states.This patch calls clk_disable()
> in usbhs_disable function
>=20
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Samuel, I guess you can take this via MFD ?

--=20
balbi

--NAuYj0K7Umiq33rm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEbBAEBAgAGBQJOLtB5AAoJEAv8Txj19kN1f0YH+Pwg1oUbEOrPgDMMdlAJHC/Q
c76bwUVnnP6PF4JT8erfKcgAsHQWTtXn54J07l5DBfKjlhKCy8bvzzJZCD06N3Nr
oZu8oWbeZEgJX141F26cjniUzLOL8RwraIqxKW5JwxX1FcV93MG6ukW2lu7VsrkF
Ga8gO81XproFSCcRG8mnJmSHAfjW5HFTPFdcKYD5ePVD/csJlUAaMdVV+oLjcGH+
b0VKpq81SBeZfTCEyOuka+a3Z6Y6b22LRNKRrVA4L5jiC0y0MGQrMOdCgaKHKOtv
g4zv9mJcPg150HBWNiqkxN9+h4KL4yyWpGj8h12q+E/RgPt2xPuDYuBB4mrHGA==
=Fb9y
-----END PGP SIGNATURE-----

--NAuYj0K7Umiq33rm--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
