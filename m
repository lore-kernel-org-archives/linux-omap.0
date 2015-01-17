From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 17 Jan 2015 18:29:18 +0100
Message-ID: <201501171829.18354@pali>
References: <20131206213613.GA19648@earth.universe> <201501171018.51811@pali> <20150117170411.GT18552@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3398351.2WUBXKSUHt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:40856 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbAQR3V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2015 12:29:21 -0500
Received: by mail-we0-f173.google.com with SMTP id q58so25049949wes.4
        for <linux-omap@vger.kernel.org>; Sat, 17 Jan 2015 09:29:20 -0800 (PST)
In-Reply-To: <20150117170411.GT18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>, Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

--nextPart3398351.2WUBXKSUHt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 17 January 2015 18:04:11 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150117 01:21]:
> > Hello, after playing with aes and non-aes version of
> > bootloaders I found out that code which configure L3
> > firewall must be in signed X-Loader part. So probably we
> > cannot change configuration at runtime...
> >=20
> > Tony,
> > any idea how to dump L3_PM_ADDR_MATCH_* registers from
> > userspace or from kernel? Now I have configured one N900
> > with original Nokia X-Loader (where loading omap aes driver
> > cause kernel crash) and one N900 with aes X-Loader (where
> > loading omap aes driver is working).
>=20
> Hmm maybe give the omapconf too a try? It's at:
>=20
> https://github.com/omapconf/omapconf
>=20
> That uses /dev/mem from userspace, then you can just ioremap
> them in the kernel code if you need to do something during
> runtime. Probably best to access them with a syscon mapping
> from the aes driver.
>=20
> Regards,
>=20
> Tony

https://github.com/omapconf/omapconf/wiki

Legacy TI OMAP platforms (OMAP[1-2-3]) are not supported.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3398351.2WUBXKSUHt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS6m+4ACgkQi/DJPQPkQ1Ls5gCfabzvdCC5/r6VqyiH4VFNWvLH
hQAAmwbzXnZaz0brSUq7LxTfnRR8Mq5A
=ZD19
-----END PGP SIGNATURE-----

--nextPart3398351.2WUBXKSUHt--
