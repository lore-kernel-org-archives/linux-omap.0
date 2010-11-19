From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/5] omap4: l2x0 fixes and cleanup
Date: Fri, 19 Nov 2010 23:01:01 +0530
Message-ID: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55806 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab0KSRb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 12:31:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, mans@mansr.com, tony@atomide.com, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This series is outcome of the below discussion thread.
	http://www.spinics.net/lists/arm-kernel/msg104254.html

The series in brief has following patches
	- adds PL310 aux-control register bitfields
	- Use these bitfields instead of hardcoded values as part of init
	- Enable PL310 intsruction, Data prefetch hints and  BRESP to 
		improve performance
	- Set share-override bit to avoid non-cached buffer corruption
	
Thanks to Nishant Menon for testing this series on OMAP4 panda using
the memspeed utility. Have boot tested this series on OMAP4 SDP with
omap2plus_defconfig.

The following changes since commit e53beacd23d9cb47590da6a7a7f6d417b941a994:
  Linus Torvalds (1):
        Linux 2.6.37-rc2

Mans Rullgard (1):
      omap4: l2x0: enable instruction and data prefetching

Santosh Shilimkar (4):
      ARM: l2x0: Add aux control register bitfields
      omap4: l2x0: Construct the AUXCTRL value using defines
      omap4: l2x0: Set share override bit
      omap4: l2x0: Enable early BRESP bit

 arch/arm/include/asm/hardware/cache-l2x0.h |   12 ++++++++++-
 arch/arm/mach-omap2/omap4-common.c         |   30 +++++++++++++++++++++------
 2 files changed, 34 insertions(+), 8 deletions(-)
