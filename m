From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers
Date: Wed, 9 Oct 2013 16:33:43 +0300
Message-ID: <52555B37.80407@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com> <1381324359-28825-3-git-send-email-tomi.valkeinen@ti.com> <525558AA.9050906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dqF29lv5L4uww5H3GNdcIn5v1v2V7Xi99"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46587 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab3JINeH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 09:34:07 -0400
In-Reply-To: <525558AA.9050906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>

--dqF29lv5L4uww5H3GNdcIn5v1v2V7Xi99
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/10/13 16:22, Tero Kristo wrote:
> On 10/09/2013 04:12 PM, Tomi Valkeinen wrote:
>> dpll4_m3_ck and dpll4_m4_ck have divider bit fields which are 6 bits
>> wide. However, only values from 1 to 32 are allowed. This means we hav=
e
>> to add a divider tables and list the dividers explicitly.
>>
>> I believe the same issue is there for other dpll4_mx_ck clocks, but as=

>> I'm not familiar with them, I didn't touch them.
>=20
> I think you can limit the max value with a mask only, no need to define=

> new tables.

The bit field is 6 bits wide, so the mask is correct. It's just that the
biggest allowed value is 32, which takes 6 bits, not 63.

Changing the mask to 5 bits would limit the divider to 31, wouldn't it?

 Tomi



--dqF29lv5L4uww5H3GNdcIn5v1v2V7Xi99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVVs3AAoJEPo9qoy8lh71bMYQALJzI5h+CE0+ACZXSHf3i57u
dyKUYbR/NQphzEFf3LSloTnr/kaSPAn/RV4mWe26OsjkfFRhaiN+V2+zojhb2mUB
DIuGJuJZlpGIpqOGEY+uFEVVEeQcqBhwXjjIQW/W1wZGqM1z6DciG7eYHbf9QHxF
R/B2eL5wAtE9q/25PSINUHQuY9ypG5JRvtiLEEcCr2ttZzqXH76lQSJ+tF1Wv0wI
1DsIxM7jfkOoFJp491MTqicYffgvYz8kTfmlOlR9bs+iJz+/vFGCNi6+h+9o3Z7t
2XXTjUsiBrk826HyVdkVCsde3c4AJNrFX7a7T2oml1WoAnE7vNuuBs2PX2INU0BL
pt7tJsBk1Cxn/v6v0/X6oMSbW/RiuEKNMrtGNcQWxl0iFE9Vhe7EKzNzNApMgPdi
/a4hVyo7CyyQD7b2g9A4Obcmr/9tYEYGWLc087FOemspyu0/B1UMyCGr3gF6pkt5
9bQZfJgCYdv6FNscoSoQztnnCURmUjhsxP0uPDfaH31joCklxCzwysszv60kw3py
SQjPNWy71xGrPAmCMNFO+mwhUXPYadyfI26BqE1corfrgdF2qcMZuq12IEHKk36h
QTT9tOcI6/FPqEeVhsnBxZVtaXfwEbll5pMZuO1oqYwpXYn+0MNxHGkUPAHgtZgq
dxL4fngW+nuB0Xh+AOXH
=SJqg
-----END PGP SIGNATURE-----

--dqF29lv5L4uww5H3GNdcIn5v1v2V7Xi99--
