From: Sebastian Reichel <sre@ring0.de>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sat, 7 Dec 2013 14:48:20 +0100
Message-ID: <20131207134818.GA933@earth.universe>
References: <20131206213613.GA19648@earth.universe>
 <20131206222725.GM26766@atomide.com>
 <20131207000026.GA26921@earth.universe>
 <201312070918.32471@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:47965 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758432Ab3LGNs2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 7 Dec 2013 08:48:28 -0500
Content-Disposition: inline
In-Reply-To: <201312070918.32471@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2013 at 09:18:32AM +0100, Pali Roh=E1r wrote:
> On Saturday 07 December 2013 01:00:27 Sebastian Reichel wrote:
> > On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren wrote:
> > > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > > Nokia N900 DT boot breaks for me using 3.13-rc3. You can
> > > > see the relevant kernel output below. Disabling the AES
> > > > module in the omap3-n900.dts with status =3D "disabled"
> > > > fixed the boot for me.
> > >=20
> > > OK thanks for letting me know. How about the following patch
> > > to fix it?
> >=20
> > That's basically what I did to fix the problem.
> >=20
> > I guess the proper fix would be a runtime check if the device
> > can be accessed (if that's possible). AFAIK it is possible to
> > use the AES module on the N900 if the bootloader is slightly
> > patched.
> >=20
> > Pali, can you elaborate more about this? I've seen, that you
> > added a section about this on [0].
> >=20
> > [0] http://elinux.org/N900#M-Shield
> >=20
> > -- Sebastian
> >=20
>=20
> Yes, if you want to use M-Shield on Nokia N900, you need to use=20
> new version of signed Nokia X-Loader which enable M-Shield usage=20
> outside secure world.
>=20
> Because this updated X-Loader is not official and I think nobody=20
> has it in n900, please disable using these M-Shield crypto=20
> modules on n900.

Is the updated X-Loader available somewhere?

> Without patched updated X-Loader kernel will crash.

That's what this thread is about :) It might be better to have a
runtime check for the crypto hw's accessability by adding something
like this to the driver's probe function:

if (!aes_module_is_accessible()) {
    dev_err(&pdev->dev, "Usage of OMAP's AES module is blocked\n");
    return -ENODEV;
}

That would require, that aes_module_is_accessible() can actually be
implemented.

P.S.: I fixed the mail address of Aaro Koskinen. His nokia mail
address doesn't work anymore.

-- Sebastian

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSoyciAAoJENju1/PIO/qatr8P/0mxlRKf3txFxvbfManS5EMc
InVCyjTp61ldnvigGE4AWseOXZkv7Zg27QZTzxAXNaY5HjibLNnqoYV0YwfsF4Lk
w0wKumsY900A5Gj5482qktQroJuoHmedl0eFv3wKwon6vF7mFoWc9peZK98+e0Wm
X7ICckb9Ld8A5LJroPfeItgfumBvj2N2LviuzZQPrSTNKZn5oNUFIUwKs6+WIaQv
qToklFSA2yi1zfoXwmYiMq/A0a5y2UjVMYd8OA/HVeu4YzgbHpr4YvJ61epMHbMl
825kc3Cp66Wb1mm9JEO6TodI41o1GH79vkMvdARp8pSxRhjtvvA3YNuyTk+O1SGa
6B9maG52ybTX4SzpB8kAdTcOkyL33yvDj0S3Z0vmAfmDUhGMPKOlCl0FakCOob1D
wa7/CD5iCmIYD0hbcDozeF/7Wcr85yHMBGQB2AxVc54Q+SwfwePM+rqjAJ4B01h2
Fknx8hPRpoeOEG4AvOed1ffUrEKcyv7zxUoFcNJBPnlEpUi0yI7C1K0GNwM82Fha
B4+Ou17f21bmN/+JajySaYGPe05vkDhxTsAxmgyWyE9gEiqDD1bhPLc3LfLLASRU
mIFPCzxgXLBCzljxdT27qOJvZie2raznjPbtPGd4+hA8ByWZeWvrgGinNRpnEN7Q
fcRj3UXscOD7vdzAg4/h
=W6XM
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
