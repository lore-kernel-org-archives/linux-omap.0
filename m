From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: DRA7xx: hwmod: set DSS submodule parent hwmods
Date: Mon, 5 Jan 2015 12:34:55 +0200
Message-ID: <54AA68CF.9050904@ti.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com> <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1501022250010.27058@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JBOCJNGtKE1Axi61sSr8dU1l8DXnBn5L5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48463 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbbAEKfX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 05:35:23 -0500
In-Reply-To: <alpine.DEB.2.02.1501022250010.27058@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--JBOCJNGtKE1Axi61sSr8dU1l8DXnBn5L5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 03/01/15 00:50, Paul Walmsley wrote:
> On Fri, 19 Dec 2014, Tomi Valkeinen wrote:
>=20
>> Set DSS core hwmod as the parent for all the DSS submodules. This fixe=
s
>> the boot time DSS reset, removing the following warnings:
>>
>> omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>> omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> Thanks, queued for v3.19-rc.                        =20
>=20
> Note that I cannot test this patch due to lack of a DRA7xx board here.

Thanks. Unfortunately, I made a mistake with the DRA7xx patch. Well, the
patch itself is correct, but we have some insanity in the HW that I misse=
d:

DRA7xx has a CTRL_CORE_CONTROL_IO_2 register in the control module,
which contains bits for various subsystems, including DCAN, PCIe, QSPI
and DSS. At the moment only DCAN driver uses the register via syscon +
regmap.

For DSS, the bit 0, DSS_DESHDCP_CLKEN is critical. While the bit is
rather undocumented, it presumably enables a clock for DSS's HDCP. Now,
we don't support HDPC in the display driver, but unfortunately the clock
is required for the DSS hardware to initialize.

Without this patch, we see only the few warnings about dss hwmods
"cannot be enabled", but with the patch, we see those and some WARN()s
from hwmod as the DSS HW module does not start. So it's a bit worse.

Why I didn't notice this is that I had an u-boot version that enables
the DSS_DESHDCP_CLKEN bit and leaves it enabled.

So what to do about the issue? You could drop/revert this patch if we
don't see a quick solution for the DSS_DESHDCP_CLKEN. It won't fix
anything as such, but lessens the boot-up spam.

I don't have a good idea how to manage the bit properly. As far as I
see, the bit has to be managed via syscon, using remap_update_bits, so
that we get proper locking. With a quick glance, I didn't see anything
for that in the current clock code. And can we presume that syscon is
probed before hwmods? I guess not.

For the time being, I think the easiest solution would be to just set
the bit and leave it enabled. My understanding (based on commits in TI's
product kernel) is that leaving the DSS_DESHDCP_CLKEN enabled doesn't
really affect much, and any increased power consumption would be too
small to measure.

If that's the route, the question is still where to enable it. As I
said, I have an u-boot which enables it, but I'd rather do the enabling
in the kernel. If in the kernel, where there? It has to happen before
the hwmod init is ran.

 Tomi



--JBOCJNGtKE1Axi61sSr8dU1l8DXnBn5L5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqmjPAAoJEPo9qoy8lh71CHEQAKrDz7XklbJ/N4y6Bj0JPzFO
gpHnUBKaWjslP9zUB9FolVRCOfDxu60H9axtW6bNk0+X0156wn1zLpEgyaR4WRvV
TeuERwPR/k/vzruOCqBKd/6SGsYvfHZlvW3+Du3jXRws5n/GwowcbHlmIHIwtEOn
lvJdLkFd9DdbpLYYHQYCIYZMGG38OGS49u6LNlA466g6Y4U97S13Lz3AVrH6vM1f
WTVMA1sCCsvOK7gwW+oaDaNZSsqca/2BYtZIqW7H3Qfhp/Fqa494eLq5vpilIhAj
LVdMFxzgJ60704G3/Vf3qUTU/wkCqCS9uuvSsV3GxlnUKtCM2YG4Rc1QpCXXts/+
YtWmshSfctv5cMxCplRK+DE9da/E7702jyYtll74HISk0Xu3aCX7BAbhrdp3Scdh
0QkGvblgspBsSfA0xpHr6JmHB9Oisna9JdefXzldYPjbzL1RHNraFVigwKUKX84T
jSLyE56xG0WFnmk7oDJtWmiwAhci1/6YKQ0n2e+8xAAAjMKmTxiTZgxzVLXB4f4d
qkegQ1QrJkwTRqGHNnp591dM1tVNNUdnWzgKiKaAd/gXJyJ2asvloi4+y8oRtH2d
2Ej7FNEdBTeIwW3ufYN4GW+Pl8j5v/0qSzE68HDoP+1+Ic1+BLbVKnwZwXTwRcVY
zifZhIrjyoWYsYn4vYsC
=h6BQ
-----END PGP SIGNATURE-----

--JBOCJNGtKE1Axi61sSr8dU1l8DXnBn5L5--
