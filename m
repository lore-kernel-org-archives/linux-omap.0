From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: OMAP hwmod and clock fixes for v3.15-rc
Date: Fri, 11 Apr 2014 21:10:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404112109320.5758@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33288 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaDKVKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 17:10:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 9e897e13bd46fa03485468609741974259a8c573:

  Merge branch 'for-linus' of git://git.open-osd.org/linux-open-osd (2014-04-10 14:33:02 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.15-rc/omap-fixes-a

for you to fetch changes up to 3d36ad7e7a9be0d130c862727a052ed279046437:

  ARM: OMAP2+: hwmod: fix missing braces in _init() (2014-04-11 12:29:09 -0600)

- ----------------------------------------------------------------
OMAP hwmod and clock fixes for v3.15-rc

A few OMAP hwmod and clock fixes for v3.15-rc.  Probably the most useful
fix is the AM43xx DPLL patch.

Basic build, boot, and PM test results are here:

http://www.pwsan.com/omap/testlogs/prcm-fixes-a-v3.15-rc/20140411130021/

- ----------------------------------------------------------------
Roger Quadros (1):
      ARM: OMAP3: hwmod data: Correct clock domains for USB modules

Suman Anna (1):
      ARM: OMAP2+: hwmod: fix missing braces in _init()

Tomi Valkeinen (1):
      ARM: AM43xx: fix dpll init in bypass mode

 arch/arm/mach-omap2/clkt_dpll.c            | 4 ++--
 arch/arm/mach-omap2/omap_hwmod.c           | 3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

vmlinux object size
(delta in bytes from prcm-fixes-a-v3.15-rc-base (9e897e13bd46fa03485468609741974259a8c573)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
      0       +8        0       +8  multi_v7_defconfig
     -4       +8        0       +4  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0        0        0        0  omap2plus_defconfig_am33xx_only
   +112        0        0     +112  omap2plus_defconfig_am43xx_only
     -4       +8        0       +4  omap2plus_defconfig_cpupm
     -4        0        0       -4  omap2plus_defconfig_dra7xx_only
    +12      +16        0      +28  omap2plus_defconfig_n800_multi_omap2xxx
    +12       -8        0       +4  omap2plus_defconfig_n800_only_a
     -4       +8        0       +4  omap2plus_defconfig_no_pm
     -4        0        0       -4  omap2plus_defconfig_omap2_4_only
     -4       +8        0       +4  omap2plus_defconfig_omap3_4_only
     -4      -24        0      -28  omap2plus_defconfig_omap5_only
    -16        0      +16        0  rmk_omap3430_ldp_allnoconfig
    +16      +16        0      +32  rmk_omap3430_ldp_oldconfig
     -8        0       +8        0  rmk_omap4430_sdp_allnoconfig
    +16      +16        0      +32  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from prcm-fixes-a-v3.15-rc-base (9e897e13bd46fa03485468609741974259a8c573))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTSFkWAAoJEMePsQ0LvSpL+E4QAJoFPAL0ld6ZGMMsYEcVjMjS
aTxIIFH7dnbqhohvn1bhSCPrBxlSCWqsSYbfsxv8/QiIziFBh8bSni0lyvIvvs3+
gq84aHFBs2+nKLPtoAEvEvFXDcAkPILKYCIBAl16hhfRxsKfODqJQHUjP+2eW8j0
+u+v9meCXF/fijgAgQ21gSWQrcuwrxGb088sJoAMSjFmZP3lmjTNWUCgEloRam7m
Xh+/zr3sqRjXWPxQ8nXGmjGWcyTPpF4S3nApRwOM3mI0HBxTNDiJ0VlceiWKUDBt
WYCx17+T9Ny4Zy5Y35PRkxIfeHrggDO+6InBdmyNMZs/ampqAA53jqWu16NIaKPK
XkfnMwlNhJnJvf58Dc3+Ol57NY7Vnmfd1DY0MiKvImhhxmsf1r/N6WO7DhszA3qY
48s3q4OBWFQyA+b1ZAJF6m513nXIpPKduCj4T+dyGFmyesLrKcKReEJ19aQFYkkn
TWTFzraKM/cVqOJDNpy6FWf2gICZY53aF1jCUroiT3MxESg/oAcCyWQUFQ0y+IAp
HcVey7G3e7boySgMEvOeaUXHY8+c0B2cj9W+35mMBS9mnlhQghiyIalZIvQE9M6F
8rbKB3vujPFxd9VIEfXngnhQLdMs5Wuoqaq/qUJlH/P5Tn4CKMXV7d7wHPNy+AGG
qL27Wn1zW5K7lwWNkEo0
=pexL
-----END PGP SIGNATURE-----
