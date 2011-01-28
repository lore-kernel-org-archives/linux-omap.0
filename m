From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/6] omap4: prcm: Few dpll, clockdomain and powerdomain updates
Date: Fri, 28 Jan 2011 16:34:42 +0530
Message-ID: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59122 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab1A1LE7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 06:04:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The series mainly contains dpll initialisation, CPUx clock
domain offset fix, addiing INACTIVE power domain state and
fixing logic flag for IVAHD and ABE power domains.

The series is boot tested on OMAP4430 SDP.

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:
  Linus Torvalds (1):
        Linux 2.6.38-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git omap4_prcm_misc

Rajendra Nayak (3):
  omap4: dpll: Enable all DPLL autoidle at boot
  omap4: dpll: Add dpll api to control GATE_CTRL
  omap4: dpll: Enable auto gate control for all MX postdividers

Santosh Shilimkar (3):
  omap4: powerdomain: Add supported INACTIVE power state
  omap4: prcm: Fix the CPUx clockdomain offsets
  omap4: powerdomain: Use intended PWRSTS_* flags instead of values

 arch/arm/mach-omap2/clock.h                 |    3 ++
 arch/arm/mach-omap2/clock44xx_data.c        |   24 +++++++++++++++
 arch/arm/mach-omap2/dpll3xxx.c              |   43 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h           |   12 +++++++
 arch/arm/mach-omap2/powerdomains44xx_data.c |   30 +++++++++---------
 arch/arm/mach-omap2/prcm_mpu44xx.h          |    4 +-
 arch/arm/plat-omap/include/plat/clock.h     |    1 +
 7 files changed, 100 insertions(+), 17 deletions(-)

