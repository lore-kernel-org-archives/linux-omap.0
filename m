From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH v2 0/2] Enable CAN peripheral support on AM3517
Date: Fri, 26 Feb 2010 17:37:13 +0530
Message-ID: <1267186035-8146-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34003 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935641Ab0BZMHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 07:07:20 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1QC7Hj1001118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Feb 2010 06:07:19 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: anantgole@ti.com, Sriramakrishnan <srk@ti.com>

AM3517 platform includes the ti-hecc CAN peripheral. This patch
series enables support for the ti-hecc peripheral on AM3517 platform.
This patch series has been validated on AM3517EVM.

This patch is generated against tip of linux-omap.

Sriramakrishnan (2):
  can:ti_hecc: board specific hookup on AM3517EVM
  can:ti_hecc: Enable CAN support on AM3517.

 arch/arm/configs/am3517_evm_defconfig     |   22 +++++++++++++---
 arch/arm/mach-omap2/board-am3517evm.c     |   38 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/am35xx.h |    9 +++++++
 3 files changed, 65 insertions(+), 4 deletions(-)

