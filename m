From: Felipe Balbi <balbi@ti.com>
Subject: Re: next-20140428 (regression: DEADLOCK)
Date: Mon, 28 Apr 2014 11:43:26 -0500
Message-ID: <20140428164319.GM30292@saruman.home>
References: <535E4EB7.5010605@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55916 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755802AbaD1Qnb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 12:43:31 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s3SGhVwG000505
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 11:43:31 -0500
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s3SGhVRr010406
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 11:43:31 -0500
Content-Disposition: inline
In-Reply-To: <535E4EB7.5010605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 07:51:03AM -0500, Nishanth Menon wrote:
> omap2plus_defconfig shows for the following platform deadlock with
> console_lock.
>=20
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2biDSRTAP
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20deZjf34
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21NM1bLxs
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2022AFyZ6
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21Dq284CM
>  6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2aK24U5ON
>  7: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s21j15I8kK
>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21jO02jIK
>  9: craneboard:  Boot PASS: http://slexy.org/raw/s22JGqMSfY
> 10: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s260y1Opd1
> 11:       n900:  Boot PASS: http://slexy.org/raw/s20IDKmJ6L
> 12: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2dJcyep9A
> 13:    sdp2430:  Boot PASS: http://slexy.org/raw/s20Oldnm8I
> 14:    sdp3430:  Boot PASS: http://slexy.org/raw/s2Mo7s3ttZ
> 15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2qXj7HFTJ
>=20
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  [ INFO: possible recursive locking detected ]
>  3.15.0-rc2-next-20140428-00002-gd0ca5e6 #1 Not tainted
>  ---------------------------------------------
>  swapper/0/0 is trying to acquire lock:
>   (console_lock){+.+...}, at: [<c07d1124>] con_init+0xc/0x28c
>=20
>  but task is already holding lock:
>   (console_lock){+.+...}, at: [<c008c224>] vprintk_emit+0x200/0x590
>=20
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>=20
>         CPU0
>         ----
>    lock(console_lock);
>    lock(console_lock);
>=20
>   *** DEADLOCK ***
>=20
>   May be due to missing lock nesting notation
>=20
>  1 lock held by swapper/0/0:
>   #0:  (console_lock){+.+...}, at: [<c008c224>] vprintk_emit+0x200/0x590

someone already found the culprit:

http://marc.info/?l=3Dlinux-kernel&m=3D139870299331959

cheers

--=20
balbi

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXoUnAAoJEIaOsuA1yqRE8VQP/RgazYR42d1ryqw0z5idpKqI
LXtLW8neuJHKYzn1TxdEoI3bBrFV7QnFmHh0POP9J7ty2MPw11Yuzej1yieQlLdH
+JvUayTVUmHRftqw/dKmv4RYDAx247/jkHBDCMk1u2rKLsy9nhliW5F07HH/F+gb
9XaK7gOxGFzcGdcKWbZVv94/cMg1NA02bIX9TgvYkW3ur4nnH/d7XFgyfbZ9UjZU
wTyilLBIvB3iq612ssrTylMTw/mwtd0LC4oAxsJ4lYch1wxXefRsXj1qetxN9czo
7ezCFIDNgoxx0pl1VqF/1d/3gyvGW6AOxQ9rGTr08FCoW/Pacp9zlvVqntmpBtTs
tsHZTQ44LXbXJAhPkuQD7vrL1Bv2hqiFOH1MFAsy+uYcrWHQQuM0ZW21sOsrx4iw
sc5innJss+UEpibtD84S/YAccN1keUxNRbYI3PXi17He1O+nkkqzJETT+S6C55h6
kQmi33w4TMgxgf0tRe2+shJ/duVpcotT9OAErr1Ukv0mcbTwN4iCylPQOilzvkGL
ZbNYOQw5/7QFeZLPLPug/lNhvJ6XqPhi/NtQZv+RNt9kmITckBhfI3kR4EOQ8dhm
Cgnd5etsMZGJexpS3VvlBS9G0mQyqk6Jj5Xh0uF4pBnZmHdAT9jXgYWAen2Jnqx2
WqoRKbubI0HVgm94us/A
=R8UB
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
