From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 2/3] mtd nand : add NAND_BUSWIDTH_AUTO to autodetect bus
 width
Date: Fri, 30 Nov 2012 15:21:22 +0200
Message-ID: <1354281682.30168.134.camel@sauron.fi.intel.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com>
	 <1352199105-30215-2-git-send-email-matthieu.castet@parrot.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-4XWZ0XUoAZjQ2Co/Va5j"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17925 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758000Ab2K3NUb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Nov 2012 08:20:31 -0500
In-Reply-To: <1352199105-30215-2-git-send-email-matthieu.castet@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org


--=-4XWZ0XUoAZjQ2Co/Va5j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-11-06 at 11:51 +0100, Matthieu CASTET wrote:
> The driver call nand_scan_ident in 8 bit mode, then
> readid or onfi detection are done (and detect bus width).
> The driver should update its bus width before calling nand_scan_tail.
>=20
> This work because readid and onfi are read work 8 byte mode.


Pushed this one alone to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-4XWZ0XUoAZjQ2Co/Va5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQuLLSAAoJECmIfjd9wqK0u1UP/01DsQHnEms9qe4Q3OdSzjLk
iqlPCwC0o6Jlf8Pe67BjjI/AH6W0wTJp32AOz2ZFpinUtriJyjNa8zHypyQPa9BL
R6rGZlF2M4JE2FfQOPWVsHTpQLCcrlKVWafzuA00Mqc4Ad4fPXpUeBULsB2CKTbS
0aOhoz89O/mG63ThFkkKGKA4SkypziCtna0TxG63dq/wRQ19b1+XrddJclkesL6P
OKGXtSKtX3ez9hrWISQnSqBEQL2HZ1jlC6Ui8JmTPK7+m8735DlRgWx69tMs/Okr
qxqEAyw6AhV19EskSwxax7tsUVwmMQLnO754GMyOebNaEoV8Rpcb43uB/SGc7AEu
F3Hq9nzZ3CobsyxbT8V/3zam6SN4Adx+BpAev+jY4/GxLBf0j1mk2PgyJt4r/Hcs
iW7yQEkFu8m+I0RHLXPhl91L9caGCCi7V5mp22YB1tTrv1VYHRxWCbCDAsYqmmNw
MiGPASC63xqGZpwQwfdRhXFvVOiOBv5F6lFKRZwJm8K0Ml0y5UC1Xpy8Hv5uIdAC
tfaWvaEe1EXpllipaO2lnBCGLlKPsQLDe50R3cGRPTOAN8SkGkh7JkbYYXIGY9Yt
1l+2t1cqLEpjmcLGqbj1VsWiuk6qoqgyoBUJotnbWlb1lVqNX4LiU7v/ZWvXhJDg
Hcj9x0LUbzm5lh9GmqgS
=D//6
-----END PGP SIGNATURE-----

--=-4XWZ0XUoAZjQ2Co/Va5j--

