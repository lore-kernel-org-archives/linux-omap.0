From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 0/9] omap4: prcm: Few dpll, clockdomain and powerdomain updates
Date: Fri,  4 Feb 2011 15:28:55 +0530
Message-ID: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55020 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab1BDJ7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 04:59:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The series mainly contains dpll initialisation, CPUx clock
domain offset fix, addiing INACTIVE power domain state and
fixing logic flag for IVAHD and ABE power domains.

Changes in v2:
-	All dpll autoidling moved late in boot, (as part of
	PM core init) and is done only with CONFIG_PM.
-	The autogen script update is added in changelog for
	related patches
-	CPUx renaming patch is added to be consistent with
	the database names

The series is boot tested on OMAP4430/3430 SDP.

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:
  Linus Torvalds (1):
        Linux 2.6.38-rc2

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap4_prcm_misc_v2

Benoit Cousson (1):
      omap4: clockdomain: Fix the CPUx domain name

Rajendra Nayak (5):
      omap: clocks: Add checks to see if enable/disable ops are supported
      omap: clocks: Add allow_idle/deny_idle support in clkops
      omap: dpll: Add allow_idle/deny_idle support for all DPLL's
      omap4: dpll: Add dpll api to control GATE_CTRL
      omap4: dpll: Enable auto gate control for all MX postdividers

Santosh Shilimkar (3):
      omap4: powerdomain: Add supported INACTIVE power state
      omap4: prcm: Fix the CPUx clockdomain offsets
      omap4: powerdomain: Use intended PWRSTS_* flags instead of values

 arch/arm/mach-omap2/clock.c                 |   25 +++++++++++++---
 arch/arm/mach-omap2/clock.h                 |    5 +++
 arch/arm/mach-omap2/clock3xxx_data.c        |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c        |   42 +++++++++++++-------------
 arch/arm/mach-omap2/clockdomains44xx_data.c |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c              |   42 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm44xx.c                |    4 ++
 arch/arm/mach-omap2/powerdomain.h           |   12 +++++++
 arch/arm/mach-omap2/powerdomains44xx_data.c |   30 +++++++++---------
 arch/arm/mach-omap2/prcm_mpu44xx.h          |    4 +-
 arch/arm/plat-omap/clock.c                  |   26 ++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h     |    6 ++++
 12 files changed, 156 insertions(+), 46 deletions(-)
