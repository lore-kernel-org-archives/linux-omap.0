From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/3v4] Add support for OMAP35x processors
Date: Fri, 16 Jan 2009 21:15:37 +0530
Message-ID: <1232120737-7484-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60523 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbZAPPpr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 10:45:47 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0GFjdMs010259
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 09:45:45 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

These patches provide support for the OMAP35x processors.

I have tried to address the comments received in the
recent discussions. Specifically:
- Variants of OMAP35x are detected run-time
- OMAP35x would build for OMAP3430 SDP as well.
  Any minor incompatibilities can be addressed
  separately.

I have still not made updates for Beagle, Overo
and Pandora boards. Will do so, once these changes
get green signal.

Best regards,
Sanjeev

Sanjeev Premi (3):
  Add support for OMAP35x processors
  Runitme check for OMAP35x
  Updates for OMAP3EVM

 arch/arm/configs/omap3_evm_defconfig     |    1 +
 arch/arm/mach-omap2/Kconfig              |   28 ++++++++--
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 arch/arm/mach-omap2/id.c                 |   90 ++++++++++++++++++++++++------
 arch/arm/plat-omap/common.c              |   19 ++++++
 arch/arm/plat-omap/include/mach/common.h |    1 +
 arch/arm/plat-omap/include/mach/cpu.h    |   88 ++++++++++++++++++++++++++++-
 7 files changed, 203 insertions(+), 26 deletions(-)

