From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 0/3] ARM: OMAP2+: Cleanup series in order to remove ARCH_OMAPx dependency
Date: Thu, 28 Jun 2012 20:29:24 +0530
Message-ID: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34435 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab2F1O7l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:59:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

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
Changes from V2:
	- Rebased against latest linux-omap/master
	- Removed [Patch 4/4], fixed it separately as independent patch.
	  Already in Mainline.
	- Fixed comments form KevinH, added Makefile rule for sdrc.c

Changes from V1:
	- Fixed comments from Tony
	- Config option name of SOC_HAS_SDRC changed to
	  SOC_HAS_OMAP2_SDRC
	- Config option name for SOC_HAS_DPLL_xxx flags
	  to SOC_HAS_OMAP3_DPLL_xxx.



Vaibhav Hiremath (3):
  ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o target so add
    one entry
  ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to dpll3xxx.c
  ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef around
    __omap2_set_globals

 arch/arm/mach-omap2/Kconfig    |    8 ++++++++
 arch/arm/mach-omap2/Makefile   |    3 ++-
 arch/arm/mach-omap2/clock.c    |   18 ------------------
 arch/arm/mach-omap2/common.c   |    8 +-------
 arch/arm/mach-omap2/common.h   |    5 +++++
 arch/arm/mach-omap2/dpll3xxx.c |   14 ++++++++++++++
 arch/arm/plat-omap/Makefile    |    4 +---
 7 files changed, 31 insertions(+), 29 deletions(-)

