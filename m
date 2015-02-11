From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Wed, 11 Feb 2015 13:39:54 +0100
Message-ID: <201502111339.54480@pali>
References: <20131206213613.GA19648@earth.universe> <201501311234.41001@pali> <CAALWOA9jXeUgOj=GWFVQKkaz_Goxj-NOKk5qRHUTF6=EXEu+6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10629115.KheislV518";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:43434 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbBKMj5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2015 07:39:57 -0500
Received: by mail-we0-f180.google.com with SMTP id k11so3113220wes.11
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2015 04:39:56 -0800 (PST)
In-Reply-To: <CAALWOA9jXeUgOj=GWFVQKkaz_Goxj-NOKk5qRHUTF6=EXEu+6w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

--nextPart10629115.KheislV518
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 31 January 2015 16:13:39 Matthijs van Duin wrote:
> On 31 January 2015 at 12:34, Pali Roh=C3=A1r <pali.rohar@gmail.com>=20
wrote:
> > [  172.923553] Unhandled fault: external abort on
> > non-linefetch (0x1018) at 0xb6f87028 [  172.930664] In-band
> > Error seen by MPU  at address 0
>=20
> Also, why is this error so uninformative?  A synchronous abort
> should at least mention the _physical_ address, type of
> access, etc.
>=20
> Anyhow, since checking the firewalls/APs to see if you have
> permission will probably only get you yet another fault if
> things are walled off, the robust way of dealing with this
> sort of situation is by probing the device with a read while
> trapping bus faults. This also handles modules that are
> unreachable for other reasons, e.g. being disabled by eFuse.

It is possible to patch kernel code to mask or ignore that fault?=20
Can you help me with something like that?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart10629115.KheislV518
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTbTZoACgkQi/DJPQPkQ1IKdACgp+zM9NRXF5ITapiIFkGnyzoI
ZwwAniv0CT66KEYILW3pquLzKtaG32TU
=RKFb
-----END PGP SIGNATURE-----

--nextPart10629115.KheislV518--
