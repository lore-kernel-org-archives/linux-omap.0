From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND][PATCH 4/5] arm: omap: usb: Runtime PM support
Date: Wed, 18 May 2011 13:48:09 +0300
Message-ID: <20110518104806.GB13908@legolas.emea.dhcp.ti.com>
References: <1305538732-21087-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1305538732-21087-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2011 at 03:08:52PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>=20
> The usbhs core driver does not enable/disable the intefrace and
> fucntional clocks; These clocks are handled by hwmod and runtime pm,
> hence insted of the clock enable/disable, the runtime pm APIS are
> used. however,the port clocks and tll clocks are handled
> by the usbhs core.
>=20
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Samuel how do we solve this series ? I can take the arch/arm/*omap*/
patches through Tony's tree, can you take the drivers/mfd/* via you
tree ?

--=20
balbi

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN06PmAAoJEAv8Txj19kN1gZUH/jVzKJ6ekhJ+hYSTgRRcQ+bo
hRzW+WkjEQgibIJfO5lB7tRo+LdT5sAq6h8eDmBozu68M501BTatdEGjQrKxpCaJ
q+x1crAzum5m37rFunkIgYd9UBcdQo/yteQBhPKjED+eO5aSWIBCJUlJJ03OGBC+
mlr4LYenorZyvM4o1HENA8QrEbdgbEUegUgDn8cWqccbeFIIz7frBjh2e/O81FuZ
wd2+Ryv2znJtEsYTMKP7G6ndrAF7epfd23CItHzGSqUh/ghyPNAxUt6oiNxBzPpa
qewlDkoNjqXZ+x4OCHqqwUEkXFLyMQnc1ayhbQrmkhbnM+l+h1n3aZGKFnk4XRw=
=JI2p
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
