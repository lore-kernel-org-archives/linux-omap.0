From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod: first set of patches for v3.20
Date: Wed, 21 Jan 2015 23:39:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501212338100.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47947 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbAUXjR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2015 18:39:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.20/omap-hwmod-a

for you to fetch changes up to 1c7e36bfc3e2fb2df5e2d1989a4b6fb9055a0f9b:

  ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL enabled on UART3 (2015-01-20 18:12:17 -0700)

- ----------------------------------------------------------------
ARM: OMAP2+: hwmod: first set of patches for v3.20

First set of OMAP2+ hwmod patches for Linux v3.20.  These are mostly
fixes for warnings, although there's one DRA7xx patch that fixes
CONFIG_DEBUG_LL for AM572x/DRA7xx SoCs that use UART3 for console,
such as the BeagleBoard-X15.

These patches entered Linux-next starting with the next-20150121 tag.

Basic build, boot, and PM test results can be found here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v3.20/20150121142621/

- ----------------------------------------------------------------
Keerthy (1):
      ARM: OMAP: DRA7: hwmod: Make gpmc software supervised as the smart idle is broken

Lokesh Vutla (2):
      ARM: OMAP2+: hwmod: print error if wait_target_ready() failed
      ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL enabled on UART3

Paul Walmsley (1):
      MAINTAINERS: add maintainer for OMAP hwmod data

Tomi Valkeinen (1):
      ARM: AM43xx: hwmod: set DSS submodule parent hwmods

 MAINTAINERS                                | 6 ++++++
 arch/arm/mach-omap2/omap_hwmod.c           | 4 ++--
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 5 +++--
 4 files changed, 13 insertions(+), 4 deletions(-)


vmlinux object size
(delta in bytes from test_v3.19-rc1 (97bf6af1f928216fd6c5a66e8a57bfa95a659672)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
      0        0        0        0  multi_v7_defconfig
      0        0        0        0  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
    +64        0        0      +64  omap2plus_defconfig_am33xx_only
      0        0        0        0  omap2plus_defconfig_am43xx_only
      0        0        0        0  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_dra7xx_only
    +32        0        0      +32  omap2plus_defconfig_n800_multi_omap2xxx
      0        0        0        0  omap2plus_defconfig_n800_only_a
      0        0        0        0  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0        0        0        0  omap2plus_defconfig_omap3_4_only
      0        0        0        0  omap2plus_defconfig_omap5_only
    +56        0      -56        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
    +64        0      -64        0  rmk_omap4430_sdp_allnoconfig
      0        0        0        0  rmk_omap4430_sdp_oldconfig
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwDhJAAoJEMePsQ0LvSpLFWsP/38ZfGOlOOex0JDaZSm/tTK2
WP+0RICxClIKFbvi9YHMW5yrrpEEcp7BZmcWsBf6SmJJs8HTzLjulRepz25gwPCw
JC0qReQHpHOXIqcIKaJKEP1z0FlXArUF0xInLVRvVObcHKVJ+yuG2vk7Fs6tdZVw
K7JS9x/6ZU5gZ7DMpTVuY5cuNcXaiuTb9tmKWrcXCNTneN30rpRq4g6R8kp5hSgI
PR4dCkUpEnkgPfuuLUjSNDtIwGHwulgd85O+6gr6uxOvJR3bEHfYP0jvc9XMuBnY
/Qy5KvfNjjeItfcBVgZSLusnmFXKFMApPnYJfyaikH9agoy5QFpFdMgS5syLJ5lQ
ZCLTqg71UC3sycxZGGgPqddzI+rfHH/0QboonW0+LIhB0VTgA64wH2CIoz0nfmSs
rixWz0+5cS2DaxvXRD98+1T3F1MB6wVmJr8IZaPkHT1G9FnsKNsqGd6Qk76ItdMf
8MdFxR0qEjZGK0djOyRiAvXkk2g4o3JE/MBT557eH1oHasaHiyABHqgXxEDFrtXy
/gLYUNYSHvyirFERHF0Ub4xamNNPe6WIqu68/o0yq7HxECiOmji83SpK6NfhPgPW
mAZxOhHtF67f68sa+nyZV5W9CeQTb23wcmEo9esqARh0IasM7x+mzbxVcemCN9AY
RoP0xFh/ncaBH8vv9E//
=wq+i
-----END PGP SIGNATURE-----
