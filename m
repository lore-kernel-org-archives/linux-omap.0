From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Patches to make multi-soc handling in entry-armv.S easier
Date: Fri, 03 Dec 2010 16:20:33 -0800
Message-ID: <20101204001435.28853.29616.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40945 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab0LDAUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 19:20:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

I've got some patches almost ready to go to merge the omap1
configs into a single omap1_defconfig. While working on getting
that done, I had to come up with a better solution for entry-armv.S
macros to detect the soc we're running on.

I suggest we add asm_irq_base and asm_irq_flags as in the first
patch in this series does. This way we can do the soc based detection
in init_irq or similar place. This might help also the multi-arm
work too.

Regards,

Tony

---

Tony Lindgren (4):
      ARM: Add asm_irq_base and asm_irq_flags for entry-armv.S macros
      omap2+: Use asm_irq_base for entry-macro.S
      omap1: Use asm_irq_flags for entry-macro.S
      omap1: Use get_irqnr_preamble


 arch/arm/include/asm/irq.h                     |    2 +
 arch/arm/kernel/entry-armv.S                   |   13 ++++++++
 arch/arm/mach-omap1/include/mach/entry-macro.S |   20 +++----------
 arch/arm/mach-omap1/irq.c                      |    4 +++
 arch/arm/mach-omap2/include/mach/entry-macro.S |   37 +++---------------------
 arch/arm/mach-omap2/io.c                       |   20 +++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h         |    2 +
 7 files changed, 49 insertions(+), 49 deletions(-)

-- 
Signature
