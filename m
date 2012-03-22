From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] usb: musb: omap: fix the error check for
 pm_runtime_get_sync
Date: Thu, 22 Mar 2012 10:09:20 +0200
Message-ID: <20120322080919.GF31160@arwen.pp.htv.fi>
References: <1332400686-27674-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1332400686-27674-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2012 at 12:48:06PM +0530, Shubhrajyoti D wrote:
> pm_runtime_get_sync returns a signed integer.In case of errors
> it returns a negative value.This patch fixes the error check
> by making it signed instead of unsigned thus preventing register
> access if get_sync_fails. Also passes the error cause to the
> debug message.
>=20
> Cc:  Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

applied, thanks

--=20
balbi

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPat4vAAoJEIaOsuA1yqRELzkQAJ2QBevV8d/SmfAmlFbRyPmJ
f8lJwsLzkglVVmGW0IjqANgilIo59O0qYe9hX1QvuZ4E7KWaPkaT8RDoq1C/U0z6
NNeUDHP3eYadjq8KdumUHvI5c9NB1LeDUdZyuwaiBoJIaJ/37Xh4Bfm6BH6TnJJy
BFyRrRhoCFGDzSvTQ5ztEXU1qZjgD8+wP26Ie4UNERmUcpYcc9HZchLg0z8L7IEE
dSQKKoDrqsvcRGcjhRdUN5yU++XiOyykhpBrzjGEkw90SSLTBBwquuBtnVrXkIaT
wPaDLTVWwVBslS3pJ+GFUc87sqi1Gt+tkO8TgMcLet9ue9O/BfPrQE/8jrWVU7UG
jB3CiV49TpsLuQS2Dk4GB4pYBLqS0aDE2xatawZba8GuwQ1HqmFFD3Gm0nBQ5vOw
f+HruH3UZ7nbnceplCegQvA7+SdiqGmwOgVelCL012F+syukXqg0LaocIZ8bwbTr
FdmN/lTRSxamaWkmWQIsw8/j/aEWV8ML8sjEgkjVeBO8/LHQhrzRd49CJsosy1Ad
VeZ8ryomA7YYlwAOwLklSGTdKfNFXrh8KFjRuVmUGEqiEqMCmvoJR8VIWb/56smu
y/sREs9/DWeQxgG+w+LaW2nUOCfaBbTRrUCse2TRk6gWLI8uFSnmutCRoPWF3A1s
IJLouSu6rZTn4ra4QXR0
=2ALQ
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
