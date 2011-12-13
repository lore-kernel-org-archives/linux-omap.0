From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default
 for OMAP2+ systems
Date: Tue, 13 Dec 2011 15:27:16 +0200
Message-ID: <1323782836.1877.79.camel@deskari>
References: <y>  <1323190149-6492-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fks2mgNc63g7jAxRs2RU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58189 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab1LMN1X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:27:23 -0500
Received: by lagj5 with SMTP id j5so2431504lag.29
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 05:27:20 -0800 (PST)
In-Reply-To: <1323190149-6492-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-fks2mgNc63g7jAxRs2RU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2011-12-06 at 17:49 +0100, Benoit Cousson wrote:
> devicetree will become the mandatory boot method for OMAP2+.
> In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
> select USE_OF by default for every OMAP2+ systems.
> Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
> boot loader to keep working properly.

APPENDED_DTB sounds a bit dangerous to be enabled by default according
to the config help text.

 Tomi


--=-fks2mgNc63g7jAxRs2RU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO51K0AAoJEPo9qoy8lh71ab4P/2pbJcgf+P1noIfarvZPjr2Y
76+2lnjsHXpnyqvMhW2bRwlcgL4ectASlz0/yO0rjLB4XDbtSFl9l2I5CtH76N4H
GXdUy+3WeJwcm7qwwxuFaaWPJkGUFbCK7THb6teG9W3e/P6omoprzWWVD7WS11Gs
zhTLcHRrDnabO6vkofgVT1W4+x6N5jMWUE5BSC9H6UzmGVd7sBqCIENRGLLVdj8W
2wp6dLg7MRM0HaJ1SEspqY94TEa22VcOxsBkSLQEyzWtQEErSHzwO3siJYwqaUpm
4hZmgZh9Yu39jPI7LgGRtgcsycHBrRl6XlgAudD3CEZS9r0kDJJ2USlOh+rJpelG
HFkv0m4vducchskByfQwunC1CagHGEcllQdljC5dW3kz1vxEn17j4aMTKD3Y1IXp
++V3KSHwIi90G7J44aWEWgGqj7z94vDSJHJ7y/j2LyiJr7Cz9GT+FIsjVh6mnSUa
91DNSXhIMx2bhc9auo4XJ1zHQHRx8Zm7th8Vs4ofRsGvPdbdG1VSxAuYWjHQiWMH
KyEA/Sn9rcQgkQ6oBJPtwAinQxJH9z4Q7NEtCiqNcqgaiHWi/PmRknrqkTbNKxrP
Ib8xmgcbAtT2AquB/DAhVpK40GvJ3y2EEBZmx67PZUWlWMRxYyGuL9ZsgRT5YF/K
0KFlEfuEDfncKDANHARa
=3Wxg
-----END PGP SIGNATURE-----

--=-fks2mgNc63g7jAxRs2RU--

