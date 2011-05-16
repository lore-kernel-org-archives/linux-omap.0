From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB-ehci enumeration issue
Date: Mon, 16 May 2011 16:41:12 +0300
Message-ID: <20110516134109.GF11339@legolas.emea.dhcp.ti.com>
References: <BANLkTin1WEd0KeUb7kZ80GAYbEQC3SkezA@mail.gmail.com>
 <20110502095647.GU2529@legolas.emea.dhcp.ti.com>
 <BANLkTi=6gyWG3Dww_uY89vDW_P6zGV=N9w@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VcSvkf+hAuPXtVJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34672 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755413Ab1EPNlR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 09:41:17 -0400
Received: by mail-bw0-f45.google.com with SMTP id 16so4133873bwz.4
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 06:41:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=6gyWG3Dww_uY89vDW_P6zGV=N9w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: balbi@ti.com, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org


--4VcSvkf+hAuPXtVJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 15, 2011 at 06:21:31PM +0530, ABRAHAM, KISHON VIJAY wrote:
> > > Does anyone else observe this issue?
> >
> > could be the regulators problem. Can you try with my hci branch ?
> >
> > git://gitorious.org/usb/usb.git hci
> >
>=20
>    saw the issue even in this tree/branch.

Keshava ? Do you have any patch fixing this ?

--=20
balbi

--4VcSvkf+hAuPXtVJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN0Sl1AAoJEAv8Txj19kN1NgcIAKvdufrry5HMVHOUgFTZFgUK
ULbvLovN8+cJi6EqiOsqa31JpN7bO82wndda4kNiKYVfARE4Ohk4cSngyZ/kheDN
QrnTnsATS6b2j8N46ON6C8YUr2OSFkDaboouJmaZhJl4MOWkoue+vAJTCjcd/Xw6
IymfZE98iAR5y6/30CuXxnpUhxS/7L6lJIV7hUJqgmhna8+pm/F1vsbOU2nkdrMu
RLCQC1k6hxvsyifG+ACkG6sLaHVB6w7/J48qSoafTfaPC50iPTe8h8t81vdvwAbm
dklkbakFUmAIZPb4T5v4d9kxi3GYbZZAbyiezgk7wMyUwD0moSl+Y1ku8HfG/24=
=BZWi
-----END PGP SIGNATURE-----

--4VcSvkf+hAuPXtVJ--
