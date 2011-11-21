From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Mon, 21 Nov 2011 10:35:07 -0800
Message-ID: <871ut1s4ro.fsf@ti.com>
References: <1321859802-5386-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321859802-5386-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Mon, 21 Nov 2011 12:46:42 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> For OMAP4 Interrupt enable register is a legacy register.

I don't see anything in the docs mentioning this is legacy.  In fact,
that register is used extensivly throughout the driver, even for OMAP4.

I think the CLR/SET registers were added to aid atomically
setting/clearing specific interrupts, but when disabling all, I don't
see why I2C_IE cannot be used.

For that reason, any reason why the 4430-specific check cannot simply be
removed to fix this interrupt clearing bug?

> To clear the interrupts we were writing 0 to it. 

This patch still writes 0 to it, so I'm not seeing the point of this comment.

> However on OMAP4 we were writing 1 to IRQENABLE_CLR which clears only
> the arbitration lost interrupt. The patch intends to fix the same by
> writing 1 to all the bits.

This is the bug, and should come first in the changelog so readers know
what the problem is.

> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

I believe this patch was originally from a fix by Vikram Pandita.  Even
if you've now changed the implementation, please credit the original
author (and Cc them) in the changelog.  It's common practice (and common
courtesy) to say something like "Based on an a patch originally from
Author <email>".  Thanks.

Also, this patch doesn't apply to mainline or linux-omap master.  Can
you please update?

Thanks,

Kevin
