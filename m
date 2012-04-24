From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] Series short description
Date: Mon, 23 Apr 2012 17:08:21 -0700
Message-ID: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40060 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2DXAIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some patches to almost remove plat-omap/devices.c
as omap2+ is using hwmod to initialize most things.

The only driver remaining in plat-omap/devices.c is the
rng driver.

This also changes omap1 and 2420 specific mmc driver to
pass DMA request lines via platform_data as requested by
Russell.

Regards,

Tony

---

Tony Lindgren (7):
      ARM: OMAP1: Move omap_init_audio() to keep the devices in alphabetical order
      ARM: OMAP1: Move omap_init_uwire to mach-omap1
      ARM: OMAP2+: Move omap_dsp_reserve_sdram_memblock() to mach-omap2
      ARM: OMAP2: Add MMC hwmod data for 2420
      ARM: OMAP2: Use hwmod to initialize mmc for 2420
      ARM: OMAP: Move omap_mmc_add() to mach-omap1
      ARM: OMAP1: Pass dma request lines in platform data to MMC driver


 arch/arm/mach-omap1/devices.c              |  121 +++++++++++++++++++++++++---
 arch/arm/mach-omap2/devices.c              |   19 ++++
 arch/arm/mach-omap2/dsp.c                  |   27 ++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   63 ++++++++++++++
 arch/arm/plat-omap/devices.c               |  122 ----------------------------
 arch/arm/plat-omap/include/plat/mmc.h      |    9 --
 6 files changed, 214 insertions(+), 147 deletions(-)

-- 
Signature
