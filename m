From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: fix shutdown while usb gadget is in use
Date: Tue, 24 Jan 2012 11:10:56 +0200
Message-ID: <20120124091054.GM27414@legolas.emea.dhcp.ti.com>
References: <1326374565-23042-1-git-send-email-notasas@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DheUW4aQn8WJk6WR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39213 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754633Ab2AXJLB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 04:11:01 -0500
Content-Disposition: inline
In-Reply-To: <1326374565-23042-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>


--DheUW4aQn8WJk6WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2012 at 03:22:45PM +0200, Grazvydas Ignotas wrote:
> If we shutdown without stopping the gadget first or removing the cable,
> gadget manages to configure itself again:
>=20
> root@pandora /root# poweroff
> The system is going down NOW!
> Requesting system poweroff
> [   47.714385] musb-hm halted.
> [   48.120697]  gadget: suspend
> [   48.123748]  gadget: reset config
> [   48.127227]  gadget: ecm deactivated
> [   48.130981] usb0: gether_disconnect
> [   48.281799]  gadget: high-speed config #1: CDC Ethernet (ECM)
> [   48.287872]  gadget: init ecm
> [   48.290985]  gadget: notify connect false
> [   48.295288]  gadget: notify speed 425984000
>=20
> This is not only unwanted, it's also happening on half-unitialized
> state, after musb_shutdown() has returned, which sometimes causes
> hardware to fail to work after reboot. Let's better properly stop
> gadget on shutdown too.
>=20
> This patch moves musb_gadget_cleanup out of musb_free(), which has 2
> callsites: probe error path and musb_remove. On probe error path it was
> superflous since musb_gadget_cleanup is called explicitly there, and
> musb_remove() calls musb_shutdown(), so cleanup will get called as before.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

applied, thanks

--=20
balbi

--DheUW4aQn8WJk6WR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPHnWdAAoJEIaOsuA1yqREiz0P/17MZIoV7Fei2I43q4/QsL6y
rjNjKXURAbTmziwOvz9ZhWRXYNan+++ecbk9ilKssYZM5wHm21Hp7VZMrtXxjggH
P8FL0QYZOYg0h6UjvZPE7KXadCLpip9+ZPsHAFxsAUh4Sjmpsp8pe36fqcVYKa/x
+qLntNOEsyikStvpscE04RFNhJWYZW6wTxO4uSn/Ca7Xx4k0G3vV+25h+dV6ukUQ
sJnijHADZAhUBi7hddrpO4rhFeu+Vf9Q6Y8S8GK8dqgSR2Bc261yNrc3jZgrXGOK
OJvuoRg4gQOZDXGFMJ4K/av7oYBxDX+YMVppu/atSnr+fRtgKPggkZmIWu4Bz7ZX
LipC1mDdn6TfoBZLRgd6UvMrC8rC7rmwdEx61aWDeUMp9V5/SwM9fR0qcD7HYERN
+y4JaihTGPHHdqDP9Ido/6RLTxJycC/ojZsCj7KLuafvCbLVoe3DH/72IfzVgt+7
UqYr+P8r/0N85YB+FtHr1yGPXwwUPX56dxr9v7Z9qO///1zARdTFTPmROGSGeWQl
NNLPqhKPioThj951aeJ75na0YAGhpnx1tqqMmAN3uGF9wx4XAJPpzWXPwnhXqc9w
ytzMxbVvYtc/Vi8YP2JCi7rLiHdQeih7aYUTsneII9xwbKYZNu/fJllnfVS2dJxk
oPkV44vSWD63bCMkfsV3
=7gh3
-----END PGP SIGNATURE-----

--DheUW4aQn8WJk6WR--
