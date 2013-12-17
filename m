From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 01/27] ARM: OMAP: remove DSS DT hack
Date: Tue, 17 Dec 2013 08:45:48 +0200
Message-ID: <52AFF31C.6010100@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com> <20131216184157.GA26293@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="L7tc5BHMFuONgTjmDO199RGA3ssmT0f0c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38611 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab3LQGpv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 01:45:51 -0500
In-Reply-To: <20131216184157.GA26293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--L7tc5BHMFuONgTjmDO199RGA3ssmT0f0c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-16 20:41, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
>> As a temporary solution to enable DSS for selected boards when booting=

>> with DT, a hack was added to board-generic.c in
>> 63d5fc0c2f748e20f38a0a0ec1c8494bddf5c288 (OMAP: board-generic: enable
>> DSS for panda & sdp boards).
>>
>> We're now adding proper DT support, so the hack can be removed.
>=20
> I guess this patch should be merged later on after we have the DT suppo=
rt
> working?

I'll move this patch also to the end of the series.

"Merged later" sounds like you mean this could be merged in a separate
series. I think this and the other removal can be in this series, they
just need to be at the end.

 Tomi



--L7tc5BHMFuONgTjmDO199RGA3ssmT0f0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSr/McAAoJEPo9qoy8lh71SyYQAIWE90zT9o1FErOK/zLFdxhP
cIIGy5B7zR6ec+D4KTAqNU7qwx/ZtVGr0LoRZz4wA1D05SoKC0Www48Ds01bKDPs
Q/T3rVCRkFfPbWwGUBJp3xnftIU6gkFr7PsKRSfRRMW+sFYX8zA9EQHHMVEMhfpG
qIUkMuJilgJ6e4UAOmKYPLkkwqwe7lEaggyxp5r7LJg6NZ3b3q3E8987SCfV5MH8
u1LLL35sorg596cBJL72z+l8OG9caeY21fCy64wN+QDD539yiHYkQBwzaAXTfrkG
O2U0b7IKg9jbrX+GLKWE9BffkVMKlXulRqu2Ux9pzTC/kNsVhHdZC0CPIHiCJ+SW
gsezirnD5v7cEWDb50PX13bBEJqnaVENzMpksobV5Eyge2WQMr4Ajx9PDgSfyI74
MKRsu9KSRj8LrzJ/Qw+z2KDSqf0NmLM48PHrGRBV9Am7ZS24LZb3J9AdGMtwsqwL
GzsasN85O2n/9/AKPl0HIbbP3OdDdhalEUJiDVAnk/IM7/qix0HWtdi+s2BYEGSW
mOMXpjWj9y0NAl0CXwI/7DDC7km9jjlLoFmphiHXAERolz2CSReWMmBkDkfCfa0G
D2hE3GqyZxrii90oeCHjcHPVq8UN5qBV3AyjRu06Azie5suOdqpJ/N2m/ewi0Mwk
l/HRigoG2GeqxjvFLsrl
=qZpj
-----END PGP SIGNATURE-----

--L7tc5BHMFuONgTjmDO199RGA3ssmT0f0c--
