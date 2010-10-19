From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: omap2plus_defconfig does not build
Date: Tue, 19 Oct 2010 10:15:16 -0700
Message-ID: <20101019171515.GB3038@atomide.com>
References: <a36d6a1047d959af6ea65cd7edacf6a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51009 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095Ab0JSRPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 13:15:23 -0400
Content-Disposition: inline
In-Reply-To: <a36d6a1047d959af6ea65cd7edacf6a8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Leif Lindholm <leif.lindholm@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

* Anand Gadiyar <gadiyar@ti.com> [101013 06:14]:
> Building omap2plus_defconfig (which enables support for
> OMAP2420/2430/OMAP3
> and OMAP4 in one image), I get the following build error.
> 
>   CC      arch/arm/kernel/swp_emulate.o
> /tmp/ccg979qz.s: Assembler messages:
> /tmp/ccg979qz.s:343: Error: selected processor does not support ARM mode
> `ldrexb r6,[r5]'
> /tmp/ccg979qz.s:344: Error: selected processor does not support ARM mode
> `strexb r1,r3,[r5]'
> make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> 
> I'm using CodeSourcery's 2010q1-202 toolchain based on gcc 4.4.1.
> 
> I haven't been following the lists closely the last few days, so I'm not
> sure if this is a known issue. Just reporting it for now.

This seems to be related to "ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)"
where SWP_EMULATE is selected by default. For the omap2plus_defconfig in for-next
we now have CPU_V6 and CPU_V7 set with SMP and SMP_ON_UP.

Regards,

Tony
