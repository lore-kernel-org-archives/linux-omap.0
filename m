From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] ARM: OMAP: more hwmod/PRCM fixes for 3.7-rc
Date: Thu, 1 Nov 2012 02:52:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211010252350.6693@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210311050040.4160@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53689 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab2KACwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 22:52:54 -0400
In-Reply-To: <alpine.DEB.2.00.1210311050040.4160@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b2-for-3.7-rc

for you to fetch changes up to bc05244e65f26b7b6f87e0964bfe277803914ed9:

  ARM: OMAP4: hwmod data: do not enable or reset the McPDM during kernel init (2012-10-31 05:02:31 -0600)

- ----------------------------------------------------------------
A few more OMAP fixes for the 3.7-rc timeframe.  Mostly hwmod fixes.
This second revision includes a missing fix from Kevin for a GPIO problem.

Basic test logs are available here:

    http://www.pwsan.com/omap/testlogs/fixes_b_v3.7-rc/20121031050331/

However the v3.7-rc3 kernel is still missing fixes for several regressions,
which cause several tests to fail.  With several reverts, fixes, and workarounds
applied, the following test logs were obtained:

    http://www.pwsan.com/omap/testlogs/TEST_fixes_b_v3.7-rc/20121031050433/

 which indicate that the series tests cleanly.

- ----------------------------------------------------------------


vmlinux object size
(delta in bytes from test_v3.7-rc3 (8f0d8163b50e01f398b14bcd4dc039ac5ab18d64)):
   text     data      bss    total  kernel
     -8        0        0       -8  am33xx_only
   +156       +8        0     +164  n800_multi_omap2xxx
   +136      +16        0     +152  n800_only_a
     -8       -8        0      -16  omap1_defconfig
    +12      -24        0      -12  omap1_defconfig_1510innovator_only
    +12       +8      +32      +52  omap1_defconfig_5912osk_only
   +132        0        0     +132  omap2plus_defconfig
   +156      -16        0     +140  omap2plus_defconfig_2430sdp_only
    +68        0        0      +68  omap2plus_defconfig_cpupm
   +132        0      +64     +196  omap2plus_defconfig_no_pm
   +104      +24      +64     +192  omap2plus_defconfig_omap2_4_only
    +40      +16        0      +56  omap2plus_defconfig_omap3_4_only
   +304        0        0     +304  rmk_omap3430_ldp_oldconfig
   +260        0        0     +260  rmk_omap4430_sdp_oldconfig


Miguel Vadillo (1):
      ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to support only SWSUP

Paul Walmsley (2):
      ARM: OMAP2+: hwmod: add flag to prevent hwmod code from touching IP block during init
      ARM: OMAP4: hwmod data: do not enable or reset the McPDM during kernel init

Tero Kristo (1):
      ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod

 arch/arm/mach-omap2/clockdomains44xx_data.c  |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   63 ++++++++++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    8 ++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++
 4 files changed, 64 insertions(+), 15 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkeO0AAoJEMePsQ0LvSpLBlIP/0fAPB135m/lrBNMrPCbxfqL
5vOPVXPQcVL16wR6+LHHs4uDsSAxKlxw27sbUNgPT7b2ay46PjAn0Dr/oUaUBaC7
O8YSzUY1nONnGtOiXLHC3PTD4GuPugord0V3UWByb10qu0QvrNOFCjQV+uty+EGr
4Qk0yrUFyY2MI4g6E6DGnSbz0RAc0SLCkCn303P+SUyZfcKjTMT0KM4fuHbL9r1n
PhuPpO45KV/R153c3xCRSk2D84rKU+LHsGaxVDNzudQwQycAEhuqtXLZ4THFiUQ9
hfgVU8qSW+5e8xfCe9jVw5zNvsbs8lc/w6H/1tkKmUJT3RBZwuYmCVpOZgT38/1y
tXv7DqaWfbv7BcHhHlXWA/6sbIbTa/0RUFtmqhD0WW8ea8ryk1/4DMSt67tZn3HM
z4HSloKo8UPEUF3VHY+dA86WMyd9K5MDoxdQ3JnwBeqReKopFmer+r2X7kcM32Il
skU0WrUhUiyKli45YNxjMuW12EMdIwdipNVWDh5G5lHefpsMbOMeO+lSFaScNtDH
mvFiGLQK1UpHQS+PO7NAHR16QnKJI8Kjez55xZOXhy/QB1IM5sVvIq9AbQDeQOm+
KTwyTjBIU2yHYRbNSm8nvbK61hn50Mb2xRFQPXCr5cbZc7bKC36P1bO6t2J0K1p+
v9qv1ixyixI84IPMNpZU
=SEf9
-----END PGP SIGNATURE-----
