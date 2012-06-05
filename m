From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Broken builds
Date: Tue, 05 Jun 2012 16:20:00 +0300
Message-ID: <1338902400.1952.19.camel@lappyti>
References: <20120603180122.GA23368@n2100.arm.linux.org.uk>
	 <20120605082218.GL12766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-N31gBf83cFtpK6jRj9l+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:34836 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756895Ab2FENUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 09:20:08 -0400
Received: by lbom4 with SMTP id m4so4892783lbo.30
        for <linux-omap@vger.kernel.org>; Tue, 05 Jun 2012 06:20:05 -0700 (PDT)
In-Reply-To: <20120605082218.GL12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org


--=-N31gBf83cFtpK6jRj9l+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2012-06-05 at 01:22 -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120603 11:05]:
> > Looks like the DSS stuff has broken OMAP builds again during this
> > merge window:
> >=20
> > drivers/video/omap2/dss/core.c:197: error: static declaration of 'dss_d=
ebugfs_create_file' follows non-static declaration
> > drivers/video/omap2/dss/dss.h:166: error: previous declaration of 'dss_=
debugfs_create_file' was here
> >=20
> > Both the OMAP3 and OMAP4 builds break with these two errors.
>=20
> Here's a patch for Tomi to fix this one.

I have a patch for this in my for-rc branch. It just missed the main
merge. I'll send this and a few other fixes today for the next rc.

Btw, it compiles if you have debugfs and DSS_DEBUG_SUPPORT enabled.
That's why I didn't notice it until too late.

 Tomi


--=-N31gBf83cFtpK6jRj9l+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPzgeAAAoJEPo9qoy8lh71FvcP/2ICRfjquXSO7SA8Sx+A8ui5
0zzpO8Dm+jQJdPWTamEha+FgBrlLERwHsm5587SrWgnRVlUbmwJXasTG4I8Dtdpn
xAAH4joeOHEL32Ji5sQLS57cNRQLzpAiKr7MzSlOf2p/+CMjvgNna7MJhgM3I4Uy
3hmr+HT5rT5I9uqmYLukj9eV+btqYk2Q1TlF5Y7mYhjaLCEGsqyhIKLkosz3VnY+
8Ru/QST9uok9jRai67uk6EkbSOeSh02yrffOhHnygWyiJtIOhOaHLsPEqITr4GVj
rQe79Pflp4qn4i2MXxNP1LaNEGlPtjFtmAvDNoWMs3xyt0DC4nHxxtc0r/n//pkV
vZUpWkcrxm9UOI7OhH2FW95amEI0/khsAPNv0j6IzuPSAKy8jzpt4Ok/ATOyVN4A
0PAWNiivW8irOj+TZu4E5x7JZOprTYWiPSBojUUb+PHzvYOjB8cW5PqBveE+QKr5
G7tPktbY8Nd88pusj69/4oUUEprrgplXntT/RQPcHEIpApSu40puhtYBFeQ1ua80
Zpq2end9Zb/yzvDm+0Yg9hZh95TgaV+MAXA8lcbpHTTF089nuYWw7iI/h2Jx+x/C
TEueOJgdqAly3BTGKfjStkMARgxd8DGdQIWekVjHZjVlTEHsjvPUQmN1sCSBIW2x
niOtVRTKCsg91cUtGiuA
=IGsj
-----END PGP SIGNATURE-----

--=-N31gBf83cFtpK6jRj9l+--

