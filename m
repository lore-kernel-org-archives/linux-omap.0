From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have
	SMP_ON_UP fixups
Date: Thu, 10 Feb 2011 14:46:17 +0000
Message-ID: <20110210144617.GD3652@n2100.arm.linux.org.uk>
References: <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com> <20110125174636.GE17286@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251618230.8580@xanadu.home> <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com> <20110126124452.GB4232@n2100.arm.linux.org.uk> <20110126172535.GA15983@arm.com> <20110209142211.GA11460@n2100.arm.linux.org.uk> <20110210125624.GA3652@n2100.arm.linux.org.uk> <AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com> <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44958 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab1BJOqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 09:46:25 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 10, 2011 at 02:13:13PM +0000, Dave Martin wrote:
> On Thu, Feb 10, 2011 at 2:11 PM, Dave Martin <dave.martin@linaro.org> wrote:
> > Hi, apologies-- didn't see my mail for a bit.
> >
> > I get the problem with this tree and config (which builds with
> > SMP_ON_UP and THUMB2_KERNEL for omap3/4):
> >
> > Tree: git://git.linaro.org/people/dmart/linux-2.6-arm.git
> > dirty/arm/omap-thumb2+merged
> > Config: http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config

Thanks for the config.

> Note that this tree contains some extra patches (though I believe
> nothing is there which should cause the problem), and does not contain
> everything from rmk/devel -- so it's possible this has been fixed in
> the meantime or no longer occurs for some other reason...

No need - I now have some modules which contain SMP alternatives, so we
do need to fix the module loader for this, and keep the SMP alternatives
replacement code around.  It's not worth eliminating the code as if we
include an informative printk() to say why we're refusing to load the
module, the string would be larger than the code it eliminates.  So, I
think we need to merge the patch below to avoid run-time problems.

Of course, this conflicts rather badly with the p2v stuff...

 arch/arm/kernel/head.S   |   38 ++++++++++++++++++++++++++------------
 arch/arm/kernel/module.c |   22 +++++++++++++++++++++-
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c0225da..f06ff9f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -391,6 +391,7 @@ ENDPROC(__turn_mmu_on)
 
 
 #ifdef CONFIG_SMP_ON_UP
+	__INIT
 __fixup_smp:
 	and	r3, r9, #0x000f0000	@ architecture version
 	teq	r3, #0x000f0000		@ CPU ID supported?
@@ -415,18 +416,7 @@ __fixup_smp_on_up:
 	sub	r3, r0, r3
 	add	r4, r4, r3
 	add	r5, r5, r3
-2:	cmp	r4, r5
-	movhs	pc, lr
-	ldmia	r4!, {r0, r6}
- ARM(	str	r6, [r0, r3]	)
- THUMB(	add	r0, r0, r3	)
-#ifdef __ARMEB__
- THUMB(	mov	r6, r6, ror #16	)	@ Convert word order for big-endian.
-#endif
- THUMB(	strh	r6, [r0], #2	)	@ For Thumb-2, store as two halfwords
- THUMB(	mov	r6, r6, lsr #16	)	@ to be robust against misaligned r3.
- THUMB(	strh	r6, [r0]	)
-	b	2b
+	b	__do_fixup_smp_on_up
 ENDPROC(__fixup_smp)
 
 	.align
@@ -440,7 +430,31 @@ smp_on_up:
 	ALT_SMP(.long	1)
 	ALT_UP(.long	0)
 	.popsection
+#endif
 
+	.text
+__do_fixup_smp_on_up:
+	cmp	r4, r5
+	movhs	pc, lr
+	ldmia	r4!, {r0, r6}
+ ARM(	str	r6, [r0, r3]	)
+ THUMB(	add	r0, r0, r3	)
+#ifdef __ARMEB__
+ THUMB(	mov	r6, r6, ror #16	)	@ Convert word order for big-endian.
 #endif
+ THUMB(	strh	r6, [r0], #2	)	@ For Thumb-2, store as two halfwords
+ THUMB(	mov	r6, r6, lsr #16	)	@ to be robust against misaligned r3.
+ THUMB(	strh	r6, [r0]	)
+	b	__do_fixup_smp_on_up
+ENDPROC(__do_fixup_smp_on_up)
+
+ENTRY(fixup_smp)
+	stmfd	sp!, {r4 - r6, lr}
+	mov	r4, r0
+	add	r5, r0, r1
+	mov	r3, #0
+	bl	__do_fixup_smp_on_up
+	ldmfd	sp!, {r4 - r6, pc}
+ENDPROC(fixup_smp)
 
 #include "head-common.S"
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 2cfe816..6d4105e 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -22,6 +22,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/sections.h>
+#include <asm/smp_plat.h>
 #include <asm/unwind.h>
 
 #ifdef CONFIG_XIP_KERNEL
@@ -268,12 +269,28 @@ struct mod_unwind_map {
 	const Elf_Shdr *txt_sec;
 };
 
+static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
+	const Elf_Shdr *sechdrs, const char *name)
+{
+	const Elf_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++)
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+
+	return NULL;
+}
+
+extern void fixup_smp(const void *, unsigned long);
+
 int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 		    struct module *mod)
 {
+	const Elf_Shdr * __maybe_unused s = NULL;
 #ifdef CONFIG_ARM_UNWIND
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	const Elf_Shdr *s, *sechdrs_end = sechdrs + hdr->e_shnum;
+	const Elf_Shdr *sechdrs_end = sechdrs + hdr->e_shnum;
 	struct mod_unwind_map maps[ARM_SEC_MAX];
 	int i;
 
@@ -315,6 +332,9 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 					         maps[i].txt_sec->sh_addr,
 					         maps[i].txt_sec->sh_size);
 #endif
+	s = find_mod_section(hdr, sechdrs, ".alt.smp.init");
+	if (s && !is_smp())
+		fixup_smp((void *)s->sh_addr, s->sh_size);
 	return 0;
 }
 
