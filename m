From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Fri, 24 Jan 2014 12:35:30 +0200
Message-ID: <52E241F2.2040103@ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com> <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com> <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com> <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com> <52CE5123.9050702@gmail.com> <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com> <52D146E8.4090105@gmail.com> <52E0333F.4000400@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vhVGecjX8RAjmRcrLhAt5bK5GsQt5KrOT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbaAXKgA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 05:36:00 -0500
In-Reply-To: <52E0333F.4000400@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

--vhVGecjX8RAjmRcrLhAt5bK5GsQt5KrOT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-22 23:08, Ivaylo Dimitrov wrote:
> Hmm, maybe this https://lkml.org/lkml/2014/1/22/386 will solve our issu=
es

I don't know, it wasn't immediately clear to me if the reserved memory
was handled with CMA or not.

Also, we have this funniness that omapfb is not present in DT data, so
we can't give reserved memory to omapfb directly like that.

 Tomi



--vhVGecjX8RAjmRcrLhAt5bK5GsQt5KrOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS4kH2AAoJEPo9qoy8lh71HwUP/1m3rgiW+mpWfVsPVvkhGDZJ
X5t62Sg8Y8k14tgjRoKU5TtCMcAHS5ol/PMlF/9F25H+txJI4xA0o0a9KNLUn0og
qmxqoTmmToA49R9dzKkrs9mh09htr0x4dVGRdh8gIyYiardzoM10/b4UGt8goJqU
HWW02gKaVRPahjGKU19P8dmSOykhcafPHEYY5m0MihlaFTKwGP2HCiwLDorE8UCM
zEre638vANjX6UR44MxkDHKB2BsmSnXkLhqwGUMCldPO2qF4th2SwCH6vFhl9XT4
+f11CsN9N+Q3plTy1jBGlGWVf1d5bzDDurzNebvVKuRQLG7yc9u0LIjISXyFXvy7
kmvmTw1RvEALb1vpA7mI5nUxVkeTj41RP8svAR6QGCx0UYETeJAbIxoEQ/jNlKPQ
HV1f54kRlySk9uCpo0guUu6/mHnxbzpvfrOz2ErVF7B0TDsmHPJ56Ehg+8jhYY65
xDfnwbuf8RxNX+D22FMpbLTBbfkZ2DnVFGdQw7eRqPFp0gYdkLXfX+O/pO65uFk/
0fCuGwewMvhgk8E9NNlkDfOfSg2eCEiat7CAschpmUpIBwAVo5lDGyVfD34Ec2Ir
zGRsEPyYBYfiA4nk7Q6LuqWCmT9v2CtU08ng7cLApaKfH8XPBTvKcLc9vHkZr3te
uneVB4qdOGwM6yS4rYWC
=cE1l
-----END PGP SIGNATURE-----

--vhVGecjX8RAjmRcrLhAt5bK5GsQt5KrOT--
