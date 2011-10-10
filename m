From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [v2 1/2] usb: musb: omap2+: fix context api's
Date: Mon, 10 Oct 2011 09:08:11 +0300
Message-ID: <20111010060808.GD31707@legolas.emea.dhcp.ti.com>
References: <1315412364-21384-1-git-send-email-vikram.pandita@ti.com>
 <1315412364-21384-2-git-send-email-vikram.pandita@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1315412364-21384-2-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2011 at 09:19:23AM -0700, Vikram Pandita wrote:
> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>=20
> RxFifoSz, TxFifoSz, RxFifoAddr, TxFifoAddr
> are all indexed registers.
>=20
> So before doing a context save or restore, INDEX register
> should be set, then only one gets to the right register offset.
>=20
> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

applied, thanks

(sorry for the long delay)

--=20
balbi

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOkovIAAoJEAv8Txj19kN1LNYH/A8XrSQKqgkAdIf8wpTthNzT
dc0ENuKRZIeuFH+q/94qi9lTjTvFpmadJxJoQAwTyGUWbc5dWlSZFPFuQqdFHEy1
wkipCLjpNdJLzTYWjdruPhy++TBVJ2ZtzaAwNRjptf58MwL9bkL2pn1T1iJm2//9
0H7EzsJsLL72BEA1EZ0ynjTK6WdN4pPCX18Oe5jEDScRtQHeg4METVHP1b7mXYSH
3L+h9aKaEeJR6OgyPbA/2ieWxmCRsVWAepxmWuIy5lQ8nGcVSkALhWDPTjoO+fhT
O5wUp54LZ9iGPsVs5CMhxOyo6b6nDAUOtjNW7vTLWkwis/7XM2OZ07V9NNkMdkU=
=y5LE
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
