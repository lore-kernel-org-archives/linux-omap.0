From: Felipe Balbi <balbi@ti.com>
Subject: Re: am3517: failed to boot 3.10-rc1
Date: Tue, 14 May 2013 15:52:16 +0300
Message-ID: <20130514125216.GE21107@arwen.pp.htv.fi>
References: <519202DC.10100@visionsystems.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44082 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756770Ab3ENMwi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 May 2013 08:52:38 -0400
Content-Disposition: inline
In-Reply-To: <519202DC.10100@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>, Maxim Podbereznyy <lisarden@gmail.com>

--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2013 at 11:24:44AM +0200, Yegor Yefremov wrote:
> Trying to boot 3.10-rc1 on an am3515 based board. With the same
> .config as 3.7 the system comes to RTC stops there. I've also tried
> make omap2plus_defconfig with no visible difference. I'm booting from
> MMC card and it will be detected by the system. Kernel is from
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git, latest
> commit f722406faae2d073cc1d01063d1123c35425939e. Are there any pending
> patches needed to boot on am3517?

does v3.9 work ? Can you bisect ?

--=20
balbi

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRkjOAAAoJEIaOsuA1yqREQ6YQAIWKVc7jK1ezJp+WbF4zGoYr
gOGvugVhUZibNleO6gwWqRJv9j6rGRUYfKfJNPQNhtWzX5sKVgCUMnRLbqJdPegL
u9rxj/go25DCc9f5tWV8Bnbresv8y3Vr0xobZoQ96iPlMLcy3jqYfFEjkh5+1/VG
a5g0C+XaAzHD/D1L+kzS3VgZhzZYOpJ29iuXINmIHanzR8lCyHIkyMDfYRfTP+zG
kWUJGF3H4sYTsTHQbMq8FoW3REb/leCRlYB7YfUb5VnSkMiEZpSU2bFrfv2/0uPD
6YcDHuctZvfUlhnnE0wEpddEw5jC/But+3syIhf1cZOCrznS1SP0CkV4k04I5mW/
67EIxPWb3BQ+YDemH9YSXXh4c3dNdcQTm2v16+XXZWIwDVpOCdIyShPG1psWBY8W
1gtFx2oWIcZohg2zAoDgjiz+YyUr0oSCo8jJi121u/lgq+tp8yVvK+2045hDNQo1
+Jf+1CPU5VDAf9jayLSKM5DAI6/aBUCg/dxqYfnnh/sJHUY5tVDot7sG7rLJ0/xJ
5qfGDAPHnSzHmh2aro9p+aUXtjlI422VPvVHXz1XkeYqsFsj2R8mEDNo9R8GUCGV
zIPrnAre1x5k9d2bR/4vDQJQouuj8mMf/8qP+SuJbhPKxnEkkASOIRTL4NibSmQi
aQ7PW3L88fsBjGY1EEIt
=RClQ
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
