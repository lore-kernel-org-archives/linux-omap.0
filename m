From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 16:13:04 +0200
Message-ID: <52A9C470.2030102@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-7-git-send-email-tomi.valkeinen@ti.com> <37483030.ghHfzYFSnL@avalon> <10507960.9DXH4TSv2E@avalon> <52A968BD.20304@ti.com> <20131212100527.GA860@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9eflo8GpQg0DWHutV7tPBHWoAS2nVieqR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57458 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3LLONM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 09:13:12 -0500
In-Reply-To: <20131212100527.GA860@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--9eflo8GpQg0DWHutV7tPBHWoAS2nVieqR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 12:05, Sebastian Reichel wrote:
> On Thu, Dec 12, 2013 at 09:41:49AM +0200, Tomi Valkeinen wrote:
>>> A label property is still an option.
>>
>> Hmm, what do you mean? Label as in:
>>
>> foo : node {
>> };
>>
>> Isn't that 'foo' label only visible in DT itself, as a shortcut?
>=20
> Some driver use a "label" property like this:
>=20
> foo : node {
>     label =3D "lcd";
>=20
>     ...
> };
>=20
> See for example
>=20
> Documentation/devicetree/bindings/leds/common.txt
> Documentation/devicetree/bindings/mtd/partition.txt

Ah, I see. That kind of label was actually the first thing I did when
starting to work on DSS DT. But I removed it, as it didn't describe the
hardware and I didn't see others using anything similar.

But I guess one could argue it does describe hardware, not in electrical
level but in conceptual level.

The question is, do we need labeling for displays? For backward
compatibility omapdss would need it, but in general? I'm quite content
with having just display0, display1 etc. Using the alias node, those can
be fixed and display0 is always the same display.

 Tomi



--9eflo8GpQg0DWHutV7tPBHWoAS2nVieqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqcRwAAoJEPo9qoy8lh71nd0P/2xR9bJ5wE+6P5Yzn2QdncQY
jy28lMkwlC8OmXx89BIVlkVoMVi22rqUbMIrvDOc3yNDD7D3F5C1cE8yxmQD6gAW
WpNNfvS3MR+ywNIDlxVOzKFsikNCe/acNJls+0NLWrG2/nDbGQGY23gj35wteeoH
it7mWGrdkSM7kSo7TyAUEuW3ybbPbNOtYZk45I0kkqKZVPIL7ptXx5bswh/TWqeo
/8nKaiA6+y3HcWemyAXUVQA+lpN0WtsnjH+7YdUg8PBKnftnYzSQkX+VABYR2fl7
yTBNWhtQZhy4aYUqE+DV80wCOcVUzak38UElAbTcbcc/yAVIGJkaPfHlTAL4n3SE
07P4eemqhGLBix1RXx6IO2C6+i+XbIyEGdFaMXI82Li9CTUhmgdnBRDNANnrnhPj
6K6MGqqedTq3t0UGm5F4qHHffLWlhQnyXrVizW2fU6TYyM5VD9IqRzQNDUK1AiYt
I2hxwk4p7SQh+XoGQL83UO8z5aOTIiwXjALzJnmFGbykMvxrNMQnnVasnF8duU/E
FrbnsfPcAd7t6CadzwbBJjy5yg8Lu6f2GvlSTgkmFMdbJgsPxYRsPyRHBFUK9daE
K9xj4juVqBxLlXiOZjudPHKl70drbzsAlzfw1lZdDMc9fxC/H2rNJp7SwSKVf9CV
119QPKSOBnKqRpWGMgu2
=Uhgw
-----END PGP SIGNATURE-----

--9eflo8GpQg0DWHutV7tPBHWoAS2nVieqR--
