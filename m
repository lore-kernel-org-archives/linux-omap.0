From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Fri, 02 Dec 2011 13:10:41 +0200
Message-ID: <1322824257.9400.26.camel@sauron.fi.intel.com>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	 <1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
	 <1322728943.2332.13.camel@koala>
	 <CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-4kUpOP6szVnhWY3qKuxg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40567 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab1LBLJy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 06:09:54 -0500
Received: by iage36 with SMTP id e36so4029788iag.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 03:09:53 -0800 (PST)
In-Reply-To: <CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Jan Weitzel <j.weitzel@phytec.de>, linux-mtd@lists.infradead.org, tglx@linutronix.de, computersforpeace@gmail.com, linux-omap@vger.kernel.org


--=-4kUpOP6szVnhWY3qKuxg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-12-02 at 12:20 +0200, Grazvydas Ignotas wrote:
> On Thu, Dec 1, 2011 at 10:42 AM, Artem Bityutskiy <dedekind1@gmail.com> w=
rote:
> > On Tue, 2011-11-29 at 10:00 +0100, Jan Weitzel wrote:
> >> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> >
> > Pushed to l2-mtd-2.6.git, thank you!
>=20
> This breaks build here, did you really test it, Jan?
>=20
> drivers/mtd/nand/omap2.c: In function 'omap_nand_probe':
> drivers/mtd/nand/omap2.c:1078: error: 'struct omap_nand_platform_data'
> has no member named 'options'

OK, dropping it for now.

--=20
Best Regards,
Artem Bityutskiy

--=-4kUpOP6szVnhWY3qKuxg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO2LIxAAoJECmIfjd9wqK0y/4P/0nr+kGk/vnm9tocgE05aDxa
cj4daajGlKpkg672Z15JlXortkkgaouts+v8vSri/VSSReVvkA8WMcIdJCZltmPM
tIpM2mFrbKqaXgBVExNJj+rvwh8BOIE1dm9xqslnUbm8ORhotj47UzYTqIiKZrix
SRkuqE/DkWrwuIV+BOPF2PCATqK4WV5dgzkDUyhpWFuObo/2Bx9yvG6NJU4bxARA
UZ8gnzr1dbP/gId7pEyXHVqgJmS8Aqb/MP5KKG06ss0ra+eEtMvNFJZARWpngemR
Ox1NBAVC/Y/7BPaimH2Xf/DBT+iRo1cu4z1uEKjd69ZxrtcYFoopn5bxR2wGX37F
AX0DnXQld6CFsLZjfeCtjaBhLus1SYJx2Tyzg29x/eEHhbLNc5RuLYxfKgyw+9xV
HiGb9ckjnfZRtYYk5rILhhch9gkbf6iAs22FuzQVs6brttPsYBdc/9c+aiBDXNUB
cElpEC2OAt8VXYzrd5STJ+Pk/3f2bhBwR7BwYVTENU5yp+L3fC+ruiADPfx76mGO
uDcabCVD/suhN/Nv24vik0pj3sYZ7NLAcdteoBjMhd3gZLrhPQ/JfJaDjdrtbSIG
lmf1Gy239NsxIMzEiveEu9jPUvgNHj/EDBXzzqUEb0NFZY9+D/+8wNkfw4OZVIun
F90AcPiT45WGxm/bbetQ
=1Tzk
-----END PGP SIGNATURE-----

--=-4kUpOP6szVnhWY3qKuxg--

