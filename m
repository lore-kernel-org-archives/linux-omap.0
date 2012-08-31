From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 03/23] OMAPDSS: output: Add set/unset device ops for
 omap_dss_output
Date: Fri, 31 Aug 2012 15:28:48 +0300
Message-ID: <1346416128.16067.13.camel@deskari>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	  <1346326845-16583-1-git-send-email-archit@ti.com>
	  <1346326845-16583-4-git-send-email-archit@ti.com>
	 <1346414621.18766.13.camel@lappyti> <5040ACE1.8080502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CLH7nJJ00xvoUBAqNhno"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46846 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752381Ab2HaM26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 08:28:58 -0400
Received: by lbbgj3 with SMTP id gj3so1174275lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 05:28:51 -0700 (PDT)
In-Reply-To: <5040ACE1.8080502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-CLH7nJJ00xvoUBAqNhno
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-31 at 17:54 +0530, Archit Taneja wrote:
> On Friday 31 August 2012 05:33 PM, Tomi Valkeinen wrote:

> > I don't think there's need for this indirection. We should use function
> > pointers only when the func pointer may lead to different functions.
> > Here we'll always have just one function, dss_output_set_device. We can
> > as well call the function directly.
>=20
> Okay. I understand that. But in general, don't func pointers prevent us=
=20
> from exporting more symbols?

Yes. But I'm not sure if there's any real downside to exporting, as long
as the names are prefixed properly so that there are no name clashes.

> > I know we have similar func pointers for ovls/mgrs currently, but I
> > don't think they are good either. They are a relic from the time we
> > supported "virtual" overlays and managers, and thus could have differen=
t
> > implementations for the operations.
>=20
> Oh okay, I guess you mean the L4/sDMA updates for DSI command mode.

Yep.

 Tomi


--=-CLH7nJJ00xvoUBAqNhno
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQK4BAAoJEPo9qoy8lh71b9AP/2dyzN2YB/q+FT1m6HFSJ0yz
AukO+ZG6OvSpFFSjPgZgpY0T2Vhupdtry5348HevY8p3N9RHIiDIMUT+6rqxNLZe
WPbb2TEfWzLoxLt/LWYB4WatMc9Eadz0MEIFuVmreNiB1djhYZf7kb8lKbw4sn49
x9AImdqWZ6SVQuzKxFxQO0L6VL4wkmmTyDcCi09a9kFq8CdvG6CkFp5A8Lguyax4
hXIFZAWe+0qIYFYS41eSBXN4NFtoGC4tISAAi2wfGkqisDu5xsHaCCBYQbEOPV/0
bWGpMF3mTsdt1Q0iIYMJhnIg2XOeFj0qihYaB7Z1sCOtomKJkWz5YPwX7cK8afF2
Z/O1qD/Rl03fEVmmhGi1fZPASRl5VtF+0bVBloWudJ+Lu5Lo4AJmnZ77W8wrNYWX
1jjzA2lkfHq80fF4xIYDc6lgIfAl0aE74YHqTsh/9U1OXVxLS4qjkvtXfLGMKsN8
CournSBbxEQzheD0Gy/inuA3xMdvg9ZvZQSK1LTQMKMOep5dykVS969kqEJFgtLp
D71eN5t4fdKF2awaAolal8SIEsPWMsZJ9dSWS1DBtEMezYPZkEdBVCaMJaNT6CgC
cIdWvEfoJ2m3YvEQrv09JolHEXjNFZ/5fng0Jr3mWooNaGHlHMwh4EzKKYvTAayV
3rKqfy3cFVr98ULnkIkk
=y9Zy
-----END PGP SIGNATURE-----

--=-CLH7nJJ00xvoUBAqNhno--

