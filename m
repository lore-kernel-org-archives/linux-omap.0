From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PLL rounding change for v3.17
Date: Fri, 25 Jul 2014 12:55:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407251254540.18958@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33226 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaGYMzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 08:55:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17/omap-clock-b

for you to fetch changes up to 0a26344440b5f9940c99112fdc3804f073b1f5a7:

  ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to round to next-lowest rate (2014-07-25 06:11:15 -0600)

- ----------------------------------------------------------------
Modify OMAP PLL rate rounding function to round to the exact rate requested
or the next one below it.  This is intended to resolve some DSS problems.

Basic build, boot, and PM test results are available here:

http://www.pwsan.com/omap/testlogs/clock-b-v3.17/20140725061121/

- ----------------------------------------------------------------
Paul Walmsley (1):
      ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to round to next-lowest rate

 arch/arm/mach-omap2/clkt_dpll.c | 28 +++++++++++++++++++++-------
 arch/arm/mach-omap2/dpll3xxx.c  | 13 +++++++++++--
 2 files changed, 32 insertions(+), 9 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT0lNoAAoJEMePsQ0LvSpL1vEP/0likn5MTdDXY9zOEsygmx6E
+Ihd/htnvpqX/5E900Gu+zziAL5gWfhOzOk/LfcoSjxPnp3MsWysFShJSGlg4bR9
sNhlgk4bGTvra8DwozDpVUJvlwfVex/SjbByAz2/9WFNYy8s/rY+LdID3z2q2USC
Op9cly11RrAUcwpwv/A1JovL4ZFKGFV4bWgqdYkixu3cl7bNTozvSqHxVIidLFSe
xX+YeAm8MZjW31GvicpGTs+cGmZAVh4UMMjnR+vgMDUGB9QZ71uLB0N0D3rlCSxH
kYnHKVJxpmm5ehYDyDx3J1D/UlHu3/8V53evO8aFZKpyOiF8cVlOaYyXOEVfBkfn
MoRda2saEE3/LlkOh3sOizXeQicq8lAl48Ntikar3+WBBVsABCOeT/Y2/wrmo1dA
2CkeogC47Ho/mUBxoQoWDM4fyXhSnGBRh/HG5IKs71sWQuaJDSlSr4Btdxv1uf+s
oYu2lfAeWSntmD5ErgncSkKWTWC0Kgc+0D0JX/guLS8i2Y4fokfE4SECF0aborQP
k+Fn3jXkUuws2fhcUNsleYzLAn9JHtM+aHseIu45s08Bjt7KmuTTz02gK63c9mG+
6TymbzNmv1RL+HkPBhYjmv7xTFmvgOJYPlPi40csZ+XXZ8JcYRjwFotyC8kwZ8BS
Y6rnxa2hdQs5bOk/GZeQ
=s8Vm
-----END PGP SIGNATURE-----
