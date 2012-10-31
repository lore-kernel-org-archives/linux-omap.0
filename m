From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] ARM: OMAP: more hwmod/PRCM fixes for 3.7-rc
Date: Wed, 31 Oct 2012 04:43:09 -0600
Message-ID: <20121031103607.6557.64591.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51158 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab2JaKqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 06:46:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

A few more OMAP fixes for the 3.7-rc timeframe.  Mostly hwmod fixes.

Basic test logs are available here:

    http://www.pwsan.com/omap/testlogs/fixes_b_v3.7-rc/20121029222655/

However the v3.7-rc3 kernel is still missing fixes for several regressions,
which cause several tests to fail.  With several reverts, fixes, and workarounds
applied, the following test logs were obtained:

    http://www.pwsan.com/omap/testlogs/TEST_fixes_b_v3.7-rc/20121030185805/

 which indicate that the series tests cleanly.


- Paul

---

vmlinux object size
(delta in bytes from test_v3.7-rc3 (8f0d8163b50e01f398b14bcd4dc039ac5ab18d64)):
   text     data      bss    total  kernel
   -108       -8        0     -116  am33xx_only
    +56      +16        0      +72  n800_multi_omap2xxx
    +20      +16        0      +36  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
    -92      -16        0     -108  omap2plus_defconfig
    -96       -8        0     -104  omap2plus_defconfig_2430sdp_only
    -92      +16        0      -76  omap2plus_defconfig_cpupm
    -92      -16        0     -108  omap2plus_defconfig_no_pm
    -92      +16        0      -76  omap2plus_defconfig_omap2_4_only
   -172      +16        0     -156  omap2plus_defconfig_omap3_4_only
    +12      +16        0      +28  rmk_omap3430_ldp_oldconfig
    +44      +24        0      +68  rmk_omap4430_sdp_oldconfig


Miguel Vadillo (1):
      ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to support only SWSUP

Paul Walmsley (2):
      ARM: OMAP2+: hwmod: add flag to prevent hwmod code from touching IP block during init
      ARM: OMAP4: hwmod data: do not enable or reset the McPDM during kernel init

Tero Kristo (1):
      ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod


 arch/arm/mach-omap2/clockdomains44xx_data.c  |    2 -
 arch/arm/mach-omap2/omap_hwmod.c             |   59 ++++++++++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    8 ++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++
 4 files changed, 60 insertions(+), 15 deletions(-)

