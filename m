From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV3 0/2] MPU/IVA bypass clock configuration
Date: Thu,  1 Apr 2010 18:32:17 +0800
Message-ID: <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34523 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0DAEy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 00:54:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o314stnm001371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2010 23:54:57 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM
UCs running DSP codec was earlier restricted as DSP crashed.
The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
The solution is to make sure DPLL1/DPLL2 bypass clock is always less
than maximum supported frequency for the specific OPP.
Typically these settings are to be done in bootloaders.

All the patches have been tested on OMAP3630 ZOOM3  platform.
Comments adressed in V3:
1. Used clk_set_rate API instead of directly writing to registers
2. Split the patch into 2 patches.

Vishwanath BS (4):
	OMAP3: Set MPU and IVA bypass Clock Divider
	OMAP3 PM: Set MPU and IVA bypass clock dividers in DVFS

 2 files changed, 12 insertions(+), 0 deletions(-)
 arch/arm/mach-omap2/clock3xxx_data.c |   12 ++++++++++++
 arch/arm/mach-omap2/resource34xx.c |   18 ++++++++++++++++--

