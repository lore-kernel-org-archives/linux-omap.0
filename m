From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clock fixes for v3.13
Date: Thu, 24 Oct 2013 16:01:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310241550050.10391@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46068 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab3JXQBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 12:01:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/clock-fixes-a

for you to fetch changes up to 4ff7e3b65c8e1d8062365296b738fd262cfc2e9c:

  ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers (2013-10-24 09:07:23 -0600)

- ----------------------------------------------------------------
Several OMAP2+ DSS-related clock fixes for v3.13 from Tomi Valkeinen.

Basic test logs at:

   http://www.pwsan.com/omap/testlogs/clock_fixes_v3.13/20131024090906/

- ----------------------------------------------------------------
Tomi Valkeinen (3):
      ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
      ARM: OMAP3: use CLK_SET_RATE_PARENT for dss clocks
      ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers

 arch/arm/mach-omap2/cclock3xxx_data.c | 58 +++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/cclock44xx_data.c |  3 +-
 2 files changed, 51 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSaUMYAAoJEMePsQ0LvSpLwYYP/0CEQ8jzT3iFTk2+9xqHqsgo
JVL1MDf2RfPMAvjgGoCLt1aE/8MJhLiiwjwzHwuamPBZpcyk1Rb4KJulZp7BRIOs
JwBT2+QR8/wZf7xKijSPB7IMRedqyDxuXXB2BPYtzpu4vvo5A3AlFUjJnunofzfX
rdnexlw15PlYTbYSc/FkFkK0C8gW248auFBMOovBdTYWKVewH+bZWXa8kAWSvGMw
7RZ25XaKYqggFze63A273r5r2nINZVsuQFuN30ywaZEgPg3tKDXs3OwKEzTPbB1C
BLiMEJwZ8frfCmzX+kWbF9YVZYxxUylGiZ9ZI8TUh0GISWK4iMT+6/J6csnAkDvn
VGu7xUoAdBQsW8pryGd8zkIsJQoqAE7nFyg1Idn5qwH0fAXtfYcCxxNjlT4DTX6Y
2Txuk3+fb1IhQUp5E8TXIrK7mgt18XIVvpO4gYEYCAHt5LmVQ5P1AA7c6Qx7CeG/
s2RvUjMK/A5fY1tUGHHUiuvUB3YMFCFTD+mafYPW4bLy1No5pi7iKPMpnia1lbve
EaJslxNcKEX858MJ9SSVF/BNPOuGX5fIPgH2BKrHDUHdz9E79yYZ+UrX2uxAKFqw
Tcwy33Nm1BM0DaLxBo1IXUBJ8UQEBORXL16oWQubaraGHZKzCMPIhInnG43pDzCI
Yle5LLZSqcJA5yOUb1zQ
=h7H7
-----END PGP SIGNATURE-----
