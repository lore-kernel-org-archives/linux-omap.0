From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 RESEND 6/7] gpio/omap: fix incorrect update to context.irqenable1
Date: Tue, 20 Mar 2012 11:01:00 -0700
Message-ID: <87zkbbywwz.fsf@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
	<1332240799-6748-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:59534 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752597Ab2CTSBE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 14:01:04 -0400
Received: by dakl33 with SMTP id l33so309519dak.3
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 11:01:01 -0700 (PDT)
In-Reply-To: <1332240799-6748-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 20 Mar 2012 16:23:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
> gpio_mask can be directly set by writing to set_irqenable register
> without overwriting current value. In order to ensure the same is
> stored in context.irqenable1, we must read from regs->irqenable
> instead of overwriting it with gpio_mask.

> The overwriting makes sense only in the second case where irqenable
> is explicitly read and updated with new gpio_mask before writing it
> back. However, for consistency reading regs->irqenable into the
> bank->context.irqenable1 takes care of both the scenarios.

...except that the code doesn't do this anymore.

I like the newer version (I hope so, since I suggested it :), but please
update the changlog to describe what the code is actually doing.

Thanks,

Kevin
