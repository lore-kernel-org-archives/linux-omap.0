From: Maxime Petazzoni <mpetazzoni@mvista.com>
Subject: Re: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Tue, 1 Sep 2009 09:12:13 +0200
Message-ID: <20090901071212.GA4397@mvista.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
 <20090827140617.GA30917@mvista.com>
 <ce9ab5790909010004y67d3b29nf6ddc4532d390aef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:36513 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZIAHMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 03:12:18 -0400
Content-Disposition: inline
In-Reply-To: <ce9ab5790909010004y67d3b29nf6ddc4532d390aef@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rix, Tom" <trix@ti.com>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

* vimal singh <vimal.newwork@gmail.com> [2009-09-01 12:34:26]:

> > Yes, I am aware of the mtdparts command line arguments, which works
> > great. I think a "default", sensible partition layout for the Zoom2
> > would be nice though.
> 
> I agree. Keeping it in the mind that mtdparts command line arguments
> will be given higher precedence anyway...

Exactly. I would recommend that your patch gets merged in. Although I'm
a bit curious of the rationale behind a 30M kernel partition?

Also, given a 512MB NAND, we could easily affect 256MB or more to the
system partition (as well as a bit more space for the userdata
partition).

But that's just nitpicking. As we said, mtdparts can be used to take
precedence over the default settings if they don't match the
user/system's needs.

- Maxime
-- 
Maxime Petazzoni
Linux kernel & software dev
MontaVista Software, Inc

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqcyUwACgkQ7KsOe4Pmrg2f6gCgud9CxFOL+XwnyN5Ye86EsJG/
ulkAoKoQCRLmMh6UFFKKJwZdNgCDYD0Y
=xJXf
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
