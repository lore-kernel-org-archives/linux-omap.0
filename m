From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/16] rmk's patch series for fixing OMAP
Date: Thu, 09 Feb 2012 12:24:35 +0200
Message-ID: <1328783075.1909.44.camel@deskari>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
	 <4F32DBB5.4010004@gmx.de>  <20120209005334.GG25414@n2100.arm.linux.org.uk>
	 <1328770969.1909.11.camel@deskari>  <1328776220.12747.5.camel@lws-gamez>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-a6NjbueeR9aAlqe0l7uS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42209 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757797Ab2BIKYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 05:24:39 -0500
In-Reply-To: <1328776220.12747.5.camel@lws-gamez>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Teresa Gamez <T.Gamez@phytec.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, linux-fbdev@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>


--=-a6NjbueeR9aAlqe0l7uS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-02-09 at 09:30 +0100, Teresa Gamez wrote:
> Am Donnerstag, den 09.02.2012, 09:02 +0200 schrieb Tomi Valkeinen:

> > The problem is present in all kernels where we have the HDMI driver, so
> > 2.6.39+.
>=20
> Are there already backported patches out there for 3.0/3.1?
> We are quite interested in this.

I pushed three branches to git://gitorious.org/linux-omap-dss2/linux.git

fixes/for-3.0-stable
fixes/for-3.1-stable
fixes/for-3.2-stable

Which contain the necessary backported patches for each version.

 Tomi


--=-a6NjbueeR9aAlqe0l7uS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPM57jAAoJEPo9qoy8lh71Q+YP+QGiLpSnbmhKwjfu9Q1XshTX
tAg2iQVHtiKJM61dTemLO91ulhNlPhMzO8SeWhNz8EiVQzsHynaD7dxvZhLj6Vy6
moFulF68ayu8Wb18WWsFgeMiRwEMtvBo5CGqrah35fzzCOUEoEQt0XVzfz/q9Xep
9FhMgYyJ4wv34Na6YzhMC7qXgA02iITiVYtMK1/NZwAlBxJVuHJoWxn/S6WcbIB+
vGXIpC83cjj/51eq9LSOa+/5MRHna+T2frFklw41sCnUWn2zXVy+pyJ4A0ZcVd8H
UmVG2tQWcMUdhHVCoj6GBoBImYqS//6uNS4bcbhxzNzEO3faY+mWZwcCBfBEXjrP
yfN+K+vRO87KdZ1ggGq6WdEVVjy2/j0NzSCMgmGADk+HP5SU4/q7607VkHwC687P
XCs8lrjc33y2uVDAM8zaPGy9mxOv1XzUAHTyuLawxsy7XpeXIg83WiObD2vKxCGh
KT685ioywrz1p+CToa+79/pBfIj5aasLw6AGjuwLg8ok2DlVH9hjPO0XIoxSHFKY
XRlPiGvUWQv0HKpaysYcLs9ksNzRvwF4es6Nnt4HdVBgi2U9Uje9ekq+ocA1i/t0
OjFxf2m69UBPxPZH6iK5FWQva37r80k21G5QXFbkQcrp9/e5/VbUqdftZ93tTtFA
lT9sOM+DsVT2G/rR0B6A
=dSzd
-----END PGP SIGNATURE-----

--=-a6NjbueeR9aAlqe0l7uS--

