From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/7] drivers/usb/dwc3: don't check resource with
 devm_ioremap_resource
Date: Tue, 14 Jan 2014 08:15:53 -0600
Message-ID: <20140114141553.GC15785@saruman.home>
References: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
 <1389700739-3696-5-git-send-email-wsa@the-dreams.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389700739-3696-5-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 12:58:56PM +0100, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>=20
> Should go via subsystem tree

too late for v3.14, I'll merge this for v3.15.

--=20
balbi

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS1UaZAAoJEIaOsuA1yqREiUQP/iFrJMNula/ahJS4P+C6d6Kk
ZbtbWqM2pnK0qld127ZGl6haqtBURGio9sQhbz5Lggj4ha8flslyc3em8opd/2El
b6wDQuiLEkAlIVW8Il+PAJsuCI5u/c8IEnuOSKLAxS4i8RmYTu929t4ikE/Q0VJW
wV5b8GjU2pqavCQhUSenB0EY+C7kmUE60+G6I3xTCnhnAJURgwaIB66UWv+JAyGK
CcRVb+giefRqu0VFUjPe8qLY1Eorgc74ZoLXaXkksUJvephRAq1hIIUc5JXXNNQT
Z/LaQx4ernsDiXQI7GJ+ONNhIBvgFLvbEsixviPEb55k+hxmOML9evMPvrxZ/J+X
plD2sk6GNcNPD4k8EiJ5wI9zvvHUAaqg+fAj2Gc0hhVO00k1QoVv7ukJn4RpWYRZ
mOBW7c8axfu/tB3lo10WDAl1ICZ0gh9i3Cv9OZ/Ongt6MN42AvsUuhU3Gpgq3P4J
CWVCacSTdEAOE3GrO1PdnO+oufQeeP/j935fRdpYt1cbg8QwYW5+yUNFEY9TaUHm
CB0ol7nidPn1P0Ss4CV/1UgWcl0FIqhaQ+YRyffIk+GuAwMOttHKxv8TkO0aMzUv
PTtQiGzVyBLK0EMetXSu9kbX8p5Dp28Cks8+bvlAo676SOW+rJVBdhV28cYQaG7y
fxcoxyUoZG13b5y8Oi4C
=JAMQ
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
