From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] initialize omap SRAM later on with __arm_ioremap_exec()
Date: Tue, 04 Oct 2011 17:45:36 -0700
Message-ID: <20111005004339.26980.31149.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49796 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab1JEApi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 20:45:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Related to the omap static mapping, here's a first take on moving the
SRAM init to happen later so we can do generic map_io.

Still working on a similar patch for omap1, will send it a bit later.

Regards,

Tony

---

Tony Lindgren (4):
      ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY
      ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io is done
      ARM: OMAP: Remove calls to SRAM allocations for framebuffer
      ARM: OMAP: Map SRAM later on with ioremap_exec()


 arch/arm/include/asm/io.h                |    1 
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 --
 arch/arm/mach-omap2/io.c                 |  108 ++++++++++++++----------------
 arch/arm/mm/ioremap.c                    |   22 ++++++
 arch/arm/plat-omap/include/plat/common.h |    1 
 arch/arm/plat-omap/sram.c                |   85 ++++++------------------
 6 files changed, 94 insertions(+), 130 deletions(-)

-- 
Signature
