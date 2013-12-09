From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Mon, 9 Dec 2013 14:45:25 +0200
Message-ID: <52A5BB65.5050109@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-14-git-send-email-tomi.valkeinen@ti.com> <20131205170514.GY26766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="QgnhERorJXNshAFWBnctmteRIgR9QI0eD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41266 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933060Ab3LIMp3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Dec 2013 07:45:29 -0500
In-Reply-To: <20131205170514.GY26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

--QgnhERorJXNshAFWBnctmteRIgR9QI0eD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-12-05 19:05, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131204 04:31]:
>=20
> Description missing.. But other than that can you please check that
> the latest patch I posted in thread "[PATCH] ARM: OMAP2+: Fix populatin=
g
> the hwmod data from device" works with this?
>
> The test to do is to remove the related reg, interrupt and dma entries
> from omap_hwmod_*_data.c, and make sure the related hwmod data is initi=
alized
> from DT properly.

I made a quick test with panda, by applying your patch and reverting
b38911f3472be89551bfca740adf0009562b9873. That only effectively tests
the DISPC IRQ, but that worked fine.

> I don't know if it makes sense to have them as children of dss_core, th=
ey
> really all seem to be completely independent devices?

The DSS subdevices depend on the dss_core. dss_core has to be powered up
for any of the subdevices to work. This is done automatically by the
runtime PM when the subdevices are children of the dss_core.

> BTW, for v3.15, I'm hoping to do patches where we deprecate ti,hwmods
> property and do the lookup based on the compatible property instead ;)
> So from that point of view we need to get the device mapping right in
> the .dtsi files, and don't want to start mixing up separate devices int=
o
> single .dtsi entry.

Hmm, was that just a general comment, or something that affects the DSS
DT data I have in my patch? As far as I understand, the DSS nodes
reflect the current hwmods correctly.

With the exception that DPI and SDI do not have a matching hwmod, as
they are really part of dss_core/dispc. They are separate nodes as they
are "video outputs" the same way as the other subnodes.

I could perhaps remove the DPI and SDI nodes, and have them as direct
video ports from DISPC, but... That's easier said than done.

 Tomi



--QgnhERorJXNshAFWBnctmteRIgR9QI0eD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpbtlAAoJEPo9qoy8lh71ABsP/3TW6mOQZ6N0kA8QnXQUEWsp
/VDur2BydFJK4iaUFPloVHeJX9tMGTvxNDkUQyi4NflmjrscDet8KpFO8577UW8C
DglOw6ZunlXvba/7dAshNvfgR+Zc+nYcK8rm2uM/qauhcmJLequQzwBO3kKtQy+4
S6+sQtMJdD60HWiuT44+Unia+Fp5QpYg3/H455SWuUGh59tSDqe9W9cpqkyV/3jv
LsZhU9L+y5T3MWQ1pe6uAwEG2bDZAFRBDx4ENaLhDDpB6x2fVcdYqGFRNKKsNwlI
7n10He+NvpydOE7gZ2WIjxRxCcK46X97l0G1oYwr+HzWqEITG/Qtv4mcllPRCsCt
Rm+/wttmN3SZPJ5RDaQRUDUFW/2nAfUYeJY0lkAYjAiuXzbQsZ47q5gD5m4WtwPX
yLVBxh0LPY0sxleSw6i5+n0b8p7bBJ5pflIB1oMQgR5j2B4Al1dTdBJLFbImXxr4
g7/nKieqko78Tkg14zG9ERqrNgj/AUGyRx4W1Akxbup+OvW7bTbCAm2aO0/SX8OJ
mrLEnurOhEdYu830nJivzhl2wjXEdu4GAh2uJNn/Snbjgm9h62I5i1BlaOXf0GnJ
kP33YwqIVGZEqq5c3CdScWONLK9zxyhNwe5gbuOnt7VXDqBQy2CxeQY8actVUIMM
GK7AHKZXk2XCDkbrawNJ
=BSuC
-----END PGP SIGNATURE-----

--QgnhERorJXNshAFWBnctmteRIgR9QI0eD--
