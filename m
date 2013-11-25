From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/5] usb: musb: dsps: add support for suspend and resume
Date: Mon, 25 Nov 2013 14:55:49 -0600
Message-ID: <20131125205549.GO18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-5-git-send-email-zonque@gmail.com>
 <20131125194804.GB18046@saruman.home>
 <5293AD40.6060607@gmail.com>
 <20131125200853.GG18046@saruman.home>
 <5293B28F.9010506@gmail.com>
 <20131125204641.GM18046@saruman.home>
 <5293B920.30401@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KZa8Qkr7Zx+i11wB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48827 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab3KYU4p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 15:56:45 -0500
Content-Disposition: inline
In-Reply-To: <5293B920.30401@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

--KZa8Qkr7Zx+i11wB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 09:54:56PM +0100, Daniel Mack wrote:
> > As Alan said, usb-persist should already for a
> > bus-reset when resuming, right ?
>=20
> The explicit un-reset is really needed, otherwise the port will
> reenumerate the device, and a previously mounted filesystem will become
> invalid of course. The log looks like this in that case:
>=20
> [   17.045641] PM: resume of devices complete after 166.084 msecs
> [   17.056461] PM: Sending message for resetting M3 state machine
> [   17.063451] Restarting tasks ... [   17.071767] usb 1-1: USB
> disconnect, device number 2
> done.
> [   17.403402] usb 1-1: new high-speed USB device number 3 using musb-hdrc
> [   17.766959] usb 1-1: New USB device found, idVendor=3D058f, idProduct=
=3D6387
> [   17.774849] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3

got it now ;-) Thanks

--=20
balbi

--KZa8Qkr7Zx+i11wB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk7lVAAoJEIaOsuA1yqREhuMP/1YwykAShW5xCBeA4n192BZe
V32butFh8D5LuwuJ1eJfA+8+kotYVQ2wh8BwL+ese+ly9piR3K+2bn5iNsKvg6Gu
wzAmG/zjw5eMgI7ftlk/QfxIS7aNIh6gPLIojkQ7+LQRnQtjNBL9Nlad2hc5/wiA
4WJJ862Xhku40DfRNrRu6IbDu/Yw0LpGT3vhIr+pevXViu/oAIDsZrdb7kMM6xlZ
qxvGWZvOS7HIaUjMfbiGcxjFowAeEUlpfUkFl9WzluGwlF7b9Xdgommm7gs64LO0
4j4mkY8/RFmc6Mz5DldSpPIM5P968yoydaOKmWVt5eHVsQtkdMrlk9RFQeN77Py4
7FI+yHoQNlqARTYRFmcvHE3/2ftyeEN1+8YNvdAow2+3BFV0NNGx1TyR1T8SEBKO
2kcLygcDTLcy/OgQSEUOt//p31J+I72+032dyFTtvpH+GyWfalJIcbicRCQ/X2tU
UkH9TMeakOiWEX3xXVfhZwcuOWrzSGqI0JsRgB4wGbXcLDMeX28bnjNWg9Lp4H6r
4E0N7iBfdmemKtBnZdHw68QAeQBMt4uR0ET/b2I7b1JR1XfSY3bSHgqgfZ5JfXYa
DAYjlBlm/GqTL+rS53updWwwLITVLRppB6XTGarPRjghdtRDsnFbNby/gC7Mjm5I
/cQTxpVRFu9wpDvu2PVm
=AjsO
-----END PGP SIGNATURE-----

--KZa8Qkr7Zx+i11wB--
