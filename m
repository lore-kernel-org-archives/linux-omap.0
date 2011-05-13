From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1] omap: usbhs: Fixed the crash during rmmod of ehci and
 ohci
Date: Fri, 13 May 2011 14:00:58 +0300
Message-ID: <20110513110056.GF11339@legolas.emea.dhcp.ti.com>
References: <1305118241-31677-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1305118241-31677-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2011 at 06:20:41PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>=20
> The disableing of clocks and freeing GPIO are changed
> to fix the occurence of the crash of rmmod of ehci and ohci
> drivers. The GPIOs should be freed after the spin locks are
> unlocked.
>=20
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

should this go via Samuel ?

--=20
balbi

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNzQ9oAAoJEAv8Txj19kN1fz0H/1qxF1vXpoU6wSzAsMhRg4/3
apHbvFkyY2j6HAPYvl+ymur+y4868tw1BIHiqDwj4svyHZsVlEee/JZmr4pdCbXN
BNg94ooI0iTvdtkKJVYOlYMAqFuLIFdSxY4CNkRPtGsvr13JzIlv3Jg4USIAUJph
P/WH8wJyoyjemD08w8s4XFrbttcOFuQG+w959c4RBRtkyhvfDw+6vhVKVJn2FBes
dJP7ko7Zbg36tHEJq0S6tDI/WhjOVf28TRW3Xw7rwSz5duIXTJVO5Ea5asfeNayc
lv/lPw3NXJE3NfC7Jei9SYTq18yL1+1ekMV4LsuR1y+4j3uHIais0b8qEfTJook=
=q3Rz
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
