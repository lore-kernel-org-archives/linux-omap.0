From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Thu, 2 Sep 2010 14:33:01 +0100
Message-ID: <20100902133301.GI26319@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com> <20100817135205.GC20325@n2100.arm.linux.org.uk> <20100817141210.GJ12184@atomide.com> <20100817154035.GD20325@n2100.arm.linux.org.uk> <20100819073810.GR12184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53351 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210Ab0IBNdO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 09:33:14 -0400
Content-Disposition: inline
In-Reply-To: <20100819073810.GR12184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

On Thu, Aug 19, 2010 at 10:38:11AM +0300, Tony Lindgren wrote:
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -346,8 +346,10 @@ __fixup_smp:
>  	bne	smp_on_up		@ no, assume UP
>  	mrc	p15, 0, r0, c0, c0, 5	@ read MIDR
>  	movs	r0, r0, lsr #30
> -	teqne	r0, #3			@ check top two bits 00 or 11
> -	moveq	pc, lr
> +	teq	r0, #0			@ check two top bits 00
> +	beq	smp_on_up		@ yes, assume UP
> +	teq	r0, #3			@ check top two bits 11
> +	movne	pc, lr			@ no, running on SMP hw

This should be:

	movs	r0, r0, lsr #30
	teqne	r0, #3
	movne	pc, lr

so that 0 or 3 avoids the return.
