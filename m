From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Tue, 10 Sep 2013 15:19:10 +0300
Message-ID: <522F0E3E.1080001@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="g43r1ppeGpuniXEbE20tx5CWcnNiPoDTT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab3IJMTO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Sep 2013 08:19:14 -0400
In-Reply-To: <522F0CC7.50501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

--g43r1ppeGpuniXEbE20tx5CWcnNiPoDTT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/09/13 15:12, Tero Kristo wrote:

> If it claims it is not locked, it means the DPLL itself is disabled. Yo=
u
> could try clk_enable for the clock before doing clk_set_rate.

Hmm, so is it required to enable the clock before setting the rate? If
so, I think I'm using the clocks wrong in all the places =3D).

 Tomi



--g43r1ppeGpuniXEbE20tx5CWcnNiPoDTT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSLw4+AAoJEPo9qoy8lh71N1UP/Rt1530KDxbUEnxcQ23EwxSL
XyYYiBWa+gapIRPta7z5gBOrr0sKUtDsjYRNrm73BE2u//NnRyIkH41IBD5vqbLW
SXFbmyvUSCPpvXyNtgJOujG1IW7XRf5/oHVxSWp4hMYwnqKu6BFuN4X6a2z4bxAu
573XjvY0+zkbP6lW3FGEkX7WbtRRHl3q1ZK0ez1bZZLb35eChOAOjBtC8MPH+3eQ
0goQ2SfpUeKp+/QvaEUDHpPz6pHAcZs9545lWzXUjLyxjBjRCawSJF2jj3xX3khd
KX8aOGJhoRU6UYceEU212XXfsUzou4QE97wUV2okeOBEM6qnfbjoP7BsByR+ddnc
Kuy2jBj4x8HONiGBO8GbYxQxuZ30h9on+dojNd4WS3kYpIfvigovzaKR/KoXTA98
nFr1EXfDjZfpQdO24KSCZ7Z2bElAX2j8pKYsBKJwq3cPFVT2sXEvdDK5Tih2xZpC
hKhB+wjS7DW/9Ga5BaUUTQd4GujfykXbY+dgnVz2gB/a+BV1O3R2pLIUJufuSC9+
bqI15mT29xRFqw+cBeZEl40HoK+0Ejvhmf/8HWILuXkYr2mj47+98hFuPLuGod6M
l3oP95wpfzFgQvvXBk910rJkzcWmfL5FJPn34uXWLXOix11LfUfyLq+Ag7AVV6w8
89JTAimhjL9PGM+1ZTA+
=aOSJ
-----END PGP SIGNATURE-----

--g43r1ppeGpuniXEbE20tx5CWcnNiPoDTT--
