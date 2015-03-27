From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod data changes for AM43xx and DRA7xx
 for v4.1
Date: Fri, 27 Mar 2015 10:09:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503271008120.25612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36236 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbC0KJW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2015 06:09:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.1/omap-hwmod-a

for you to fetch changes up to edec17863362e0106b9e6b2f83237c7bd535e346:

  ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4 (2015-03-24 11:52:50 -0600)

- ----------------------------------------------------------------
OMAP hwmod data changes for AM43xx and DRA7xx for v4.1

Add support for the AM43xx HDQ/1-wire driver and fix the GPTIMER data
for DRA7xx.

Note that I do not have AM43xx nor DRA7xx boards, and cannot test these
patches on those platforms.

Basic build, boot, and PM test logs are available at:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.1/20150324185246/

- ----------------------------------------------------------------
Sourav Poddar (1):
      ARM: OMAP2: hwmod: AM43XX: Add hwmod support for HDQ-1W

Suman Anna (2):
      ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
      ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  36 +++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 113 +++++++++++++++++++++++++----
 arch/arm/mach-omap2/prcm43xx.h             |   1 +
 3 files changed, 134 insertions(+), 16 deletions(-)



vmlinux object size
(delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
      0     +800        0     +800  multi_v7_defconfig
      0     +920        0     +920  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0        0        0        0  omap2plus_defconfig_am33xx_only
      0     +256        0     +256  omap2plus_defconfig_am43xx_only
      0     +928        0     +928  omap2plus_defconfig_cpupm
      0     +704        0     +704  omap2plus_defconfig_dra7xx_only
      0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
      0        0        0        0  omap2plus_defconfig_n800_only_a
      0     +896        0     +896  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0        0        0        0  omap2plus_defconfig_omap3_4_only
      0        0        0        0  omap2plus_defconfig_omap5_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
      0        0        0        0  rmk_omap4430_sdp_allnoconfig
      0        0        0        0  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539))
  avail  rsrvd   high  freed  board          kconfig
 -117772k -13300k      .  -168k  2420n800       omap2plus_defconfig_n800_only_a
    -4k     4k      .      .  37xxevm        omap2plus_defconfig
    -4k     4k      .      .  4430es2panda   omap2plus_defconfig
    -4k     4k      .      .  4460pandaes    omap2plus_defconfig
    -4k     4k      .      .  5430es2sbct54  omap2plus_defconfig

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFSvrAAoJEMePsQ0LvSpLYkAP/RLWARugTgWyy5qolLMVxkNC
Zk+vILZNF0D7MkYPAg8HY1XXYajkGrAsuUreboVRs8yCXhkEEQDAbXNV1/kUXYcS
KUO9fnqDtYS9hl2Z0lX2XrhonuroyuEm2OBZgbJFaDPJ/H/AVMvip+QbVDlb3Vkl
Op/ckOhAmVNUKtMN5AYhhrvr2zIVa6+AjFVanfqFgDyfIBzyHeK5G/6ZYiQX1aW4
psAQDwRaK+j6Og1899j3Xk8AflMng2u77L2Mv3QrkcByNxvEt9Sq1HqNYYUs0Rrl
S+j63ypEDs3LiDh2vfxK3KaC9AtQaLcCkOfQ0/rpwJ/1MYr4xB/UqGcCv6Qyx19i
e4g2Eux9CUoJdPAyOKKtpDitMxEOsVEQobfbfzahNNbFGl5g29qc7rJkNO9EfIdt
YqZh4202jC52c1ax+CYCjv/hOakZZdWydf0U88ZdM/LZbS9XRFDnRLYCyCK7qKnc
aZe/6NxMwvcOOnQvt79UUZJdMfthYWUY/SlXzKE5M39/0YnbUclkoLYN/Xb/S5Yw
W3ZGJWEVzhMjoW+8AyX+PfviWvp/Zgj9ADpidCln5qYTdlGeOvi2dYKN8edbeShk
kdgnsc1htNDzV1hJWaWKpJC2AQzg1Nx4hGvfVreitCPcqpY2i+AOfIiuJ8pWU5mT
dryy4IFJRPyxXYmPN8gb
=CIxb
-----END PGP SIGNATURE-----
