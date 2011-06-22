From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 25/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
Date: Wed, 22 Jun 2011 17:10:21 +0100
Message-ID: <20110622161021.GB9449@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk> <E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52884 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab1FVQKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 12:10:33 -0400
Content-Disposition: inline
In-Reply-To: <E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

A couple of things to point out here:

On Wed, Jun 22, 2011 at 04:16:58PM +0100, Russell King - ARM Linux wrote:
> -	mrc	p15, 0, r4, c13, c0, 1	@ Context ID
> -	mrc	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
> -	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
> -	mrs	r7, cpsr		@ Store current cpsr
> -	stmia	r8!, {r4-r7}

1. The User r/w thread and process ID is not saved/restored by Linux over
context switches, so it doesn't serve any useful purpose to save and
restore over resume.

2. Compare the instruction saving and restoring the vector base address
(see below for the restore code.)

> -	ldmia	r3!,{r4-r7}
> -	mcr	p15, 0, r4, c13, c0, 1	@ Context ID
> -	mcr	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
> -	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
> -	msr	cpsr, r7		@ store cpsr

Which means it's pointless saving and restoring that register, because
we already aren't restoring it (plus there's the possibility that if we
were to write to it, we'd get an abort.)
