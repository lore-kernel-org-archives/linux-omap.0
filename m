From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] dma: cppi41: more suspend/resume patches
Date: Wed, 02 Oct 2013 13:07:12 +0200
Message-ID: <524BFE60.6050707@gmail.com>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com> <20131002102033.GB16680@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131002102033.GB16680-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 02.10.2013 12:20, Sebastian Andrzej Siewior wrote:
> * Daniel Mack | 2013-10-01 15:31:08 [+0200]:
> 
>> Patch #3, however, gives me headaches. I can't fully explain what's
>> going on, but I can tell for sure that if fixes a problem that I stared
>> on for many hours.
>>
>> The problem is that on resume, the musb core will detect that some of
>> the suspended USB devices' endpoints are stalled. Which is something
>> that is unrelated to the dma driver, it just seems to be an expected
>> condition. That, however, makes the musb core call
>> cppi41_dma_channel_abort() -> cppi41_tear_down_chan(), which is
>> an otherwise untravelled code path. When that function is called for
>> a channel which has all of td_queued, td_seen and td_desc_seen set
>> to FALSE, I'm always getting a warning like this:
>>
>> [   17.105981] ------------[ cut here ]------------
>> [   17.110861] WARNING: CPU: 0 PID: 122 at drivers/dma/cppi41.c:644 cppi41_dma_control+0x378/0x3f8 [cppi41]()
> 
> This is 
>     WARN_ON(!cdd->chan_busy[desc_num]);
> 
> at the end of cppi41_stop_chan() right?

No, as stated, the line numbers in the kernel message are somewhat off
due to added debugging code. What kicks in here is this one:

        if (!c->td_desc_seen) {
                desc_phys = cppi41_pop_desc(cdd, c->q_comp_num);
                if (desc_phys) {
                        __iormb();
                        WARN_ON(c->desc_phys != desc_phys);
                        c->td_desc_seen = 1;
                }
        }

> So you get the warning because
> you tried to stop a channel which was not busy. But then you should not
> be called at all because cppi41_dma_channel_abort() shouldn't call dma
> driver on idle channels.

However, I see nothing that forbids you from calling
dmaengine_terminate_all() on idle channels. If that's not handled
properly by the cppi driver, I'd say it needs fixing.

> How does your suspend & resume thingy work? Is it completly shutdown
> i.e. powered off? According to you earlier patches I would assume so. In
> that case the request is not enqueued and there is nothing to be removed
> from the engine, right?

No, my debugging showed that the channel has actually been prepared and
submitted before. It's just being torn down shortly after that. That's
what makes be believe in a race condition here.

> With the change you somehow get an interrupt that cleans up that slot.

Timing, I presume.

> The whole thing has been tested by manipulating the USB storage driver
> to enqueue more / less data then required by the protocol leading to a
> stall followed by an abort of the transfer. Let me re-do your suspend
> with the patches you made so far to check what is going on and if the
> "normal" transfer cancel is still working.

Ok, that sounds good.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
