From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 14:21:59 -0400
Message-ID: <55C4F747.1070604@hurleysoftware.com>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de> <55C47DE1.9020902@ti.com> <55C48A1E.3070007@linutronix.de> <20150807132241.GN7576@n2100.arm.linux.org.uk> <55C4B5AE.10309@linutronix.de> <20150807135727.GP7576@n2100.arm.linux.org.uk> <55C4CA00.3060206@hurleysoftware.com> <20150807152939.GQ7576@n2100.arm.linux.org.uk> <55C4D7AF.8060305@hurleysoftware.com> <20150807163303.GS7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807163303.GS7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

[ + Heikki ]

On 08/07/2015 12:33 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 12:07:11PM -0400, Peter Hurley wrote:
>> On 08/07/2015 11:29 AM, Russell King - ARM Linux wrote:
>>> On Fri, Aug 07, 2015 at 11:08:48AM -0400, Peter Hurley wrote:
>>>> [ + Greg KH ]
>>>>
>>>> On 08/07/2015 09:57 AM, Russell King - ARM Linux wrote:
>>>>> As it is something that the driver has _not_ supported, you are clearly
>>>>> adding a feature to an existing driver.  It's not a bug fix.
>>>>>
>>>>>>> If something else has been converted to pause channels and that is causing
>>>>>>> a problem, then _that_ conversion is where the bug lies, not the lack of
>>>>>>> support in the omap-dma.
>>>>
>>>> FWIW, the actual bug is the api that silently does nothing.
>>>
>>> Incorrect.
>>>
>>> static int omap_dma_pause(struct dma_chan *chan)
>>> {
>>>         struct omap_chan *c = to_omap_dma_chan(chan);
>>>
>>>         /* Pause/Resume only allowed with cyclic mode */
>>>         if (!c->cyclic)
>>>                 return -EINVAL;
>>>
>>> Asking for the channel to be paused will return an error code indicating
>>> that the request failed.  That will be propagated back through to the
>>> return code of dmaengine_pause().
>>>
>>> If we look at what 8250-dma.c is doing:
>>>
>>>                 if (dma->rx_running) {
>>>                         dmaengine_pause(dma->rxchan);
>>>
>>> It's 8250-dma.c which is silently _ignoring_ the return code, failing
>>> to check that the operation it requested worked.  Maybe this should be
>>> WARN_ON(dmaengine_pause(dma->rxchan)) or at least it should print a
>>> message?
>>
>> Thanks for the suggestion; I'll hold on to that and push it after we add
>> the 8250 omap dma pause in mainline.
> 
> Why wait?  You're hiding a data loss bug which is clearly the result of
> code you allegedly maintain.

Because it will generate tons of unnecessary reports when the patch that
WARNs inevitably ends up in mainline a version earlier than the patch that
fixes it.

>> Well, instead of me saying something snide about the lack of upstream serial
>> driver unit tests, I'll say I've been working on cleaning up and organizing
>> my own tty/serial subsystem and driver units tests which I hope to upstream
>> in the fall.
>>
>> Those include i/o validators that ran this driver for days at time without
>> error at max line rate. Unfortunately, that hardware does not exhibit the
>> same problem as the DRA7 noted in the changelog.
> 
> What you have is a race condition in the code you a responsible for
> maintaining, caused by poorly implemented code.  Fix it, rather than
> whinging about drivers outside of your subsystem having never implemented
> _optional_ things that you choose to merge broken code which relied upon
> it _without_ checking that the operation succeeded.
> 
> It is _entirely_ your code which is wrong here.
> 
> I will wait for that to be fixed before acking the omap-dma change since
> you obviously need something to test with.

I'm not sure to what you're referring here.

A WARNing fixes nothing.

If you mean some patch, as yet unwritten, that handles the dma cases when
dmaengine_pause() is unimplemented without data loss, ok, but please confirm
that's what you mean.

However, at some point one must look at the api and wonder if the separation
of concern has been drawn in the right place.

Regards,
Peter Hurley
