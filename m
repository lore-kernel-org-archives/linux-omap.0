From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/5] ARM: Few patches for PM enablement.
Date: Mon, 24 Jan 2011 14:21:14 +0530
Message-ID: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35295 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab1AXIvs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:51:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The series consist of few patches to address some common PM issues
on Cortex-A9 based ARM SoCs. The skip calibration on secondary cores
is still under discussion.
On OMAP, the GIC save restore is done differently and hence that
part isn't included. Collin already have a patch for the same which
should address other SOCs.

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:
  Linus Torvalds (1):
        Linux 2.6.38-rc2

Santosh Shilimkar (5):
      ARM: gic: Add hooks for architecture specific extensions
      ARM: gic: Add distributor and interface enable/disable accessory api
      ARM: twd: Add context save restore support
      ARM: scu: Move register defines to header file
      ARM: smp: Skip secondary cpu calibration to speed-up boot

 arch/arm/common/gic.c               |   52 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/gic.h |    3 ++
 arch/arm/include/asm/localtimer.h   |   13 +++++++++
 arch/arm/include/asm/smp.h          |    8 +++++
 arch/arm/include/asm/smp_scu.h      |    6 ++++
 arch/arm/include/asm/smp_twd.h      |    2 +
 arch/arm/kernel/smp.c               |   35 +++++++++++++++++------
 arch/arm/kernel/smp_scu.c           |    6 ----
 arch/arm/kernel/smp_twd.c           |   24 ++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c      |    3 ++
 10 files changed, 137 insertions(+), 15 deletions(-)
