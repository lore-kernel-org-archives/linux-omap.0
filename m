From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 0/8] OMAP3: PM: Open Switch Retention support in the cpuidle thread.
Date: Wed, 20 Jan 2010 21:00:34 +0530
Message-ID: <1264001442-20078-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53795 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab0ATPas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 10:30:48 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0KFUjab002042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 09:30:47 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

In OMAP all power domains embed some logic and some memory.
The power domain memory contains 
	memory arrays: powered by a dedicated voltage rail
	memory  logic : powered by the same voltage rail as
			the power domain logic but has a
			dedicated power switch(power on switch)
The power domain logic for some power domains can be split between
retention flip flops (RFF) or nonretention flip flops (DFF).

When a power domain is in Open Switch Retention(OSWR) power on
switch is set to 0, Vdd can be lowered to its retention value
and is provided only to the RFF logic. Only the RFF logic is
retained. The DFF logic is lost and reset on wakeup. The voltage
to the memory arrays can be retained or cut which will in turn lead
to memory arrays retaining or losing their contents

This patch series introduces OSWR support for MPU and core domain
in the cpuidle thread. The voltage to memory arrays in these
power domains are also cut during OSWR.

Thara Gopinath (8):
  PM: Increase the cpu idle max state.
  OMAP3 PM: Conditional UART context save restore.
  OMAP2/3 PM: Adding powerdomain APIs for reading the next logic and
    mem state
  OMAP3 PM: Defining .pwrsts_logic_ret field for core power domain
    structure
  OMAP3 PM: Adding conditional core powerdomain context save and
    restore
  OMAP3 PM: Enable DPLL4 autoidle after system off.
  OMAP3 PM: Support for Open SWitch Retention for Core and MPU power
    domains in cpuidle path
  OMAP3 PM: Support to enable disable OSWR feature from pm debug fs

 arch/arm/mach-omap2/board-3430sdp.c           |    4 +
 arch/arm/mach-omap2/cpuidle34xx.c             |  138 +++++++++++++++++++++++--
 arch/arm/mach-omap2/pm-debug.c                |    5 +
 arch/arm/mach-omap2/pm.h                      |    1 +
 arch/arm/mach-omap2/pm34xx.c                  |  137 ++++++++++++++++++-------
 arch/arm/mach-omap2/powerdomain.c             |   84 +++++++++++++++
 arch/arm/mach-omap2/powerdomains34xx.h        |    2 +
 arch/arm/mach-omap2/serial.c                  |   17 ++--
 arch/arm/mach-omap2/sleep34xx.S               |    4 +
 arch/arm/plat-omap/include/plat/powerdomain.h |    4 +
 arch/arm/plat-omap/include/plat/serial.h      |    2 +-
 include/linux/cpuidle.h                       |    2 +-
 12 files changed, 342 insertions(+), 58 deletions(-)

