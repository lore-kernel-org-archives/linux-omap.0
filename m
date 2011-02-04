From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] omap: Use inituart to configure the debug serial
 port based on machine ID
Date: Fri, 4 Feb 2011 08:49:36 -0800
Message-ID: <20110204164936.GU3322@atomide.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
 <20110204012707.26410.28508.stgit@baageli.muru.com>
 <AANLkTik7ommf_4HuahAxhMdaY-h-1JGsFfDzt2826d95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43437 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab1BDQuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:50:02 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik7ommf_4HuahAxhMdaY-h-1JGsFfDzt2826d95@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [110204 04:03]:
> On Fri, Feb 4, 2011 at 3:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Set the debug serial port based on machine ID. Note that most
> > of the patch is just trivial checking for the machine ID.
> >
..
 
> This looks a bit wasteful not only because of repeated CMPs, but also
> LDRs are generating a large literal pool. Maybe something like that be
> better:
> 
>     adr     r0, uart3_machines
> 0:
>     ldrh    \v, [r0], #2
>     tst     \v, \v
>     beq     999f                    @ end of list
>     cmp     \id, \v
>     bne     0b
>     ldr     \v, =OMAP3_UART3_BASE
>     str     \v, [\a, #0]            @ save port phys addr
>     ldr     \v, =(OMAP3_UART3_BASE + OMAP2_L4_IO_OFFSET)
>     str     \v, [\a, #4]            @ save port virt addr
>     b       999f
> 
>     uart3_machines:
>     .short MACH_TYPE_CM_T35
>     .short MACH_TYPE_CM_T3517
>     ...
>     .short 0
> 
> of course this needs an extra register..

Hmm, addruart and busyuart are limited with registers, but
inituart may not be. I'll take a look if that can be done.

Regards,

Tony
