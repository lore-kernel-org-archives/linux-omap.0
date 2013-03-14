From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL]: ARM: OMAP: miscellaneous PM/clock fixes for 3.9-rc
Date: Thu, 14 Mar 2013 18:52:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303141850230.28203@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51145 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab3CNSwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 14:52:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-3.9-rc

for you to fetch changes up to 92702df3570e1ccfa050e135e50c450502251b79:

  ARM: OMAP4: PM: fix PM regression introduced by recent clock cleanup (2013-03-13 04:27:32 -0600)

- ----------------------------------------------------------------
Miscellaneous OMAP fixes for v3.9-rc.  These primarily deal with OMAP2+ power
management regressions.  There's also a fix for the OMAP1 OHCI controller.

Basic build, boot, and PM test logs are at:

    http://www.pwsan.com/omap/testlogs/fixes_a_3.9-rc/20130314101856/

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.9-rc2 (f6161aa153581da4a3867a2d1a7caf4be19b6ec9)):
   text     data      bss    total  kernel
    +40     +120        0     +160  omap1_defconfig
    +40     +120        0     +160  omap2plus_defconfig
    +40     +120        0     +160  omap2plus_defconfig_cpupm
    +40     +152        0     +192  omap2plus_defconfig_omap2_4_only
    +48     +144        0     +192  omap2plus_defconfig_omap3_4_only
   +144     +152      -72     +224  rmk_omap3430_ldp_allnoconfig
    +76     +120        0     +196  rmk_omap4430_sdp_oldconfig


Aaro Koskinen (1):
      ARM: OMAP1: fix USB host on 1710

Grazvydas Ignotas (1):
      ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby for musb

Jon Hunter (1):
      ARM: OMAP4: clock data: lock USB DPLL on boot

Paul Walmsley (1):
      ARM: OMAP4: PM: fix PM regression introduced by recent clock cleanup

 arch/arm/mach-omap1/clock_data.c           |   12 +-----------
 arch/arm/mach-omap2/cclock44xx_data.c      |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c           |    7 +++++--
 arch/arm/mach-omap2/omap_hwmod.h           |    9 +++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
 6 files changed, 45 insertions(+), 16 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQhuCAAoJEMePsQ0LvSpLp5UP/3Bg+ze1DP5lxEk0nFOMvGdG
Nc1mg7CFg0L5MxeLUyoxypMLjvi8VyaY5/Vhgl5/IouQ8X4hj8R1HQBDyU8W3tMX
6gHMlTEcagXUBkGMEemEamQH/GtyBuul01JeNfI3GhrpMU4TETw9hrBVBwxk5Y/s
ukmra6r/aVNqW4OQwDje55a8FvzMfrVNZj4VhJAiN5ai17Okfz41V2sT4kc7QP9z
haXMFbOFLFt+ZhIhwb0Yg2sOBJXUm3cWDnaKV9Emf0xwMld788LjV12ncWFiDeQx
BlO3fGiD2+QmlikhxbnN/TU/yb/CHx/ajiS0RGyI+rM7Q4K8Z4g3eMr1WyICfsFs
8KMUKhQBys8dlHPfr/cdkIXJ5OouEGbDlPlxuZ1Wyqc1QycX4DkTB4ciXjLbM+Hs
hse+OVkFjh2SFU+0jEO6hMH0rGHAc/+JiBtuAaTEsxgBWyB5FaOQ7yuktOvruEme
dOuYOwl7+fXxC6A+wW/dF4/obrO1dFaYYqGMXQYMvGr5Ym8fYFYUPfKw+R52FqjT
P6YeOLb9kkphhaiQACZTSg7iGAfrknC3rpkvbtDAny3/YWetTnsj8IDO+V5EL/kP
UCszt39awVpBHEjx9o45kHQxUs/MsWkI4j0ey/PvIDFzeVUwjmw6dyFhvuP7UaOW
lBOhXS96kZzqdddAvzWq
=6xNd
-----END PGP SIGNATURE-----
