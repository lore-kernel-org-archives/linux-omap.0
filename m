From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Omap fixes for 2.6.32-rc2
Date: Fri, 02 Oct 2009 15:36:23 -0700
Message-ID: <20091002223510.11962.21751.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60390 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbZJBWgV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 18:36:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

Here are some more fixes for review.

Regards,

Tony

---

Daniel Walker (1):
      omap: iovmm: Add missing mutex_unlock

Hiroshi DOYU (1):
      omap: iovmm: Fix incorrect spelling

Rajendra Nayak (1):
      omap: Lock DPLL5 at boot

Sergio Aguirre (1):
      omapfb: Condition mutex acquisition

Tommi Rantala (2):
      omapfb: Blizzard: constify register address tables
      omapfb: Blizzard: fix pointer to be const

Tony Lindgren (1):
      omap: Fix incorrect 730 vs 850 detection

ye janboe (1):
      omap: SRAM: flush the right address after memcpy in omap_sram_push


 arch/arm/mach-omap2/clock34xx.c       |   35 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/cpu.h |   37 ++++++++++++---------------------
 arch/arm/plat-omap/iovmm.c            |    9 ++++----
 arch/arm/plat-omap/sram.c             |    3 ++-
 drivers/video/omap/blizzard.c         |   10 ++++-----
 drivers/video/omap/omapfb_main.c      |   22 ++++++++++++--------
 6 files changed, 75 insertions(+), 41 deletions(-)

-- 
Signature
