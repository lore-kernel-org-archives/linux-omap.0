From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: use devm_clk_get()
Date: Wed, 10 Apr 2013 12:32:06 +0300
Message-ID: <51653196.6050304@ti.com>
References: <1365411346-30611-1-git-send-email-archit@ti.com> <51651F25.3020302@ti.com> <516524B8.60205@ti.com> <51652EA4.9010606@ti.com> <516530B1.80203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE3F0C2176BEB9A1AF3E02900"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59137 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab3DJJcI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 05:32:08 -0400
In-Reply-To: <516530B1.80203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigE3F0C2176BEB9A1AF3E02900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-10 12:28, Archit Taneja wrote:

> Ah ok, I remember it now. One of the DPLL's divider's output is DSS_FCK=
=2E
> We get the parent's rate and iterate through all the possible hsdivider=

> values to get the closest pixel clock. We don't/can't change
> dpll4_m4_clk as such, we just need to know it's rate for our calculatio=
ns.
>=20
> So yes, we need dpll4_m4_clk, we just need to rename it to a better
> thing. Like dss_clk_parent.

Right. And the field name in struct dss_features, "clk_name" is rather
vague.

At some point we should fix the omap clk framework so that we can set
the dss fck directly. Presuming there's no good reason to have it as it
is now.

I'll apply the patch as it is now.

 Tomi



--------------enigE3F0C2176BEB9A1AF3E02900
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRZTGWAAoJEPo9qoy8lh71Q7gP/A+QS74CR3OezWoZtrf2lh5m
753Cv0d+q/vs8D3HJfTn+f3uXhHrRSe9J+o/+Ijb4S+8iUWZeXDMS6tXvN/ybM+s
uL8pEM52sTj58nfMVB2CGQdMBpgrcufbJshLzfZbz159e8E2ScvLBsWmIAymZNB2
TTjyVSceG8WEOWZNEtIg+inBtFXfue29A56Caq2pC04/9UbH6OkHop5bcO4HkeKT
Tadj2x+TQdcbEcuB8Hg7TqpUghXIlAku0E/HhSDTE0IGzUlYtQFO1/2Ha/38nP//
h+vKZ/8g88JJJT4Jzympol146WhxCj65zkShbvWeg9pwz+ZqKbVjPBxzTkjHGRfL
6/z0cLlsOokd43cAaOuF6ueACwuLpQNB0DfOT7mMi6Vhw0aig/x6gpdfNyuwyFun
tB81sEOLojl2UCYN/KKaB/0dvALLj1jnRdE/P73y2tcN/KSh9xFDwF+29g7adNkN
KIX/AUHZvBxSi4ak5JH9t9fGSPpsT43khQJrYF4IMwjElKZIGQXvpuZ3tiigT7vc
HvephB8wSdAyf+QlPWVBEOSv4lcUdoyr5pQ31IO3KEqu9uCr/EtEPkjTCPOtXG1R
DdBZ6pizoyhBDfSwqQh7eAZyVLJ69yXSg1fxgJOWxEztdFPn3NGlEs8CX4JUVcuP
VIgnK2hjlPFUGsthcvjA
=PXqh
-----END PGP SIGNATURE-----

--------------enigE3F0C2176BEB9A1AF3E02900--
