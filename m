From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 08/27] OMAPDSS: add of helpers
Date: Tue, 17 Dec 2013 09:01:00 +0200
Message-ID: <52AFF6AC.2060308@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-9-git-send-email-tomi.valkeinen@ti.com> <52AFF685.6010209@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="reX0qXsNoSF6dNBwDWxRUBngdmSniX5AB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47160 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab3LQHBE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 02:01:04 -0500
In-Reply-To: <52AFF685.6010209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--reX0qXsNoSF6dNBwDWxRUBngdmSniX5AB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-17 09:00, Archit Taneja wrote:

>> +#include "dss.h"
>> +#include "dss_features.h"
>=20
> Minor nitpick. The above 2 headers aren't needed.

Ah, thanks. Forgot to remove those =3D).

 Tomi



--reX0qXsNoSF6dNBwDWxRUBngdmSniX5AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSr/asAAoJEPo9qoy8lh71NnoP/jSJaiRaK6M226Vb9DDRf4C3
/oTfV5kuRB/qzdpX5hEACV+pd6yjQPlnRjXyxDVifq6fi1ItKOInhzMmC5oL1cyG
ZJQg1jWcTi4mZ2fqTm57PNsez0yFbpkAr3eEGW8992dXHtL6Y7/wN3SsQLjacgT9
leghDkJClbs7NtQPzdETTLa5Mj18iFLpF/zLBMY5R8OSikcX+5v+n9R/j8oGArmK
SnRB+Nvc9PEm3liJObnC+0hp8jUwylI3mlBh9fnXHRQDkrvkDsn5cpFAkjIDAcAS
YtjbkoZcIRMFu41FslcjhU93UczsbdrjL0m5P32P4fT0K8TLW1bMMB024XMagVrH
3X6JaSmV2ubQ5ZX00DpwPNS8z5u73WcqQLU4DzVkuEktMvVEJ4iH/CK3SG1gET9n
j0RrXEQbcbqRRzt+YYFwMK5BrwwfDmi518dblCJcQ7qPzBT+o3XwSsf9ZFp8JRDK
4beFEP+fp8UZ/JGKi7PjmwEU3Mk6+CVbyO6gB14tQOh7nh46s2i9d2gGEhg/Mu7b
L7u4i1F31kAwCEjzfZp5jRAvg4q778k8FE0ALOPLS4p2qkR5XWt3oZ3tSpaS6BvA
G888XBQlhoscWZvslejTePGNR3f596EnigKoiSch2AECEXue82lCt+jK+FSSwmx2
LT2qB0hv5Z9qGISfsKpR
=Qo8+
-----END PGP SIGNATURE-----

--reX0qXsNoSF6dNBwDWxRUBngdmSniX5AB--
