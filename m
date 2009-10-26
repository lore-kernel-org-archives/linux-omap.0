From: green <greenfreedom10@gmail.com>
Subject: Re: 24xx/n8x0 booting again, linux-omap updated to -rc5
Date: Mon, 26 Oct 2009 10:08:40 -0600
Message-ID: <20091026160840.GP22912@swansys>
References: <20091016012747.GA12576@atomide.com> <20091020163102.GB22912@swansys> <20091020185627.GJ12576@atomide.com> <20091020220849.GC22912@swansys> <20091021184047.GK16230@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FilwpOHBrTVNlmJ3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:55849 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbZJZQIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 12:08:44 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4917662fgg.1
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 09:08:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091021184047.GK16230@atomide.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--FilwpOHBrTVNlmJ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tony Lindgren wrote at 2009-10-21 12:40 -0600:
> Well I got took a quick look at it last night to get the LCD working agai=
n..
>=20
> I just pushed one fix into omap-fixes, fixed the drivers/cbus compile, up=
dated
> the board-n8x0.c for LCD. And then still needed one more hack to skip the=
 LCD
> detection.. The current linux-omap master should work with the two attach=
ed
> patches and the Kconfig I used. Only tested on n810, no idea if the LCD d=
etection
> hack also works on n800.
>=20
> Anyways, hopefully that will get you going, I don't know when I'll have
> a chance to play with that sfuff again :)

It does boot now, using the config you sent.

When it boots, and is waiting for the root device (which doesn't exist), I =
see=20
messages about every 5 seconds like this:

lcd_mipid spi1.1: performing LCD ESD recovery

> I also pushed the earlier changes for retu wdt to the cbus branch so the
> boards keep running by default.

Excellent.


I appreciate your work (and others here).  I am hoping to run Debian, with=
=20
mainline Linux, on the n810 someday and wish I was able to contribute more=
=20
myself, though that isn't possible now with almost no knowledge of C and no=
t=20
enough time to learn.  So for now I just try to keep up with it somewhat an=
d=20
note here when things don't work in case someone who can fix it is unaware.

--FilwpOHBrTVNlmJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrlyYgACgkQ682C+dBP+oTpeACgt3ynXdRdINFnG+Sbhe4QM4La
zG4AoKkn9LwBC7EwrRhdjPC3Lt99Ckks
=pZBt
-----END PGP SIGNATURE-----

--FilwpOHBrTVNlmJ3--
