From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 0/4] ARM: OMAP2+: Cleanup series in order to remove ARCH_OMAPx dependency
Date: Wed, 9 May 2012 01:22:00 +0530
Message-ID: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45462 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756799Ab2EHUEI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 16:04:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

In current implementation, some places we are still using
ARCH_OMAPx config option, making it difficult to add new devices;
for example, while adding am33xx device support I came across multiple
instances where I had to patch the existing code to make it work for
am33xx.

This patch tries to cleanup existing code for some of the
ARCH_OMAP2/3/4 dependency on the code.

NOTE: Patch series has been build tested for all possible
      combination of OMAP2, 3, 4 configurations.

History on Patch-series:
========================
Changes from V1:
   - Fixed comments from Tony
	- Config option name of SOC_HAS_SDRC changed to
	  SOC_HAS_OMAP2_SDRC
	- Config option name for SOC_HAS_DPLL_xxx flags to
	  SOC_HAS_OMAP3_DPLL_xxx.

Vaibhav Hiremath (4):
  ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o target so add
    one entry
  ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to dpll3xxx.c
  ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around
    __omap2_set_globals
  ARM: OMAP2+: CLEANUP: Add new config option for different DPLL
    features

 arch/arm/mach-omap2/Kconfig             |   42 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.c             |   18 -------------
 arch/arm/mach-omap2/common.c            |    8 +-----
 arch/arm/mach-omap2/common.h            |    5 +++
 arch/arm/mach-omap2/dpll3xxx.c          |   14 ++++++++++
 arch/arm/plat-omap/Makefile             |    4 +--
 arch/arm/plat-omap/include/plat/clock.h |   14 ++++++++--
 7 files changed, 74 insertions(+), 31 deletions(-)

