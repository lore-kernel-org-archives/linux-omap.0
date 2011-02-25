From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/3] [pm-wip/cpufreq] cpufreq cleanup and SMP support
Date: Fri, 25 Feb 2011 11:40:36 +0530
Message-ID: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab1BYGKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 01:10:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P6Ag0Z019175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 00:10:44 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, vishwanath.bs@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This series is an attempt to clean-up omap cpufreq driver.
	- The OMAP1 and OMAP2PLUS cpufreq support is split to avoid
	  any #ifdefery
	- Alias clock nodes are added in all OMAP2PLUS clock-data
	  to avoid any cpu_is_xxx() checks
	- The omap2plus_cupfreq support is updated to work on
	  SMP_ON_UP builds
	- SMP support is added which can be used on OMAP4

Thanks to Vishwanath BS <vishwanath.bs@ti.com> for doing testing with
his DVFS series and review.

The series is generated against Kevin's cpufreq branch.

The following changes since commit 444a22eb04ae07aef45cd4d0154f6f2bbe76daa9:
  Kevin Hilman (1):
        cpufreq: fixup after new OPP layer merged


Santosh Shilimkar (3):
  omap2plus: clock: Add an alias cpu_ck to be used in common cpufreq
    driver
  omap: cpufreq: Split omap1 and omap2plus cpufreq drivers.
  omap2plus: cpufreq: Add SMP support to cater OMAP4430

 arch/arm/mach-omap1/Makefile                       |    3 +
 .../cpu-omap.c => mach-omap1/omap1-cpufreq.c}      |   70 +++-------
 arch/arm/mach-omap2/Makefile                       |    3 +
 arch/arm/mach-omap2/clock2420_data.c               |    1 +
 arch/arm/mach-omap2/clock2430_data.c               |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c               |    1 +
 arch/arm/mach-omap2/clock44xx_data.c               |    1 +
 .../cpu-omap.c => mach-omap2/omap2plus-cpufreq.c}  |  152 +++++++++++++-------
 arch/arm/plat-omap/Makefile                        |    1 -
 9 files changed, 129 insertions(+), 104 deletions(-)
 copy arch/arm/{plat-omap/cpu-omap.c => mach-omap1/omap1-cpufreq.c} (74%)
 rename arch/arm/{plat-omap/cpu-omap.c => mach-omap2/omap2plus-cpufreq.c} (56%)

