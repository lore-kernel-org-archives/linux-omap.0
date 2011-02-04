From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for DEBUG_LL
Date: Thu, 03 Feb 2011 22:33:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
 <20110204012709.26410.78100.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:19169 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab1BDDdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 22:33:45 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG2002YIPW69750@VL-MR-MRZ22.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Thu, 03 Feb 2011 22:33:42 -0500 (EST)
In-reply-to: <20110204012709.26410.78100.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, 3 Feb 2011, Tony Lindgren wrote:

> This way we can have the debug-macro.S be common for omap1 and omap2+
> and get sensible error messages booting the wrong zImage with
> CONFIG_AUTO_ZRELADDR selected. Note that this does not seem to work
> with u-boot and uImage.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/include/mach/debug-macro.S |   36 ++++++++++++++++++++----
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   27 +++++++++++++++++-
>  2 files changed, 56 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> index 80dcf18..bae924e 100644
> --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> @@ -27,7 +27,15 @@
>  		.macro	inituart, id, a, v
>  		mrc	p15, 0, \a, c1, c0
>  		tst	\a, #1			@ MMU enabled?
> +#ifdef CONFIG_AUTO_ZRELADDR
> +		ldreq	\a, =omap_uart_phys
> +		biceq	\a, \a, #0xf8000000	@ clear top bits of virt addr
> +		moveq	\v, pc			@ copy pc
> +		andeq	\v, \v, #0xf8000000	@ clear lower bits
> +		orreq	\a, \v			@ combile to get phys addr
> +#else
>  		ldreq	\a, =omap_uart_v2p(omap_uart_phys)
> +#endif
>  		ldrne	\a, =omap_uart_phys

Gaaaaah!  This is horrible.

OK, you do want to store data in memory, right?  So the best way to 
always be position independent, even cross section, is to do the 
following (inspired by RMK's trick in the p2v series):

	.data

foo:	.word	0	@ value for sput
	.word	0	@ value for nik

	.text

bar:	.word	.
	.word	foo

sputnik:

	adr	r0, bar		@ get relative address of bar
	ldr	r1, [r0]	@ get absolute address of bar
	sub	r1, r1, r0	@ difference between abs and rel address
	ldr	r0, [r0, #4]	@ get absolute address of foo
	sub	r0, r0, r1	@ turn that into a relative address

	ldmia	r0, {r1, r2}	@ retrieve sput and nik
	add	r0, r1, r2
	mov	pc, lr

This code is totally position independent, so it works whether or not 
the MMU is active.  Therefore a similar technique in your macro (you 
could even put it into a macro for it) would allow you to get rid of the 
mrc and test for MMU active, get rid of the #ifdef, and not be limited 
to a 128 MB mask, etc.  And it is just one word longer than your 
shortest version i.e. 2 constants + 5 instructions vs 4 instructions + 2 
literal pool entries.


Nicolas
