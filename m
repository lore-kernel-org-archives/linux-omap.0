From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 13:07:05 +0200
Message-ID: <5322E2D9.5000509@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-5-git-send-email-sathyap@ti.com> <20140313174623.GD25870@e106331-lin.cambridge.arm.com> <5321F77E.9000302@ti.com> <20140314091002.GG25870@e106331-lin.cambridge.arm.com> <5322CF02.4060705@ti.com> <20140314101405.GI25870@e106331-lin.cambridge.arm.com> <5322D7A4.4090602@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="L0cs3uBaS6ln5lsMIkm261FTu9qqPpUxH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35474 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbaCNLHP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 07:07:15 -0400
In-Reply-To: <5322D7A4.4090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

--L0cs3uBaS6ln5lsMIkm261FTu9qqPpUxH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/03/14 12:19, Tomi Valkeinen wrote:
> On 14/03/14 12:14, Mark Rutland wrote:
>=20
>> I can't see anything obviously wrong in platform_device_del. Do you ha=
ve
>> a backtrace?
>=20
> Yes, below.
>=20
> I can see at least drivers/usb/dwc3/dwc3-exynos.c doing the exact same =
thing
> I do, so maybe I've got something wrong with the omapdss driver.

Looks to me that the devices created by of_platform_populate() are not
unregisterable in all cases. The address resource created via
of_platform_populate() had NULL res->parent, which causes
release_resource to crash.

I can as well call of_platform_populate() in the platform init code at
boot time, and create the devices there for now.

 Tomi



--L0cs3uBaS6ln5lsMIkm261FTu9qqPpUxH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIuLZAAoJEPo9qoy8lh71B7UP/3BlNlMcr8SJWqno0DukXTsM
hF8Frjxfb/80qknVKoueBI2tVKacebaElSaqMlHP70nU8TLMh3PGSvkCN6XYns/K
v6K0v0GbialJbvngD27TWuJSLn+op5yZEagvuF9XvkMeqTe4cvFxbsVNMfPbxSVl
wauD9QWeklCb/m0k4hyWKgXQox6fwdRClPctM7cwvrt949pkLg8yinb6u2BTBZF2
siXAfkNB75WCMubqucviHbJNNY50kGSpjM7+M8+pH9V5oGdOoGdzdaULsMKllKDV
y6o5yECrc0OLac0+oFNmoTqXXh+AkdSspxvju0JTE5n8IsoLz4Anb9JjoqlrwFdw
F6bVx1YiZgIG21kzQjES3KuStrm4P3J/3kcCxTpeAKFX425qQTkHbBEROfRWhKEN
+V5j1G1MZA4DOnyxw6HZ8eVxJ1z5OCJPdrvEVcdlcR1+ca2LBIw33cAaThb2LSeB
Y9GhqnxRDnCeryC3Jd18i67DURJfl0/ItPbq06IIXbZSDlDH43hcnrNHT5KDvyjF
uYqzqpP7bS0TZwSqmz7nJVGkw2oEWCDNX0/5TjGxKS7euAb0veBJPnzAElA8KGv4
0sxuelmpfYhmzn2qzYLNV/wXrl1ATJtunRTA9yG0pyKH80ETnkkXuMPVUsjVQLJW
RGSr99fv8kxLBAyWKfiy
=Z07S
-----END PGP SIGNATURE-----

--L0cs3uBaS6ln5lsMIkm261FTu9qqPpUxH--
