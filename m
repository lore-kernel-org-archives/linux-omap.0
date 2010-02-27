From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC v3][PATCH 0/6] OMAP3630: UART4 startup (+ new bugfix!)
Date: Sat, 27 Feb 2010 14:46:05 -0600
Message-ID: <1267303571-3674-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47797 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030818Ab0B0Up7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Feb 2010 15:45:59 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1RKjwKQ018745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 27 Feb 2010 14:45:58 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

Hi,

This is the v3 of the RFC for UART4 addition for 3630 chips.

Changes with respect to v2 [1]:
 - Merged patches for control bits.
 - Fix umproper check during globals setting. cpu_is_omap3630 was
   invalid at that point. (now 3630 boards are bootable gain!)
 - Fix hardcode to use PER domain on UART3 only.

Indirect dependencies:
 - Tested with Thomas Weber's patch [2].

Thanks for Paul Walmsley and Tony Lindgreen for their initial comments.

Detailed patchlist summary:

Sergio Aguirre (6):
  OMAP3: serial: Check for zero-based physical addr
  omap2/3/4: serial: Remove condition for getting uart4_phys
  ARM: OMAP3630: PRCM: Add UART4 control bits
  OMAP clock: Add uart4_ick/fck definitions for 3630
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
  omap3: serial: Fix uart4 handling for 3630

 arch/arm/mach-omap2/clock3xxx_data.c  |   22 +++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 +
 arch/arm/mach-omap2/pm34xx.c          |    8 +++++-
 arch/arm/mach-omap2/prcm-common.h     |    4 +++
 arch/arm/mach-omap2/serial.c          |   34 +++++++++++++++++++-------------
 5 files changed, 54 insertions(+), 16 deletions(-)

[1] http://marc.info/?l=linux-omap&m=126719959007695&w=2
[2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2

