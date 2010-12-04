From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] omap1: Use get_irqnr_preamble
Date: Fri, 03 Dec 2010 16:20:44 -0800
Message-ID: <20101204002044.28853.28621.stgit@baageli.muru.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35812 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab0LDAUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 19:20:48 -0500
In-Reply-To: <20101204001435.28853.29616.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This saves some cycles for multiple interrupts case.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/entry-macro.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index 25b74f9..1bdcae1 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -18,13 +18,13 @@
 		.endm
 
 		.macro  get_irqnr_preamble, base, tmp
+		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
 		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
 		ldr	\tmp, [\base, #IRQ_MIR_REG_OFFSET]
 		mov	\irqstat, #0xffffffff

