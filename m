From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [GIT PULL] ARM: OMAP2+: Serial driver sysc cleanup for 3.10
Date: Wed, 20 Mar 2013 14:04:35 +0530
Message-ID: <1363768476-17794-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57834 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3CTIcv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 04:32:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

Here is the pull request for OMAP serial driver sysconfig cleanup. The series
removes all the hackery of sysconfig from UART driver and let runtime backend
handle it. Without this series serial console is almost un-usable on OMAP5.
One of the patch touches driver/serial but I got an ack from Greg KH to get
it queued via OMAP tree.


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_serial_sysc_cleanup

for you to fetch changes up to 0f78c88b107a25561d0830c7fb695134ac7e8892:

  ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis (2013-03-19 12:07:49 +0530)

----------------------------------------------------------------
Rajendra Nayak (4):
      ARM: OMAP2+: hwmod: Remove unused _HWMOD_WAKEUP_ENABLED flag
      ARM: OMAP2+: hwmod: Cleanup sidle/mstandby programming
      ARM: OMAP2+: hwmod: Always have OCP_SYSCONFIG.ENAWAKEUP enabled
      ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in active

Santosh Shilimkar (4):
      ARM: OMAP2+: hwmod-data: UART IP needs software control to manage sidle modes
      SERIAL: OMAP: Remove the slave idle handling from the driver
      ARM: OMAP2+: serial: Remove the un-used slave idle hooks
      ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis

 arch/arm/mach-omap2/omap_hwmod.c                   |  142 ++++----------------
 arch/arm/mach-omap2/omap_hwmod.h                   |   13 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +-
 arch/arm/mach-omap2/serial.c                       |   31 -----
 drivers/tty/serial/omap-serial.c                   |   23 ----
 include/linux/platform_data/serial-omap.h          |    2 -
 9 files changed, 50 insertions(+), 180 deletions(-)
