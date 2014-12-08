From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: nokia_h4p on 3.16+
Date: Mon, 8 Dec 2014 23:10:50 +0100
Message-ID: <201412082310.50742@pali>
References: <20141208204735.GA21599@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2059630.uyX7N60L8D";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141208204735.GA21599@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, balbi@ti.com, Greg KH <greg@kroah.com>, marcel@holtmann.org
List-Id: linux-omap@vger.kernel.org

--nextPart2059630.uyX7N60L8D
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 08 December 2014 21:47:35 Pavel Machek wrote:
> Hi!
>=20
> It seems commit:
>=20
> commit bd5dc09f557547399cd44d0a1224df7ff64e4a6b
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Wed Apr 23 09:58:28 2014 -0500
>=20
>     serial: fix UART_IIR_ID
>=20
>     UART IRQ Identification bitfield is 3
>         bits long (bits 3:1) but current mask only
> 	    masks 2 bits. Fix it.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> breaks bluetooth driver on n900. (drivers/staging/nokia_h4p).
>=20
> Pali, you may want to revert the patch.
>=20
> That is good news, because reverting it on 3.18-rcX brings h4p
> back, too (and as machine boots on nfsroot, debugging should
> be possible.)
>=20
> Best regards,
> 									Pavel

Pavel, maybe there is some unhandled iir value in function
static irqreturn_t hci_h4p_interrupt(int irq, void *data)
which cause that driver is not working?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2059630.uyX7N60L8D
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSGIeoACgkQi/DJPQPkQ1KpqgCdH1h+RIcLY3baLr7N+8fJNycK
eacAnAs+bBPFUeizvbnw2XGfTuHVIc+a
=/GXN
-----END PGP SIGNATURE-----

--nextPart2059630.uyX7N60L8D--
