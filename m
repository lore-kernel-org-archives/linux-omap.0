From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take a
 word-aligned pointer
Date: Tue, 18 Jan 2011 01:00:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101180043140.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:33425 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab1ARGAW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 01:00:22 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LF700C2LFC0O4B0@vl-mo-mrz23.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 18 Jan 2011 01:00:00 -0500 (EST)
In-reply-to: <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:

> Add additional instructions to our assembly bitops functions to ensure
> that they only operate on word-aligned pointers.  This will be necessary
> when we switch these operations to use the word-based exclusive
> operations.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This breaks the Thumb2 kernel build:

  AS      arch/arm/lib/changebit.o
arch/arm/lib/changebit.S: Assembler messages:
arch/arm/lib/changebit.S:16: Error: Thumb does not support negative register indexing -- `strne r1,[r1,-r1]'

I also wonder what happens with a misaligned ldrex/strex... Does the 
alignment trap get invoked?  If so, the assertion could be put there 
instead if that's not done already, removing this overhead from bitops 
calls.  In the pre-ARMv6 case the alignment trap fixup would be applied 
as usual since the ldr/str are not special, but the previous code 
allowed for misaligned pointer so result would be no worse than before 
in that case.  Testing appears to indicate those misaligned bitops are 
rather nonexistent so far.

> ---
>  arch/arm/lib/bitops.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
> index d422529..910d599 100644
> --- a/arch/arm/lib/bitops.h
> +++ b/arch/arm/lib/bitops.h
> @@ -1,6 +1,8 @@
>  
>  #if __LINUX_ARM_ARCH__ >= 6 && defined(CONFIG_CPU_32v6K)
>  	.macro	bitop, instr
> +	tst	r1, #3
> +	strne	r1, [r1, -r1]		@ assert word-aligned
>  	mov	r2, #1
>  	and	r3, r0, #7		@ Get bit offset
>  	add	r1, r1, r0, lsr #3	@ Get byte offset
> @@ -14,6 +16,8 @@
>  	.endm
>  
>  	.macro	testop, instr, store
> +	tst	r1, #3
> +	strne	r1, [r1, -r1]		@ assert word-aligned
>  	and	r3, r0, #7		@ Get bit offset
>  	mov	r2, #1
>  	add	r1, r1, r0, lsr #3	@ Get byte offset
> @@ -32,6 +36,8 @@
>  	.endm
>  #else
>  	.macro	bitop, instr
> +	tst	r1, #3
> +	strne	r1, [r1, -r1]		@ assert word-aligned
>  	and	r2, r0, #7
>  	mov	r3, #1
>  	mov	r3, r3, lsl r2
> @@ -52,6 +58,8 @@
>   * to avoid dirtying the data cache.
>   */
>  	.macro	testop, instr, store
> +	tst	r1, #3
> +	strne	r1, [r1, -r1]		@ assert word-aligned
>  	add	r1, r1, r0, lsr #3
>  	and	r3, r0, #7
>  	mov	r0, #1
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
