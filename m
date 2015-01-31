From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 31 Jan 2015 20:06:18 +0100
Message-ID: <201501312006.18465@pali>
References: <20131206213613.GA19648@earth.universe> <201501311234.41001@pali> <CAALWOA9jXeUgOj=GWFVQKkaz_Goxj-NOKk5qRHUTF6=EXEu+6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1449976.DsASfTbacX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:47017 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbbAaTGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 14:06:21 -0500
Received: by mail-we0-f180.google.com with SMTP id m14so32460845wev.11
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 11:06:20 -0800 (PST)
In-Reply-To: <CAALWOA9jXeUgOj=GWFVQKkaz_Goxj-NOKk5qRHUTF6=EXEu+6w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

--nextPart1449976.DsASfTbacX
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

Just to note that above error output is from device where is=20
signed X-Loader which *enable* omap aes support.

So it looks like it is not possible to dump registers which=20
should tell you if kernel has permission or not (in L3 firewall).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1449976.DsASfTbacX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTNJ6oACgkQi/DJPQPkQ1J9UwCfY9l6RU20h3mqnQ3Pwd4Ne0St
VbUAn3Ihm6BXvlbNqX6voQNsLXtybSLH
=FAsq
-----END PGP SIGNATURE-----

--nextPart1449976.DsASfTbacX--
