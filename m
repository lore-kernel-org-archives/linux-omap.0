From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Few omap randconfig fixes for v3.5-rc1
Date: Wed, 06 Jun 2012 01:22:42 -0700
Message-ID: <20120606082156.727.42730.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63606 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab2FFIWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 04:22:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Here are some fixes for review.

Regards,

Tony

---

Tony Lindgren (3):
      ARM: OMAP: Fix MMC_OMAP build when only MMC_OMAP_HS is selected
      ARM: OMAP3: Fix omap3_l3_block_irq warning when CONFIG_BUG is not set
      ARM: OMAP2+: Fix compile for CONFIG_TIDSPBRIDGE platform init code


 arch/arm/mach-omap2/dsp.c             |    3 +++
 arch/arm/mach-omap2/omap_l3_smx.c     |    3 ++-
 arch/arm/plat-omap/include/plat/mmc.h |    4 +---
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
Signature
