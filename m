From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: Fix HWCAP_TLS flag for ARM11MPCore/Cortex-A9
Date: Wed, 6 Oct 2010 17:00:23 -0700
Message-ID: <20101007000022.GD4859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55751 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab0JGAAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 20:00:35 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Daniel Walker <dwalker@codeaurora.org>, linux-omap@vger.kernel.org

Commit 14eff1812679c76564b775aa95cdd378965f6cfb added proper
detection for ARM11MPCore/Cortex-A9 instead of detecting them
as ARMv7. However, it was missing the HWCAP_TLS flags.

HWCAP_TLS is needed if support for earlier ARMv6 is compiled
into the same kernel. Without HWCAP_TLS flags the userspace
won't work unless nosmp is specified:

Kernel panic - not syncing: Attempted to kill init!
CPU0: stopping
<c005d5e4>] (unwind_backtrace+0x0/0xec) from [<c004c2f8>] (do_IPI+0xfc/0x184)
<c004c2f8>] (do_IPI+0xfc/0x184) from [<c03f25bc>] (__irq_svc+0x9c/0x160)
Exception stack(0xc0565f80 to 0xc0565fc8)
5f80: 00000001 c05772a0 00000000 00003a61 c0564000 c05cf500 c003603c c0578600
5fa0: 80033ef0 410fc091 0000001f 00000000 00000000 c0565fc8 c00b91f8 c0057cb4
5fc0: 20000013 ffffffff
[<c03f25bc>] (__irq_svc+0x9c/0x160) from [<c0057cb4>] (default_idle+0x30/0x38)
[<c0057cb4>] (default_idle+0x30/0x38) from [<c005829c>] (cpu_idle+0x9c/0xf8)
[<c005829c>] (cpu_idle+0x9c/0xf8) from [<c0008d48>] (start_kernel+0x2a4/0x300)
[<c0008d48>] (start_kernel+0x2a4/0x300) from [<80008084>] (0x80008084)

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index df422fe..8370960 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -372,7 +372,7 @@ __v7_ca9mp_proc_info:
 	b	__v7_ca9mp_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
 	.long	cpu_v7_name
 	.long	v7_processor_functions
 	.long	v7wbi_tlb_fns
