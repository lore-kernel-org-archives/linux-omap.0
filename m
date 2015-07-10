From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: busses: i2c-omap: Increase timeout for i2c interrupt
Date: Fri, 10 Jul 2015 18:47:11 +0530
Message-ID: <559FC5D7.3000108@ti.com>
References: <1436504994-31137-1-git-send-email-vigneshr@ti.com> <559F8670.2060305@nokia.com> <20150710090909.GF1528@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150710090909.GF1528@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 07/10/2015 02:39 PM, Wolfram Sang wrote:
> 
>> 60 s sounds way too much and actually I simply don't believe this is
>> the root cause. If I take a look into the driver, then I see, that
> 
> I agree, this is just a workaround.
> 

Yes, this is a workaround. I thought this is simpler change and can go
into -rc while I work on the better fix. As you can see, the other
suggestions need quite a significant change to the isr code.

>> the design is not really the best. The whole IRQ handling could be
>> actually performed in hard IRQ handler, without threading overhead.
>> Putting even 2 bytes in the controller FIFO should not be too heavy
>> for the hard IRQ handler. Then these ridiculous spin_lock()s. What
>> is the reason behind? The IRQ is flagged with ONESHOT, so thread and
>> hardirq handler are anyway mutually excluded. But if this thread
>> ever runs longer than it's allowed in IRQ context, then it anyway
>> produces this IRQ latency because it locks spin_lock_irqsave() for
>> the whole time! So the whole point of threaded interrupt is missing.
> 
> Furthermore, this combination of threaded_irq and struct completion seems
> bogus to me. If you just want to ensure the irq happened before timeout,
> you just complete when the irq happened and do the "bottom half" after the
> completion returned?

This sounds good to me. I will try to implement this option.
Thanks for the suggestion.

> 
>> I would propose you to throw away spinlocks. Convert threaded IRQ to
>> just one hardirq handler. And continue debugging. You will reduce the
>> load of the system with the above measures, maybe it will not happen
>> any more, maybe you'll figure out that problem is somewhere else.
> 
> Or this.

I am not convinced with moving entire code at hardirq context. I believe
its better to keep hardirq as small as possible.

-- 
Regards
Vignesh
