From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP4: PM fixes and AESS integration for 3.9
Date: Fri, 8 Feb 2013 18:13:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081812040.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50687 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946843Ab3BHSNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 13:13:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-d-for-3.9

for you to fetch changes up to 0d30ee5a33ae65371f935b64715aa6ca9c9972a5:

  Merge branches 'sg_aess_reset_devel_3.9' and 'omap4_pm_fixes_a_3.9' into omap4_prcm_devel_a_3.9 (2013-02-08 09:45:12 -0700)

- ----------------------------------------------------------------

Some OMAP4 power management fixes and audio device integration
patches.

Basic test logs are available at:

    http://www.pwsan.com/omap/testlogs/omap4_prcm_devel_a_3.9/20130208094531/

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
   text     data      bss    total  kernel
    +92     +128        0     +220  am33xx_only
    +96      +96        0     +192  n800_multi_omap2xxx
    +96      +96        0     +192  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +148    +1176        0    +1324  omap2plus_defconfig
   +124      +96        0     +220  omap2plus_defconfig_2430sdp_only
   +148    +1104        0    +1252  omap2plus_defconfig_cpupm
    +84    +1176        0    +1260  omap2plus_defconfig_no_pm
   +156     +912        0    +1068  omap2plus_defconfig_omap2_4_only
   +148    +1112        0    +1260  omap2plus_defconfig_omap3_4_only
   +452    +1104    +3784    +5340  rmk_omap3430_ldp_allnoconfig
    +96     +256        0     +352  rmk_omap3430_ldp_oldconfig
   +452    +1104    +3784    +5340  rmk_omap4430_sdp_allnoconfig
   +140     +920        0    +1060  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7))
  avail  rsrvd   high  freed  board          kconfig
     8k    -8k      .      .  4430es2panda   omap2plus_defconfig
   -12k    12k      .      .  4460pandaes    omap2plus_defconfig


Paul Walmsley (4):
      ARM: OMAP2+: hwmod: add enable_preprogram hook
      ASoC: TI AESS: add autogating-enable function, callable from architecture code
      ARM: OMAP4+: AESS: enable internal auto-gating during initial setup
      Merge branches 'sg_aess_reset_devel_3.9' and 'omap4_pm_fixes_a_3.9' into omap4_prcm_devel_a_3.9

Rajendra Nayak (1):
      ARM: OMAP4: PM: Warn users about usage of older bootloaders

Santosh Shilimkar (1):
      ARM: OMAP2+: PM: Fix the dt return condition in pm_late_init()

Sebastien Guiriec (2):
      ARM: OMAP4: hwmod data: Enable AESS hwmod device
      ARM: OMAP4: hwmod data: Update AESS data with memory bank area

 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c           |   18 ++++++++++
 arch/arm/mach-omap2/omap_hwmod.h           |    8 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   49 +++++++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_reset.c     |   52 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                   |   20 +++++------
 arch/arm/mach-omap2/pm44xx.c               |   21 +++++++++--
 include/sound/aess.h                       |   53 ++++++++++++++++++++++++++++
 8 files changed, 207 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c
 create mode 100644 include/sound/aess.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFT+rAAoJEMePsQ0LvSpL+xQQAJlGtg5EPd+d4YZXzddunI06
S4X4964WNaIdrZpIDMq34fG5e5pyWglK8F3UEJzHQqG0bsw5EhdvVx+BeDkqcbvg
8q2uHfd3YNzcIKA9l4R2iJdzy6AcnJC4MQjZsSDSWPoOI5NjBtADUjosBjOBMydj
8knTQ7YIyT+gjrcu2qi6CM2jTF0AcHFG6qHuUTJVHyrdeARHISziutaGsD8cy0Bd
tPb9u4E4NGztG0ygi6cuLzThnYLQVtpxrFxArgCDI97snbtOq+vHGW89FsVzRcz4
v0tOnG5+MDFEoHG5FwHRJKKAEKQmHlWmd+/fqnMGJE+dk6B1Q4jtmkyAEhbZE4Xw
FEDqiYi/y+aIg84To2yJtJ7divBo14CwAfLI86etkJflLFQfyAW9zUhwUyTbWhGJ
8DedXVd7kC5s8roMU51L3WLVHYvEDGvQwdg8zYZnnBmMJMq7Q3PIyPwYOFjDnS1D
yVFKX+45bSUyN+7YhQ3+/BS1HnsrPj2f3Tk15feKsgu+Ngn6nlrvUi74vR+kzzaq
iXrxTOSHXpE9jseIrt734ew8iVNuj4nEvwkATKMjfuR5Ay8gn/Os7p4FtgIVBOxK
tg77JTRr4hx3orq5u7ObqJMw7GBrAn0R+nRMwrFcvQ1JPOrFU3V9oPWxG2sYrolp
gpnAa6krsZkmJvqHOISK
=WipK
-----END PGP SIGNATURE-----
