From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: busses: i2c-omap: Increase timeout for i2c interrupt
Date: Fri, 10 Jul 2015 17:02:39 +0300
Message-ID: <559FD07F.7040402@ti.com>
References: <1436504994-31137-1-git-send-email-vigneshr@ti.com> <559F8670.2060305@nokia.com> <20150710090909.GF1528@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150710090909.GF1528@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: ext Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

On 07/10/2015 12:09 PM, Wolfram Sang wrote:
> 
>> 60 s sounds way too much and actually I simply don't believe this is
>> the root cause. If I take a look into the driver, then I see, that
> 
> I agree, this is just a workaround.
> 
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
> 

I'd very appreciated if You would be able to clarify your point a bit, pls?
completion is used to indicate end of one message transfer (+check for msg timeout),
so .master_xfer()->omap_i2c_xfer could switch to next msg.
And there could be more than on IRQ triggered depending on msg length
while one message is being transfered.

-- 
regards,
-grygorii
