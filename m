From: Felipe Balbi <balbi@ti.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Thu, 28 Jul 2011 17:33:34 +0300
Message-ID: <20110728143333.GN9069@legolas.emea.dhcp.ti.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
 <20110728132629.GH9069@legolas.emea.dhcp.ti.com>
 <CAACX+R0-vUP1z9DoS69iv2gX=YCKanousEHATzot0sSi-S9cEQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kqbdc5qIhvft+WjL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46512 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221Ab1G1Odi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 10:33:38 -0400
Received: by mail-yi0-f41.google.com with SMTP id 13so2204267yia.0
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 07:33:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAACX+R0-vUP1z9DoS69iv2gX=YCKanousEHATzot0sSi-S9cEQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: balbi@ti.com, gary@mlbassoc.com, linux-omap@vger.kernel.org


--Kqbdc5qIhvft+WjL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(please don't top-post)

On Thu, Jul 28, 2011 at 04:18:51PM +0200, Arno Steffen wrote:
> That has been good points. I've tried both, but with no result so far.
>=20
> boot_nfs_nand=3Dtftpboot 0x80000000 uImage; set bootargs
> ${bootargs_fs1}; run addip; bootm 0x80000000 ethaddr=3D00:11:22:33:44:55
> bootcmd=3Drun boot_nfs_nand
> bootargs=3Dmem=3D128M console=3DttyO2,115200 noinitrd root=3D/dev/mtdbloc=
k6
> rootfstype=3Djffs2
> bootargs_fs1=3Dmem=3D128M console=3DttyO2,115200 noinitrd
> root=3D/dev/mtdblock6 rootfstype=3Djffs2 debug earlyprintk

Dumb question, did you recompile your kernel with those enabled ?

If nothing comes out, then you might need the help of a JTAG debugger.
You might want to try openocd though as it's open source and there are
many cheap JTAG debuggers which work with that (Flyswatter,
arm-usb-ocd, arm-usb-ocd-h, etc).

--=20
balbi

--Kqbdc5qIhvft+WjL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMXM9AAoJEAv8Txj19kN1zi0IAJwtTow8bB9CNvP87n8q87Wy
uGorVLaV8JIeiMRgbGDLGk3gb08IXrWH2mZczCGQokHvoBHAvVZqQNhPOl5E071q
13F55YLWtgM9QhdK7ZE/LyrurQVJ9xtWn9ditP3a6tHYhd82Q7LU/reow2lW/WIR
oyzuy8GM3dO1ogQKPd9jqlQRzPznvwJiP084nCrzI2N0Dbv1iZKsSoSAG8sTA4ic
Q6RnDkc+QRFShN97K55ZiswV8Og9pKClrtPNx1vuoEggj/rxrtDSObRE2hqRJ8IY
L3twKi+EhjQWNidFDkinxejCRViqllb/LRkRO4dCVDkk3R+cZ2aeKca8CTOyi7A=
=xt+T
-----END PGP SIGNATURE-----

--Kqbdc5qIhvft+WjL--
