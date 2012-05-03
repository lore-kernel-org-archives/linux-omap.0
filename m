From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap-usb-host: include <plat/cpu.h>
Date: Thu, 3 May 2012 10:50:44 +0300
Message-ID: <20120503075042.GH20043@arwen.pp.htv.fi>
References: <4FA1467C.8030005@suse.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:34407 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751391Ab2ECHwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:52:12 -0400
Received: by lbgc1 with SMTP id c1so2379095lbg.1
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 00:52:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA1467C.8030005@suse.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-omap@vger.kernel.org, Guillaume GARDET <guillaume.gardet@opensuse.org>


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 02, 2012 at 10:36:44AM -0400, Jeff Mahoney wrote:
> omap-usb-host calls cpu_is_omap3430, which is defined in plat/cpu.h.
>=20
> Reported-by: Guillaume GARDET <guillaume.gardet@opensuse.org>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

this looks right to me, though a driver shouldn't be using cpu_is_***
macros. Still, that patch can come later, this is needed now.

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPojjSAAoJEIaOsuA1yqREhHQQAIKWHpxJ717qy57Jo4yjdMF4
7T0IMiva5v2lsn5p074L4iPOOvpctGuWT9BokwwK61NXH40fBTiybxhV2BySzsPa
6RroFthE7b9kwChtKflMRcrwxijOok0cSD/YdVqUEhdQgKxZy45k4mHYZpt7PA21
/uOuobvdth3gk6G+m21mquYCCGwXFAt/4jcPxKA3+bvMU1Lnf4wGQfPUH2uey9hx
uWZqmEN1F7cRBYzdG76SYQRjdnq9j6XN7l6VrUi/XpgeAELToY80vVIG/FlgVA81
JJTTG8ujgl0RLVDk3X/Q+pKCDkCFPV7iiqh2VofuFAxH4pC4DUCGqF5wdzDuYVe8
hFEX03sgK8+WS3Ozr6Rm4XCyvF0g+4DS7cC5H9j97knl0uE8wVIweWkccWyg1U1C
dlkEvWP8hUN5TRvx2r6lxc0ZRGg8ABqsNoXaRsW+LKsG+kEsM9FKDDHMs15fdT63
hpN/7wUZN68BH0o4fmSmo+pWV+4ufBU7WBAn+dhL3b0oDv0Yov3eepPJ8Di2iKLi
8iYAC0gD/CoFPfg5hBc+/KjRTbBWe3WDNa697jyz5KomlGEvbFYAZk0Ev8v/uen9
mF02sFvGX6UGp+arCVkSErIoZexVpSIFvWpdf+gNGs2dljW7VIJW7DjPklAbdWuD
41LvCAFj2bQpBriYAIGD
=euua
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--
