From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
Date: Fri, 24 Feb 2012 11:49:41 +0000
Message-ID: <20120224114940.GB5450@opensource.wolfsonmicro.com>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42854 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755782Ab2BXLtn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 06:49:43 -0500
Content-Disposition: inline
In-Reply-To: <1330076289.4102.517.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 11:38:09AM +0200, Tero Kristo wrote:
> On Thu, 2012-02-23 at 15:34 +0000, Mark Brown wrote:

> > Since you're using min_uV as the "register value" you probably ought to
> > be returning that as the selector too and supplying a list_voltage()
> > which just passes the selector back in case something tries to use it
> > and gets confused.

> I was thinking at some point about adding a list_voltage for these
> regulators, however I dropped that idea, because the regulators can
> support a range of voltages (from min to max) with some stepping value.
> But... if you propose that the list_voltage would just return the
> current voltage back, wouldn't that also potentially confuse the user
> more, as it can only see the single voltage and nothing else, maybe
> making it to think that the regulator can only support one voltage
> level?

Yes, that'd be completely broken.  You'd need to just return the
selector back which would tell them that they had voltage control in
microvolt steps.

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR3kuAAoJEBus8iNuMP3dHDAP/0hvMVEJwvLh0OyoiMA9YZv2
+/D4XU9poUxUEazqLBDsuOKa4vg8K/a8w9fF7bKMlpE6AMiNJS+PBsAU2f92IhFE
sKNnpQKChqaxaQCYeKPGUBTM2Mnyn+RN2vjK+Wuby46JhmvVRXEJl8t3KM2QKybk
jNEyri3MtoxUop4h//YkBu2Qeh25KHzFuifF3zxQwq68e5rUyphbmxwu10ozfH7D
3/B92oMBV6K4ric8QecmFRycRgaNo9mATJaPVY7LCFsIOw1+xDBxupCXKAPHLN3Z
RQzgdJfR4HE4rKWKpyQ/2Zaiy5PzoEw/HAcvzhol9FfJk32P9VQR3Jf6UA68jSqY
ZPbBnjGb6ESo9S6PT959u8rN5FQ6Z9d/4o1YxpxNTDgfVBqO12BF0FtC5wOd36HB
QKDDZrcBXgZEAqCjecDZaBcM4DOFrcOuNO2Zs20I3BkpeRuI6zSxng1XOuJ25Un2
573nZdZm6oKEKsL9pg2w1Jdqct8QYfBCWjcSt+tHMK4H8vu9fnnGRUjqmZ6md19R
rDwks9kn9K2R/oAa+STfpmWgcX07OEYT2fyCHMgkwM0wUJUpyJiHE/9WWOQAHg7G
Y165lSXe0ZFg0RfTI2DTXjr/Il1oyUbJS+ZXvpd+f42D6TyvDtSHqYLy+DUuhDH1
PeCZrE6Vc+aYQESoR7G6
=/QYA
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
