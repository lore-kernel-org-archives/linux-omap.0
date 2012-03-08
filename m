From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 7/7] OMAPDSS: HDMI: hot plug detect fix
Date: Thu, 08 Mar 2012 09:35:13 +0200
Message-ID: <1331192113.2354.2.camel@deskari>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
	 <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
	 <20120307200146.GA26451@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-47GyESRNkLQyfoZ6aJKS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:57940 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752918Ab2CHHfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 02:35:18 -0500
Received: by mail-lb0-f182.google.com with SMTP id i15so34918lbo.41
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 23:35:16 -0800 (PST)
In-Reply-To: <20120307200146.GA26451@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>


--=-47GyESRNkLQyfoZ6aJKS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-07 at 12:01 -0800, Greg KH wrote:
> On Thu, Mar 01, 2012 at 02:26:35PM +0200, Tomi Valkeinen wrote:
> > From: Rob Clark <rob@ti.com>
> >=20
> > The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
> > over to using a GPIO for plug detect.  Unfortunately the ->detect()
> > method was not also updated, causing HDMI to no longer work for the
> > omapdrm driver (because it would actually check if a connection was
> > detected before attempting to enable display).
> >=20
> > Signed-off-by: Rob Clark <rob@ti.com>
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> You forgot to tell me what the git commit id is for this patch (it's
> ca888a7958b3d808e4efd08ceff88913f4212c69, right?)

Yes, that's the one. It wasn't in Linus's tree yet, only in fbdev tree,
so I wasn't sure what the commit id is.

> And why isn't this needed for the 3.0 kernel as well?

The detect() function is not present in 3.0, so there was nothing to
break.

 Tomi


--=-47GyESRNkLQyfoZ6aJKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWGEsAAoJEPo9qoy8lh713f0P/j28phkOXxhI6rd2+wozIyn1
mgttyIcfb5QLlEbPVowk7ycOOhJowW597wBxxPq1jCsb/Y9WssFIGRG2AKdtX4sy
RpDBHjeNjEUsWWOOn0rCYO9X/nbGpZAu5KCyFb05VkdQEQ/cAVXBrowIpRMawynr
tWJjlE8yugxdMD29uvKqXTx43YXEM9dqEoC2yGaN/dnEhV26sY82Dfec9c2Tdd5T
ZEDyBSe+GPGsIjQXjC8Yc6SGtKHMIHd5OcsUjOQ7iqQ4SXjLw+fT/2gsCzp+34HN
e1pU9QA2sk2wqYMnA96kzgp8rebkjbBC4C53G6iVj1YQYDNGDYPTs7+4mdh0yTX0
eJo9PTirTFVjRcS/ivakKyEQNOPvdjBeJvsC8hCswbovSmcp3SaGwPc+2nwfPrkV
kbJbpNwJtf0SwCZJF2RllzGg+YW6XEFuBmDvGVqcVqJEa30E4rOuK1lXh/4B0nYM
5ypygoMGUm9XUsQ1yBqFAtdWLDKonimW6nY7sTaVlspQ5QiSqqxCLzLbS3F/7BPY
YAO93eRdF2I8gSXHJKToeetP0zv/ctcvFskji00oTPGGMfcdzgUQmFaGe7O0Waa3
jtDdU6DS2XPemDZTCGqAMShGdgxc1zSSvFFv4JDph83HJdDG4oG3d2L0M2JLyNmg
VcB6kXadaYan/46PyNcL
=9M1F
-----END PGP SIGNATURE-----

--=-47GyESRNkLQyfoZ6aJKS--

