From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 00/27] ARM: OMAP2+: clock code move under clk driver
Date: Tue, 26 May 2015 11:39:31 -0500
Message-ID: <20150526163931.GO26599@saruman.tx.rr.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <20150526160557.GD16525@atomide.com>
 <20150526163216.GF16525@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLaBmHMi4cq+C/u4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47466 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbbEZQmJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2015 12:42:09 -0400
Content-Disposition: inline
In-Reply-To: <20150526163216.GF16525@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

--yLaBmHMi4cq+C/u4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 09:32:16AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150526 09:08]:
> > * Tero Kristo <t-kristo@ti.com> [150525 08:01]:
> > > Hi,
> > >=20
> > > As requested, posting v3 with somewhat changed diff parameters and
> > > diffstat attached. Just some minor Makefile changes compared to v2,
> > > these were discussed under that set.
> > >=20
> > > Set has been pushed to:
> > > - tree: https://github.com/t-kristo/linux-pm.git
> > > - branch: for-4.2/ti-clk-move
> >=20
> > Looks like this causes a build error for at least omap2 only .config:
> >=20
> > drivers/clk/ti/dpll3xxx.o:(.rodata+0x1c): multiple definition of `clkhw=
ops_omap3_dpll'
> > drivers/clk/ti/dpll.o:(.rodata+0x0): first defined here
> >=20
> > You may want to create a file selecting ARCH_OMAP2PLUS=3Dy, then point
> > KCONFIG_ALLCONFIG to that file for make randconfig. Then just build
> > randconfigs :) Usually the issues like this are exposed within few
> > randconfig builds, some take longer if the options have dependencies.

alternatively, just clone the repository at [1] and use the example
script provided in README.md.

[1] https://github.com/felipebalbi/omap-seeds

--=20
balbi

--yLaBmHMi4cq+C/u4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVZKHDAAoJEIaOsuA1yqRE3jwP/RA41JPeoZIwNPIXgzjBwRfO
eOehGx3VrNSfr9Stkq5pMIX76N4ZXd0yOc7tbSyaIof4qkUDPv1oxhv+qLAJdPuh
XSVC5Pr/CsbKJT+FZTNhbhuHPm0wTQR/6eD+hfTPjibcHCKv4pZal2K061kTWnvX
go7vAauhUjVOGZ1b81i/8VLvN2RsebFxlGb/ZVISuyydzGUJ/HYlnK2Se3C5Dm6U
pfzjca6kEsaTqUcF6Nren2XF3BveUBsVlwZsQwGUTLOR04BQIAWORcfbWJlFQ5IP
9T3hHTbIl7gCFXWdTQcT5AomMSrH/sQQScNDawMruicgWWAuom0agLaFr7bzv7gE
qIthg+H996m2VoDUL0wQDI161bnr5LpetasrbnxWIEeKzTust4KEM2wekNK6N0a1
H7f827eyxFNy6Sle1wsZ1ib9Ks5vRs+GbpfbnrE2ZcPmhBk+FHOBCaQ5NkoVSn5c
QCZj6GN/DwiLgXA2xMtUEGD0LuNpymZbRhlre3jaCE7xV/MsPwqpmA6gaQEdIdAW
TkY0yL6eeh/sIRz8DgoLe40FvThqwheAZ6tqXlmfe6Hewir+gCH6wjJumtKMombk
vPtdABID46rGu4A26sUbYj7LrC8zJeRSHD0nI11r6n6AumsX6xHHUXLKSqfzYUFv
aDHM7KWmPWpEFh02R7sX
=IUHl
-----END PGP SIGNATURE-----

--yLaBmHMi4cq+C/u4--
