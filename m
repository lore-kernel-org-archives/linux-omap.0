From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/3] Add support for OMAP35x processors (v3)
Date: Sun, 11 Jan 2009 01:30:20 +0530
Message-ID: <1231617620-18667-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56557 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZAJUAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 15:00:30 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0AK0NQR010766
	for <linux-omap@vger.kernel.org>; Sat, 10 Jan 2009 14:00:29 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

These patches provide support for the OMAP35x processors.

This is essentially a re-submit after series of discusions
earlier in the list. It had always been getting pushed in
my to-do list :(
See: http://marc.info/?l=linux-omap&m=122029900603111&w=2

Based on the comments received, this patch includes following:
  1) Updates to Kconfig
     (Includes the changes suggested by Aguirre Rodriguez)
  2) Runtime check for OMAP35x
  3) Updates to omap3_evm_defconfig

If the changes look good, I can make updates to Beagle,
Overo and Pandora boards as well.

Best regards,
Sanjeev

Sanjeev Premi (3):
  Add support for OMAP35x processors
  Runitme check for OMAP35x
  Updates for OMAP3EVM

 arch/arm/configs/omap3_evm_defconfig     |    5 ++
 arch/arm/mach-omap2/Kconfig              |   65 ++++++++++++++++++++--
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 arch/arm/plat-omap/common.c              |   68 +++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/common.h |    1 +
 arch/arm/plat-omap/include/mach/cpu.h    |   88 +++++++++++++++++++++++++++++-
 6 files changed, 220 insertions(+), 9 deletions(-)
