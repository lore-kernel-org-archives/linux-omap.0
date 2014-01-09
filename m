From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: DSS DT support for 3.14 probably not possible
Date: Thu, 9 Jan 2014 11:58:27 +0200
Message-ID: <52CE72C3.7020103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Vx8Oogsqo1RdMb0VDveg0rvIuCBNr1Mjj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39819 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaAIJ6a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 04:58:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

--Vx8Oogsqo1RdMb0VDveg0rvIuCBNr1Mjj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Unfortunately I think the DSS DT series will miss 3.14 merge window.

The code feels quite fine, but I'm still in the process of writing the
binding documentation and getting those reviewed. And that review could
of course lead to some new changes.

So if we're going for DT-only boot for 3.14, I guess the only option is
to create the quirk display platform data for all the boards...

 Tomi


--Vx8Oogsqo1RdMb0VDveg0rvIuCBNr1Mjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSznLDAAoJEPo9qoy8lh71pTMP/jgeLS4RZUIVVc4n2AoZNQdt
6QLJS4eBUA128IyJyR99qhSL3sYBOnqHeN788cxyrOnska2jhIqSqIRE6An+cENe
J2+HmTu+BvTBcrdv07evMH6BaY7NZoRRtB3QyJbKamfIllSsZ7QeZ4z93rLGHoJh
A5zZrkXHw+5yVa3oYevyKz5lvPc6fzLG4s7KjQp7uOUUDQoK/0nwf/X3zILiFg3Z
GutEp8lfs/kbD4qLkloS20pVnrm9phR9vvS7JTPohQQ1DfwIsp5PlMB7+bQNnBp1
QGVlTaTEtCMi8NzNQIzmA0AgoWxKDR4BYEW4ttGcJFfN6fN5Lbvlh3GXYiJOojEj
8U2m9AE8EDpw4bWeQK0Rh6/Ss6YAQjeY1VRxHj9l0YZzwRDSONfyGbyq1ugJI4CG
HKT13LPyJ0wRN5O/+HSQqbTBXgq+M573ZLhJ4Jea6X6KXnhM9AXhbbvhvo1qHCiH
VC3f1dQmdRtmALBkwF+Y/Dv5SCY53fnnzBhAyL7HEqRv8hOm5/xaFxENaLtgppEd
J4g5b3RYUSVxworx9raEmuB0jX8mNURo26ARcQOzbd1pBa80go91kHKfAznDE453
G5d86+QqEJQDlGJMwYjZBQdrHTuaXp144fmBvhfh7zmE8lfpFlsR0aJ4jXtwsN3a
PO4DWRGx/9sfz06ZRu1Q
=7aU9
-----END PGP SIGNATURE-----

--Vx8Oogsqo1RdMb0VDveg0rvIuCBNr1Mjj--
