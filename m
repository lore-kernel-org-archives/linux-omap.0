From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap4: 3.8: IPV6 + PREEMPT_VOLUNTARY +
	!DEBUG_[SPINLOCK|MUTEXES] = BUG()
Date: Fri, 22 Feb 2013 12:36:37 +0000
Message-ID: <20130222123637.GA30923@n2100.arm.linux.org.uk>
References: <20130221094819.GA4580@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48370 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab3BVMls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Feb 2013 07:41:48 -0500
Content-Disposition: inline
In-Reply-To: <20130221094819.GA4580@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Feb 21, 2013 at 10:48:19AM +0100, Paolo Pisati wrote:
> any idea how can i debug this?

Please try this patch, and report back whether it solves your problem.
Thanks.

 arch/arm/mm/alignment.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b820eda..db26e2e 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -749,7 +749,6 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	unsigned long instr = 0, instrptr;
 	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
 	unsigned int type;
-	mm_segment_t fs;
 	unsigned int fault;
 	u16 tinstr = 0;
 	int isize = 4;
@@ -760,16 +759,15 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	instrptr = instruction_pointer(regs);
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
 	if (thumb_mode(regs)) {
-		fault = __get_user(tinstr, (u16 *)(instrptr & ~1));
+		u16 *ptr = (u16 *)(instrptr & ~1);
+		fault = probe_kernel_address(ptr, tinstr);
 		if (!fault) {
 			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
 			    IS_T32(tinstr)) {
 				/* Thumb-2 32-bit */
 				u16 tinst2 = 0;
-				fault = __get_user(tinst2, (u16 *)(instrptr+2));
+				fault = probe_kernel_address(ptr + 1, tinst2);
 				instr = (tinstr << 16) | tinst2;
 				thumb2_32b = 1;
 			} else {
@@ -778,8 +776,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			}
 		}
 	} else
-		fault = __get_user(instr, (u32 *)instrptr);
-	set_fs(fs);
+		fault = probe_kernel_address(instrptr, instr);
 
 	if (fault) {
 		type = TYPE_FAULT;

