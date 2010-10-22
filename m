From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: Fix data abort accessing proc_info from
 __lookup_processor_type (Re: [PATCH 03/10] ARM: hotplug cpu: Keep
 processor information, startup code & __lookup_processor_type)
Date: Fri, 22 Oct 2010 11:51:08 -0700
Message-ID: <20101022185108.GF17595@atomide.com>
References: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54378 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab0JVSvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 14:51:21 -0400
Content-Disposition: inline
In-Reply-To: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101004 10:18]:
> When hotplug CPU is enabled, we need to keep the list of supported CPUs,
> their setup functions, and __lookup_processor_type in place so that we
> can find and initialize secondary CPUs.  Move these into the __CPUINIT
> section.

> +	__CPUINIT
> +__lookup_processor_type:
> +	adr	r3, __lookup_processor_type_data
> +	ldmia	r3, {r4 - r6}
> +	sub	r3, r3, r4			@ get offset between virt&phys
> +	add	r5, r5, r3			@ convert virt addresses to
> +	add	r6, r6, r3			@ physical address space
> +1:	ldmia	r5, {r3, r4}			@ value, mask
> +	and	r4, r4, r9			@ mask wanted bits
> +	teq	r3, r4
> +	beq	2f
> +	add	r5, r5, #PROC_INFO_SZ		@ sizeof(proc_info_list)
> +	cmp	r5, r6
> +	blo	1b
> +	mov	r5, #0				@ unknown processor
> +2:	mov	pc, lr
> +ENDPROC(__lookup_processor_type)

The ldmia r5 above can cause a data abort depending on the compiler
pixies. This can happen if r5 address is unaligned. Here's a fix
for that.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 21 Oct 2010 19:00:41 -0700
Subject: [PATCH] ARM: Fix data abort accessing proc_info from __lookup_processor_type

Commit 5085f3ff458521045f7e43da62b8c30ea7df2e82 added better support for
CONFIG_HOTPLUG_CPU by keeping proc_info around. However, depending on
the Kconfig options selected, this can make the booting fail mysteriously
early on.

Turns out a data abort can happen in __lookup_processor in ldmia r5 {r3, r4}.
When it happens the address loaded to r5 is not aligned. Fix the problem by
aligning proc_info.

Reported-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1953e3d..a58b91d 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -114,6 +114,7 @@ SECTIONS
 			*(.glue_7)
 			*(.glue_7t)
 		*(.got)			/* Global offset table		*/
+			. = ALIGN(4);
 			ARM_CPU_KEEP(PROC_INFO)
 	}
 
