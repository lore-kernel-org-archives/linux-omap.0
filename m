From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 11:08:48 -0400
Message-ID: <55C4CA00.3060206@hurleysoftware.com>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de> <55C47DE1.9020902@ti.com> <55C48A1E.3070007@linutronix.de> <20150807132241.GN7576@n2100.arm.linux.org.uk> <55C4B5AE.10309@linutronix.de> <20150807135727.GP7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807135727.GP7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

[ + Greg KH ]

On 08/07/2015 09:57 AM, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 03:42:06PM +0200, Sebastian Andrzej Siewior wrote:
>> On 08/07/2015 03:22 PM, Russell King - ARM Linux wrote:
>>> On Fri, Aug 07, 2015 at 12:36:14PM +0200, Sebastian Andrzej Siewior wrote:
>>>> On 08/07/2015 11:44 AM, Peter Ujfalusi wrote:
>>>>> with a short testing audio did not broke (the only user of pause/resume)
>>>>> Some comments embedded.
>>>>>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>
>>>>> Why stable? This is not fixing any bugs since the PAUSE was not allowed for
>>>>> non cyclic transfers.
>>>>
>>>> Hmmm. The DRA7x was using pause before for UART. I just did not see it
>>>> coming that it was not allowed here. John made a similar change to the
>>>> edma driver and I assumed it went stable but now I see that it was just
>>>> cherry-picked into the ti tree.
>>>
>>> This is *NOT* stable material.
>>>
>>> Pause of these channels is something that omap-dma has *never* supported.
>>> Therefore, it is *not* a regression.  What you are doing is *adding* a
>>> feature to the omap-dma driver.  That is not stable material in any sense.
>>> Stable is for bug fixes to existing code, not feature enhancements.
>>
>> I didn't consider this as a feature.
> 
> As it is something that the driver has _not_ supported, you are clearly
> adding a feature to an existing driver.  It's not a bug fix.
> 
>>> If something else has been converted to pause channels and that is causing
>>> a problem, then _that_ conversion is where the bug lies, not the lack of
>>> support in the omap-dma.

FWIW, the actual bug is the api that silently does nothing.


>> So we had the 8250-DMA doing pause and all its current users implement
>> it. We have a DMA driver tree which is not used and it not implementing
>> pause (not implementing pause at all). Later we get a combo of 8250-DMA
>> + DMA driver that is broken because the lack of pause and this is
>> noticed a few kernel releases later.
> 
> Right, so the patch which caused the regression is the one which arranged
> for the 8250-dma + omap-dma combination to work together, not the missing
> pause support in omap-dma.

That would be the original submission patch set for an entire driver,
the 8250_omap driver.


> It doesn't matter that it's several releases old, it's that change caused
> the regression you have today.  That change is incorrect today, and it was
> just as incorrect at the time that it was merged.
> 
>> The only way of fixing the bug is by implementing the pause feature.
> 
> That's not the only way of fixing the bug.
> 
> As the binding of drivers is controlled by DT, you can disable the binding
> of these two drivers

No. 8250 dma is not a stand-alone driver. Even if it were, how would you go
back and fix DTs in the wild?

The "binding" is built-in with a CONFIG_ switch.


> there and 8250 will go back to using non-DMA mode -
> which is the situation which existed prior to the change which coupled the
> two drivers together.  That's an acceptable change for -stable trees,
> because it's reverting the change which caused the regression, taking us
> back to a situation we _know_ worked previously.

What you're suggesting here is only possible if the entire 8250_omap driver
is removed, so that's a non-starter.

I suggest to wait on any solution until the correct fix is mainlined
and backported, as you note below.

Regards,
Peter Hurley

> Then, in mainline during the next merge window, we can introduce the pause
> feature to omap-dma, and re-enable the 8250 driver to use it.  _Once_ that's
> proven stable, we can then take a view whether those changes should _then_
> be backported to stable kernels with greater confidence that backporting
> the feature addition won't itself cause a new regression.
