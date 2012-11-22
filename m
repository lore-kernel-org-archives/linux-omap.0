From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAP: DSS: panel-n8x0: register the DSS driver after
 SPI probe
Date: Thu, 22 Nov 2012 14:18:57 +0200
Message-ID: <50AE1831.90308@ti.com>
References: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi> <1353527332-5216-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB673F1E7E69B0346CDCC3C42"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56334 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965062Ab2KVTQK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 14:16:10 -0500
In-Reply-To: <1353527332-5216-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigB673F1E7E69B0346CDCC3C42
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2012-11-21 21:48, Aaro Koskinen wrote:
> Register the DSS driver after SPI probe. This simplifies the
> initialization. This is similar to what is being done e.g.
> in panel-acx565akm.

Is this a fix? The description sounds like it's just a cleanup. The
first patch in the series needs to be sent for the next -rc, right?

 Tomi



--------------enigB673F1E7E69B0346CDCC3C42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrhgxAAoJEPo9qoy8lh71ecAP/Rz85Uxkv1OfbrU2tEdcvskh
2KOn24DEx96TW4lCwZQu1qEOCq6TiQp1I+psbjaPVOvkF0rSE4mYGK0N5tOkQCEm
QEwnuF2Aliuoe5whJoRCn6hPlW4wbV7OeMKF1jARZCdRu5JuduTlT9xEEpsWdRKQ
m4g5vGwWdNZTkKZ6G+lU/ogPLXS7Y1TTvlYupBzUDGstLQa1QQ8LMApcVyM6bp3z
OSg4sJY66yFs4dHChcCjT5iZBIEQdCNgYrtvCj9ktvma4R+SY/PcOtLAQmIfak4z
tSLtYD2WCp8t5rp1p77fbDo31i5K+yqzDjgxvMVm0EiVGE1YOf8qAaidd2fhJbGA
1j1hK0k20EIjn8q9qGJVV5Zkzc1zj7EXKrcX2aR9u/lG7vTNrmXWjgGek0lDd5hu
RVlR7AeMcWDoeq3deH3Vec+RvYiAdiTd2iaEhAIZ3GpLfbvNlsuYKsCH2iDUev8u
bKDbXrXhL0mggs4J5IBAKy47YceFMfgB3+2yZ8WBeP4uKsNzX1jewUgneW6z107w
rBInriv06R44ClUxuYj2ZY+IRBM3BQQUbqM0p/yV95HQE7hAmHZcJBU79b0NHXpJ
AVGFNxjK+aHrSv61ucV2L38J7J6zM+20L2KrvNMcFOk4aV06MG9pMB0MovXP6vIZ
tR0P+a2x6D5FuI16aWGh
=u7kA
-----END PGP SIGNATURE-----

--------------enigB673F1E7E69B0346CDCC3C42--
