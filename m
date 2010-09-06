From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 06 Sep 2010 16:16:30 +0100
Message-ID: <1283786190.12076.106.camel@e102109-lin.cambridge.arm.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	 <20100906104413.GD20903@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62459 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752843Ab0IFPQ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 11:16:57 -0400
In-Reply-To: <20100906104413.GD20903@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bryan.wu@canonical.com

Russell,

On Mon, 2010-09-06 at 11:44 +0100, Russell King - ARM Linux wrote:
> +#ifdef CONFIG_SMP_ON_UP
> +__fixup_smp:
> +       mov     r7, #0x00070000
> +       orr     r6, r7, #0xff000000     @ mask 0xff070000
> +       orr     r7, r7, #0x41000000     @ val 0x41070000
> +       and     r0, r9, r6
> +       teq     r0, r7                  @ ARM CPU and ARMv6/v7?
> +       bne     __fixup_smp_on_up       @ no, assume UP
> +
> +       orr     r6, r6, #0x0000ff00
> +       orr     r6, r6, #0x000000f0     @ mask 0xff07fff0
> +       orr     r7, r7, #0x0000b000
> +       orr     r7, r7, #0x00000020     @ val 0x4107b020
> +       and     r0, r9, r6
> +       teq     r0, r7                  @ ARM 11MPCore?
> +       moveq   pc, lr                  @ yes, assume SMP
> +
> +       mrc     p15, 0, r0, c0, c0, 5   @ read MIDR
> +       tst     r0, #1 << 31
> +       movne   pc, lr                  @ bit 31 => SMP

An alternative would be to check for hardware coherency support in the
shareability domain using the MMFR0 register. If we have the new CPUID
format (all MP systems):

	if (ID_MMFR0<15:12> == 0) 
		HWCoherency = (ID_MMFR0<11:8> == 1)
	else 
		HWCoherency = (ID_MMFR0<31:28> == 1)

The hw coherency is built for MP systems and this register should be
valid for both ARMv6 and ARMv7 configurations.

Something like below, untested:

	mov	r6, #0x000f0000		@ mask/val new CPUID
	and	r0, r9, r6
	teq	r0, r6			@ ARMv6/v7 new CPUID
	bne	__fixup_smp_on_up	@ no, assume UP

	mrc	p15, 0, r0, c0, c1, 4	@ MMFR0
	mov	r6, #0x0000f000		@ mask shareability levels
	tst	r0, r6
	moveq	r0, r0, lsr #8		@ outermost shareability
	movne	r0, r0, lsr #28		@ innermost shareability
	and	r0, r0, #15
	cmp	r0, #1			@ check hw coherency support
	bne	__fixup_smp_on_up	@ no, assume UP

We still cannot optimise the case where you have an MP capable processor
but in a UP-only configuration (maxcpus=1).

For the availability of the Inner Shareable cache and TLB operations, we
would need to check for the MMFR3<15:12> bits.

-- 
Catalin

