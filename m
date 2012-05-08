From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: irq: Increase no of supported interrupts to 128
Date: Tue, 08 May 2012 11:39:34 -0700
Message-ID: <87lil2o6u1.fsf@ti.com>
References: <1336486679-15892-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:47449 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755230Ab2EHSjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 14:39:19 -0400
Received: by dadz8 with SMTP id z8so5842132dad.35
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 11:39:18 -0700 (PDT)
In-Reply-To: <1336486679-15892-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Tue, 8 May 2012 19:47:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> With addition to TI81XX, AM33XX family of devices, the number
> of interrupts supported has increased to 128, compared to 96.
> The current implementation for irq handling is hardcoded to use
> 96 interrupts (with 3 register-sets to handle), this patch cleanups
> the code, to increase maximum number of interrupts support
> to 128, with dynamic detection of no of registers required for
> handling all interrupts.
>
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> Ideally, we should use dynamic allocation to allocate memory
> for registers/arrays, 

Yes.

> may be too much cleanup for this patch,

There is no such thing as too much cleanup.  ;)  
And the INTC is in need of it, IMO.

> so as of now restricting to minimal changes to fit devices
> like, am33xx/ti81xx.

Then someone else will have to do the cleanup later.  It would be
greatly appreciated if you could do the necessary cleanup in order to
cleanly add support for more SoCs.  Yes, we probably should've insisted
when support for TI81xx was added, but that one slipped in under the
radar.

For starters, the notion of a banks this code is a rather messed up and
needs a cleanup.  A bank is supposed to be a group of 32 interrupts, 
and the INTC is made up of 3 (or 4) banks.   However, the current
code creates a single "bank" of 96 (or 128) interrupts.  

It also confuses what registers are part of the bank and what are global
to the INTC.  This confusion is both in init and in context save/restore.

IMO, to clean this up, first the notion of banks needs to be fixed in
that code there is a distinction between what acts on banks and what
works on the whole INTC.

Then, the init/alloc should be done dynamically based on the number of
interrupts passed to omap_init_irq()

Kevin
