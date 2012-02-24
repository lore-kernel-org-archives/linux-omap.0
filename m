From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
Date: Fri, 24 Feb 2012 14:50:27 +0000
Message-ID: <20120224145027.GN5450@opensource.wolfsonmicro.com>
References: <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
 <20120224132408.GF5450@opensource.wolfsonmicro.com>
 <1330091765.4102.547.camel@sokoban>
 <20120224140109.GG5450@opensource.wolfsonmicro.com>
 <1330093512.4102.552.camel@sokoban>
 <20120224143415.GL5450@opensource.wolfsonmicro.com>
 <1330094532.4102.555.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fpolVoprVozDR81Y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47117 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753258Ab2BXOua (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 09:50:30 -0500
Content-Disposition: inline
In-Reply-To: <1330094532.4102.555.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>


--fpolVoprVozDR81Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 04:42:12PM +0200, Tero Kristo wrote:
> On Fri, 2012-02-24 at 14:34 +0000, Mark Brown wrote:

> > Ah, so it is - we're fixing things up in the core.  I'd forgotten we did
> > that.

> So, no need to add list_voltage to this, I just fix the return values
> for the get / set and send the new version, am I right?

I guess.  Though actually given that there's no interaction with the
chip itself at all I'm not sure I understand why this is part of the
twl6030 driver rather than being a separate driver for whatever
implements the operations - it's not like the case with the other
regulators where there was some functionality implemented through the
twl6030 driver beyond straight passthrough.

--fpolVoprVozDR81Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR6OtAAoJEBus8iNuMP3dHgkP/0Kcx2iPZ6rEbomSXYN2/NVR
+JcIfdprzXOn2PgXwZs231RCB+agX4nyIt43wSROvMBcERMKrra83v38PaDgS62C
zyCJ5n+6Q5sk2fma0r/zBo5QZQpd/gTpNU7lyozQaJebrCRe0dhUUR45gO/ICt9n
ybT+qRN6jvoNTUESLXDg5+YTmCBfJ2Souf/ZKmw8Z0LO+M/2oZUibVetjagkn3yF
OuDWHq7Ab1qIzjVdNZK7KRyzTyfqgh06pLNt3/zl/pg6IQALhB3OwArhPY0vDSsT
P8Wl9mAzPs4Fqn2onzIg73X7UoF/3giIY97OnJhn5HTqJqBav7K08DzyQU6NahWs
FgvgUZsHy3LFh3tTV4/Mfrf5xPbG8Ns+XsEm0FnKz8Ekv+KvGt17OLbWGpnti73B
kPh9z+y6f5AuATAnFJVqMGzdQTms34caSkHwm3JFYgcsrwCcwEdqf1xlJr4Wd8Xh
p1luB8Wv2tKbZrLut6J5p4WdUoBqYXwB/iq3JM3P5NzFNipkYf7SGQJfZdgq2S5s
o8VscZiUzfwcZSrhnZODOkDpdtEVkh/OKnGMu9xDWaAGLGQ7yz3qYhREJONnaV2f
S2rkzAqrl0e/3M6p4/LhRcVqEmONyXuTwc7J+ufF5LsYJhDATL3YxDgoBQDjH2DZ
M4x9YBknGtVNI2KrM5Gk
=Kfrm
-----END PGP SIGNATURE-----

--fpolVoprVozDR81Y--
