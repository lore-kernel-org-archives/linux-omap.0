From: Felipe Balbi <balbi@ti.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Thu, 28 Jul 2011 16:26:29 +0300
Message-ID: <20110728132629.GH9069@legolas.emea.dhcp.ti.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bda7maMjJbTZ4Ov1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52293 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753005Ab1G1N0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jul 2011 09:26:32 -0400
Received: by mail-fx0-f51.google.com with SMTP id 10so1337073fxh.38
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:26:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: linux-omap@vger.kernel.org


--bda7maMjJbTZ4Ov1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2011 at 03:15:20PM +0200, Arno Steffen wrote:
> Maybe you are so kind to give me a hint:
>=20
> Try to migrate from Kernel 33 to 37. Currently I don't see any message af=
ter
>=20
>   Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>=20
> Starting kernel ...
>=20
> From what I understand kernel starts with start_kernel()).
> What is best way to find out which part is failing? At which point I
> do a printk to see what's going on, or at least set a GPIO Pin of the
> processor?
> How to debug without any external tools like JTAG.

try to enable CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK, then add "debug
earlyprintk" to your command line. See if that helps showing more debug
messages.

--=20
balbi

--bda7maMjJbTZ4Ov1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMWOFAAoJEAv8Txj19kN15KcH/j3P3q8/UPUEzNAxv1F22RjH
dXlAzsPWHnsI15ioUMX6QK/LEu5N/sKMfUFQ5zyxfHv/8uNdeq001/W9K2xT9YkQ
SwV9dO44a+ygfAlbG+0Q1uxqSTXdkzZFStE4KihaKWqFhSN1692lJj55h8BIfmh+
JraMk+ArNkCz8CEJDXW+HVjZDJQoItUSDuIITxEyC00zJLFwVu4KzWBrocRrjY9m
8w+IH5MUs+xfr45omqgp26eF5oWyHdaRZSqyovKxD5cVE5o8h22+wnLcPTWeZ8AB
Rnk64FveYlOrlr1KJPfshBt+iISkLsNFKhHsGJWLyV2Pq5ra1kjziFRtk9/Evus=
=h+/I
-----END PGP SIGNATURE-----

--bda7maMjJbTZ4Ov1--
