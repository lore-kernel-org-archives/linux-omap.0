From: Sebastian Reichel <sre@kernel.org>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Tue, 7 Apr 2015 05:12:33 +0200
Message-ID: <20150407031233.GA16189@earth>
References: <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
 <20150407022312.GK18048@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34373 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbbDGDNE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2015 23:13:04 -0400
Content-Disposition: inline
In-Reply-To: <20150407022312.GK18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Apr 06, 2015 at 07:23:13PM -0700, Tony Lindgren wrote:
> I'm now thinking the kernel should just always set the 430973 specific
> cpu_v7_switch_mm for all cortex-a8 if IBE bit is set. That avoids
> the whole mess of early SoC detection and smc calls. And if IBE bit
> is not set, then we just use the regular cpu_v7_switch_mm.
>
> This will work as long as we can read the aux ctrl register IBE
> bit using mrc, which I believe is the case for all cortex-a8 based
> omap variants.

If I understood it correctly we can simply call the BTB flush on
cortex-a8 if IBE bit is not set, since it would be translated as
nop.

So it should be safe to include the call on all cortex-a8 based
cpus. We may need a non-BTB-flushing function for non-cortex-a8
based cpus, though.

-- Sebastian

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVI0seAAoJENju1/PIO/qa8NAP/iPMTvtOPWt4zTWItMZIJDKA
1kjwMMAm+lqDd9s68ZXkKIseQqHSqFVm+UonLoQ4yQ7pyUs7MjY+ld/XXAH+FFpY
4OIIgjdstUP6hKd1qnyZBcoVb/+QCxDVbJjxSaHrKgGI47x8LzGcZ/4kdMceIaOw
PuQB9V3wbjQBbPMv49euzpQU95dUYhajzEhkIqqDufEurlmbdFdcgalvzXmdICAS
2+RgCoF7IwRB97EBjZ0g/i5HvRDY3hb/kdyWHcEDXdnA4c1YnqU/5XGU8KixUizW
iM6sd9JxXBQT1QG7M4JYbVCK12TYrRw4aBc3bDLWKw7y3btyDQSW7InVdkmJFmAz
wyj9jX/z4uhkReAECwlZ0sm7MDxIMQn3dSU5CPggmdtqDPZ4cMfWPIDAiTm+1Mse
lMjFrqwNYj5qX3iiArf6olHp7t76D/eB6N6HqyNjrsHaHuJzzhFp6wJfOmfMODUN
rOrKHTLP8UpdEI805VvyWTRGbT3GIWX376dRi45UMbOmJFy7HpZxrIKs2yN1vsPV
2ltArHarV77fbGd5YUuSC/C6trOQ/x4fBrxV+fyMuNH5w+UYLrhmKEwFZXzQ+QqC
Aad1f5h6PpTQsOD1wMzkzMezOikfw4hFY8JHWvYVNjfWn4azeVzmajK83qDUnGc7
kuvGIHu2Bk8B1HdT8ton
=SGFU
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
