From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 12:07:11 -0400
Message-ID: <55C4D7AF.8060305@hurleysoftware.com>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de> <55C47DE1.9020902@ti.com> <55C48A1E.3070007@linutronix.de> <20150807132241.GN7576@n2100.arm.linux.org.uk> <55C4B5AE.10309@linutronix.de> <20150807135727.GP7576@n2100.arm.linux.org.uk> <55C4CA00.3060206@hurleysoftware.com> <20150807152939.GQ7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807152939.GQ7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 11:29 AM, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 11:08:48AM -0400, Peter Hurley wrote:
>> [ + Greg KH ]
>>
>> On 08/07/2015 09:57 AM, Russell King - ARM Linux wrote:
>>> As it is something that the driver has _not_ supported, you are clearly
>>> adding a feature to an existing driver.  It's not a bug fix.
>>>
>>>>> If something else has been converted to pause channels and that is causing
>>>>> a problem, then _that_ conversion is where the bug lies, not the lack of
>>>>> support in the omap-dma.
>>
>> FWIW, the actual bug is the api that silently does nothing.
> 
> Incorrect.
> 
> static int omap_dma_pause(struct dma_chan *chan)
> {
>         struct omap_chan *c = to_omap_dma_chan(chan);
> 
>         /* Pause/Resume only allowed with cyclic mode */
>         if (!c->cyclic)
>                 return -EINVAL;
> 
> Asking for the channel to be paused will return an error code indicating
> that the request failed.  That will be propagated back through to the
> return code of dmaengine_pause().
> 
> If we look at what 8250-dma.c is doing:
> 
>                 if (dma->rx_running) {
>                         dmaengine_pause(dma->rxchan);
> 
> It's 8250-dma.c which is silently _ignoring_ the return code, failing
> to check that the operation it requested worked.  Maybe this should be
> WARN_ON(dmaengine_pause(dma->rxchan)) or at least it should print a
> message?

Thanks for the suggestion; I'll hold on to that and push it after we add
the 8250 omap dma pause in mainline.


>>> Right, so the patch which caused the regression is the one which arranged
>>> for the 8250-dma + omap-dma combination to work together, not the missing
>>> pause support in omap-dma.
>>
>> That would be the original submission patch set for an entire driver,
>> the 8250_omap driver.
> 
> Well, that's where the bug lies, and I don't agree with your assessment
> that it would mean reverting the whole thing.
> 
> The binding between the two drivers is controlled via DT.  DT tells it
> which DMA controller and which DMA input to use.  So, as DMA is currently
> broken on this, the solution is to break that link so that 8250-omap goes
> back to using PIO only.
> 
>>> As the binding of drivers is controlled by DT, you can disable the binding
>>> of these two drivers
>>
>> No. 8250 dma is not a stand-alone driver. Even if it were, how would you go
>> back and fix DTs in the wild?
> 
> Well, we have reached an impass then.
> 
> I'm not going to accept a feature addition to a driver as a stable patch
> without it being adequately tested over _several_ kernel revisions to
> ensure that we don't end up cocking up some driver which uses the DMA
> interfaces correctly.  It's too big a risk.
> 
> So, I guess that means that older kernels will just have to remain broken -
> all because the basic testing of the original code was never undertaken
> to ensure that basic stuff like reception of characters worked properly.


Well, instead of me saying something snide about the lack of upstream serial
driver unit tests, I'll say I've been working on cleaning up and organizing
my own tty/serial subsystem and driver units tests which I hope to upstream
in the fall.

Those include i/o validators that ran this driver for days at time without
error at max line rate. Unfortunately, that hardware does not exhibit the
same problem as the DRA7 noted in the changelog.



> Sorry, I have little sympathy here.
