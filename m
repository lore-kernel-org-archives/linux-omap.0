From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 09/18] GPIO: OMAP: Use level/edge detect reg offsets
Date: Thu, 16 Jun 2011 10:00:30 -0700
Message-ID: <87y611ognl.fsf@ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41588 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096Ab1FPRAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 13:00:41 -0400
Received: by mail-pz0-f47.google.com with SMTP id 36so1286391pzk.20
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 10:00:33 -0700 (PDT)
In-Reply-To: <1308111776-29130-8-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:52:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks mostly good, but...

[...]

> @@ -661,9 +655,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
>  			isr &= 0x0000ffff;
>  
> -		if (cpu_class_is_omap2()) {
> +		if (bank->regs->leveldetect0)

Rather than checking for the presence of the register, this should just
be 'if (bank->level_mask)'.  bank->level_mask will should already be
zero on platforms without the register.

Kevin
