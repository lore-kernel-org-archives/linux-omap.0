From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Omap2 updates for 2.6.29 merge window
Date: Thu, 04 Dec 2008 18:38:42 -0800
Message-ID: <20081205023737.3868.78857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50405 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYLECio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:38:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Here are some omap2 updates for review. Some of these patches also
affect omap3 as the code is shared.

Regards,

Tony

---

David Brownell (1):
      ARM: OMAP2: bard-h4: list those eeproms

Lauri Leukkunen (1):
      ARM: OMAP2: Use omap_rev() instead of system_rev

Paul Walmsley (2):
      ARM: OMAP2: skip unnecessary TLDR write during non-autoreload for gptimer
      ARM: OMAP2: drop redundant pending write check for gptimer

Tony Lindgren (2):
      ARM: OMAP2: Fix cpu detection
      ARM: OMAP2: Prepare cpu detection for further improvements


 arch/arm/mach-omap1/id.c                        |   53 ++--
 arch/arm/mach-omap1/pm.c                        |    6 
 arch/arm/mach-omap2/board-h4.c                  |   14 +
 arch/arm/mach-omap2/clock34xx.c                 |    2 
 arch/arm/mach-omap2/id.c                        |  305 ++++++++++-------------
 arch/arm/plat-omap/dmtimer.c                    |   11 -
 arch/arm/plat-omap/include/mach/board-apollon.h |    4 
 arch/arm/plat-omap/include/mach/cpu.h           |   82 ++----
 arch/arm/plat-omap/sram.c                       |    3 
 9 files changed, 219 insertions(+), 261 deletions(-)

-- 
Signature
