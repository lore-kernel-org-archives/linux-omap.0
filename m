From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
Date: Wed, 9 Oct 2013 16:39:39 +0300
Message-ID: <52555C9B.20607@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com> <5255587F.5010601@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="RI4KUeocd97knSwpX8tHJ8XafvRjtKkXD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33789 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab3JINkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 09:40:03 -0400
In-Reply-To: <5255587F.5010601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>

--RI4KUeocd97knSwpX8tHJ8XafvRjtKkXD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/10/13 16:22, Tero Kristo wrote:
> On 10/09/2013 04:12 PM, Tomi Valkeinen wrote:
>> Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk ca=
n
>> be configured without the need to get the parent of the fclk.
>=20
> I wouldn't touch this file right now, as we are trying to move the cloc=
k
> data over to DT. Legacy boot support probably requires to do this
> update, but I would rather wait a bit and do the modifications to both
> DT clock data and this file in the same patch. Same applies for other
> patches also.

Sounds good. I don't have any particular wishes how this is done, but
I'd really like these to go into 3.13.

The fclk handling in omapdss is quite a mess, and these flags would make
it possible to clean it up. And the reason it's important to clean up
the fclk handling ASAP is AM43xx, which has yet another clocking scheme.

If these get only to 3.14, then I can fix the fclk handling only on 3.15.=


 Tomi



--RI4KUeocd97knSwpX8tHJ8XafvRjtKkXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVVybAAoJEPo9qoy8lh71YxMP/i5bSnp6c1bACCz/ZJ0JyYRW
mbgfK0torcdf/4crsEX0LiC7kSSjbxWShsEOrHoHitpwHWOwHJaA4k7HfC2twKl5
og3+6nn12gLj0hY24bQUqIB3k/SAA7uRkNbmY5d1jtsjLb5r+JVnRUj9EiQX2Tgd
cPrxVYHgpgHoMpapcmuRTO0lnn49Bx/+ExshB0AkGwCwqnla4NfQWSSTByvd1zuF
BcDc9Sc0GEQ5qi0KS3QG5EOxxqPo9QhKdAoJzaS1U/GpaZ0chNGfS0fl8ywm01T6
5cznBBN5SCWfQ1BGJislzfSvhcm9m9NuQ3MMYEoKJEqJ4xCPYp+YsZYe+Hg/VZ8W
PWpckGbnlhZm0hmW7B/VVQG8YCjOmemGmGFVVZ+aTyD5uUU/qgMjd7FRYZ0SWcR8
KacO8cRvqchK4O/8sceoc3fVsbsGKpIjOh2rzJWoou0hnQweqeFU2RD+PV0kLz8l
JhQm5mG4SIl4BQaTlecsPvU1apbU3JPB9Ib5pNmDygd+D3I8XhizahBNQ+crDka7
Lo8kew1TpFH5iFZWbB4AelNn3mrdKTGmmKmltw29k+GRY7QsJKQZQSK3YlIx3Hmh
Rh0G0x951uBmKtX3WmJ+9GtFlDbdKUb6MpaV1wG1c1jm9xRiZ8Sg2pdyHSyJCHE3
q6EMcAKcGwdSMw2OYLhg
=aFaC
-----END PGP SIGNATURE-----

--RI4KUeocd97knSwpX8tHJ8XafvRjtKkXD--
