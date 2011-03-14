From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 0/2] [pm-wip/cpufreq] OMAP: CPUfreq cleanup and SMP support
Date: Mon, 14 Mar 2011 17:08:47 +0530
Message-ID: <1300102729-17276-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46236 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab1CNLiz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 07:38:55 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2EBcptp018843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 06:38:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This series is an attempt to clean-up OMAP CPUfreq driver.
	- The OMAP1 and OMAP2PLUS cpufreq support is split to avoid
	  any #ifdefery
	- The omap2plus_cupfreq support is updated to work on
	  SMP_ON_UP builds
	- SMP support is added which can be used on OMAP4

The series is generated against Kevin's latest cpufreq branch.

The following changes since commit 444a22eb04ae07aef45cd4d0154f6f2bbe76daa9:
  Kevin Hilman (1):
        cpufreq: fixup after new OPP layer merged

Santosh Shilimkar (2):
  OMAP: cpufreq: Split OMAP1 and OMAP2PLUS CPUfreq drivers.
  OMAP2PLUS: cpufreq: Add SMP support to cater OMAP4430

 arch/arm/mach-omap1/Makefile                       |    3 +
 .../cpu-omap.c => mach-omap1/omap1-cpufreq.c}      |   68 +++------
 arch/arm/mach-omap2/Makefile                       |    3 +
 .../cpu-omap.c => mach-omap2/omap2plus-cpufreq.c}  |  156 +++++++++++++-------
 arch/arm/plat-omap/Makefile                        |    1 -
 5 files changed, 128 insertions(+), 103 deletions(-)
 copy arch/arm/{plat-omap/cpu-omap.c => mach-omap1/omap1-cpufreq.c} (75%)
 rename arch/arm/{plat-omap/cpu-omap.c => mach-omap2/omap2plus-cpufreq.c} (55%)

