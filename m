From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Broken builds
Date: Mon, 11 Jun 2012 19:59:44 +0300
Message-ID: <1339433984.26639.26.camel@deskari>
References: <20120603180122.GA23368@n2100.arm.linux.org.uk>
	 <20120605082218.GL12766@atomide.com> <1338902400.1952.19.camel@lappyti>
	 <20120611160616.GA9268@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-lTGN05PUHlz3XMgv7ZES"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:47174 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891Ab2FKQ7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 12:59:49 -0400
Received: by lagv3 with SMTP id v3so2910855lag.3
        for <linux-omap@vger.kernel.org>; Mon, 11 Jun 2012 09:59:47 -0700 (PDT)
In-Reply-To: <20120611160616.GA9268@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


--=-lTGN05PUHlz3XMgv7ZES
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-11 at 17:06 +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 05, 2012 at 04:20:00PM +0300, Tomi Valkeinen wrote:
> > Hi,
> >=20
> > On Tue, 2012-06-05 at 01:22 -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120603 11:05]:
> > > > Looks like the DSS stuff has broken OMAP builds again during this
> > > > merge window:
> > > >=20
> > > > drivers/video/omap2/dss/core.c:197: error: static declaration of 'd=
ss_debugfs_create_file' follows non-static declaration
> > > > drivers/video/omap2/dss/dss.h:166: error: previous declaration of '=
dss_debugfs_create_file' was here
> > > >=20
> > > > Both the OMAP3 and OMAP4 builds break with these two errors.
> > >=20
> > > Here's a patch for Tomi to fix this one.
> >=20
> > I have a patch for this in my for-rc branch. It just missed the main
> > merge. I'll send this and a few other fixes today for the next rc.
> >=20
> > Btw, it compiles if you have debugfs and DSS_DEBUG_SUPPORT enabled.
> > That's why I didn't notice it until too late.
>=20
> So... where are we with this?  Apparantly not much further forward;
> it seems to be in linux-next but still not in mainline, and mainline
> continues to be broken.

The fixes have been pulled into fbdev tree, but it missed the -rc2.
Fbdev maintainer said "I merged this some days ago. Sorry that I didn't
realize that rc2 would be released early and hence didn't manage to get
it in."

 Tomi


--=-lTGN05PUHlz3XMgv7ZES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP1iQAAAoJEPo9qoy8lh71qlAQAKhz8z9fGPGWKJgu9Rl1leLa
q7azzXhyyeWTSqeQbRT9Zlni5NfxNNsB4xMg2XWsbk0vfBtcNUW6qq2QyXTJZZ0o
+tm+OFZ4EwCGXsBqcBOSwKNs4OhOdlNae53RyDuvYHtLuBzco8fWz7fqJaRJ6MpO
fctVMyjGBo7b5nVA9fWpSQAKlbM+HzdiOR3jZ4+Zxbk3xbhhTqD1irPPiOCoCwhO
eiYszMVDd26UxhiUIPM90NXetATIhSbVCFqFbcFMqKYk/N9PljdLdJWnP+X5Xdmw
JIPeoHhLRoVmbaOMr/QHsUZyLnTg0p/w2jON7z+2HDSEyXWDXODG+dPOahvYBKih
9uRdK//pPH31aT4mu6K1h2HodtK/KCrvlsCpY4NDDYi5mQDYOlvUReO7EZTl/lxH
c/vDMJTBr1yMXiwjTvZy5ODph7tQvhgj4JI7ZeXXSBeKRUFz8CIkZ6+tiSP7kj58
/HAlKBf991vj9pT3nI0Muey1qA3+8W6qUj+c8LeS9ws9vAMiEpS4e79kYgEyCmkW
J7R5p1dli54TZwPnJ0LwWntNh4Ql+FdJbuKDNDAjIr7B/2OVEJaVTM/br1BEhDbP
o16iTDCUqmyhhof2oS+jqxKeOQpCmGlws4KE3cXFXv8UzxQsawwOBDD2MCuhmV58
38AIdWjzg42v2EOZFrEb
=ACYX
-----END PGP SIGNATURE-----

--=-lTGN05PUHlz3XMgv7ZES--

