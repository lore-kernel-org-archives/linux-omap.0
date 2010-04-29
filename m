From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2 0/3] omap: gpmc-nand: add ability to keep timings defined by the bootloader
Date: Thu, 29 Apr 2010 11:48:09 +0300
Message-ID: <cover.1272530653.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:38483 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab0D3VC7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 17:02:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, vimal.newwork@gmail.com, s-ghorai@ti.com, Mike Rapoport <mike@compulab.co.il>

These patches add ability to keep GPMC timings configured by the
bootloader. The platforms have to either define NAND GPMC timinings
explicitly via gpmc_t field of omap_nand_platform_data or set
keep_timings flag to allow detection of current timing configuration
and its subsequent use in omap2_nand_gpmc_retime.

v2 changes:
   - remove debug leftovers
   - make timing rounding depend on .keep_timing flag and introduce
    omap2_nand_gpmc_round_timings to facilitate this change

Mike Rapoport (3):
  omap: gpmc: add gpmc_cs_get_timings
  omap: gpmc-nand: introduce omap2_nand_gpmc_round_timings helper
  omap: gpmc-nand: add ability to keep timings defined by the
    bootloader

 arch/arm/mach-omap2/gpmc-nand.c        |   73 +++++++++++++++++++------------
 arch/arm/mach-omap2/gpmc.c             |   76 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 4 files changed, 123 insertions(+), 28 deletions(-)

