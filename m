From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/9] Initial multi-omap support for omap4
Date: Fri, 29 Jan 2010 18:01:19 -0800
Message-ID: <20100130020036.10590.78028.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49193 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab0A3CA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 21:00:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

These patches allow compiling in also omap4 into the multi-omap
configuration. As I don't yet have omap4, I've only boot tested
these on omap2 and omap3.

Somebody with an omap4 board please boot test these with the
omap3_defconfig and see what happens.. You might want to enable
DEBUG_LL and EARLY_PRINTK with earlyprintk on the cmdline too.

Regards,

Tony

---

Tony Lindgren (9):
      omap: Move multi-omap ifdeffery into it's own header file
      omap2/3/4: Clean up defines for entry-macro.S
      omap4: Use get_irqnr_preamble
      omap2/3/4: Clean up entry-macro.s for adding support for omap4 multiboot
      omap2/3/4: Allow booting omap4 with multi-omap configuration
      omap3/4: Fix compile for multi-omap for clkops_noncore_dpll_ops
      omap: Fix gpio.c for multi-omap for omap4
      omap2/3/4: Fix mach-omap2/serial.c for multiboot
      omap2/3/4: Add omap4 into omap3_defconfnig


 arch/arm/configs/omap3_defconfig               |    6 +
 arch/arm/mach-omap2/clock34xx.c                |    2 
 arch/arm/mach-omap2/clock34xx.h                |    2 
 arch/arm/mach-omap2/clock34xx_data.c           |    6 -
 arch/arm/mach-omap2/clock44xx.c                |    2 
 arch/arm/mach-omap2/clock44xx.h                |    2 
 arch/arm/mach-omap2/clock44xx_data.c           |   12 +
 arch/arm/mach-omap2/include/mach/entry-macro.S |   81 +++++++--
 arch/arm/mach-omap2/serial.c                   |   18 +-
 arch/arm/plat-omap/gpio.c                      |  217 ++++++++++++++----------
 arch/arm/plat-omap/include/plat/cpu.h          |   70 --------
 arch/arm/plat-omap/include/plat/multi.h        |   94 ++++++++++
 12 files changed, 316 insertions(+), 196 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/multi.h

-- 
Signature
