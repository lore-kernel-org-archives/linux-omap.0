From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] omap1: Use get_irqnr_preamble
Date: Tue, 7 Dec 2010 17:48:29 -0800
Message-ID: <20101208014829.GL17435@atomide.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
 <20101204180541.GH17222@atomide.com>
 <alpine.LFD.2.00.1012042126350.10437@xanadu.home>
 <20101205031002.GP17222@atomide.com>
 <20101208014548.GJ17435@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54427 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab0LHBsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 20:48:35 -0500
Content-Disposition: inline
In-Reply-To: <20101208014548.GJ17435@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This saves some cycles for multiple interrupts case.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index c9be6d4..584bf7b 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -31,13 +31,13 @@ omap_irq_flags:
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
