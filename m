From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH 0/2] Enable CAN peripheral support on AM3517
Date: Tue, 23 Feb 2010 12:07:46 +0530
Message-ID: <1266907068-6210-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44493 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab0BWGhz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 01:37:55 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1N6bpRA002591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 00:37:53 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: anantgole@ti.com, Sriramakrishnan <srk@ti.com>

AM3517 platform includes the ti-hecc CAN peripheral. This patch
series enables support for the ti-hecc peripheral on AM3517 platform.
This patch series has been validated on AM3517EVM.

The patch series is dependent on AM35x clock support patches submitted
earlier.
[1].http://marc.info/?l=linux-omap&m=126628362713703&w=2
[2].http://marc.info/?l=linux-omap&m=126628364013734&w=2

Sriramakrishnan (2):
  can:ti_hecc: Enable CAN support on AM3517.
  can:ti_hecc: board specific hookup on AM3517EVM

 arch/arm/configs/am3517_evm_defconfig     |   22 +++++++++++++---
 arch/arm/mach-omap2/board-am3517evm.c     |   38 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/am35xx.h |   10 +++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

