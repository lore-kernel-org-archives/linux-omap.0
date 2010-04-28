From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/2] omap: gpmc-nand: add ability to keep timings defined by the bootloader
Date: Wed, 28 Apr 2010 19:06:03 +0300
Message-ID: <cover.1272470212.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48290 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821Ab0D1QHh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 12:07:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: s-ghorai@ti.com, linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

These patches add ability to keep GPMC timings configured by the
bootloader. The platforms have to either define NAND GPMC timinings
explicitly via gpmc_t field of omap_nand_platform_data or set
keep_timings flag to allow detection of current timing configuration
and its subsequent use in omap2_nand_gpmc_retime.

The following changes since commit 104a77440f05430f29f9d3f4ecb88c1536819585:
  Tony Lindgren (1):
          Linux-omap rebuilt: Merged in i2c-omap-for-ben branch and cleaned up cbus branch

Mike Rapoport (2):
  omap: gpmc: add gpmc_cs_get_timings
  omap: gpmc-nand: add ability to keep timings defined by the
    bootloader

 arch/arm/mach-omap2/gpmc-nand.c        |   19 +++++++-
 arch/arm/mach-omap2/gpmc.c             |   79 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 4 files changed, 99 insertions(+), 1 deletions(-)

