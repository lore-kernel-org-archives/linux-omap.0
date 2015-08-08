From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 21:41:19 -0400
Message-ID: <55C55E3F.5010703@hurleysoftware.com>
References: <55C47DE1.9020902@ti.com> <55C48A1E.3070007@linutronix.de> <20150807132241.GN7576@n2100.arm.linux.org.uk> <55C4B5AE.10309@linutronix.de> <20150807135727.GP7576@n2100.arm.linux.org.uk> <55C4CA00.3060206@hurleysoftware.com> <20150807152939.GQ7576@n2100.arm.linux.org.uk> <55C4D7AF.8060305@hurleysoftware.com> <20150807163303.GS7576@n2100.arm.linux.org.uk> <55C4F747.1070604@hurleysoftware.com> <20150807183230.GW7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807183230.GW7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 02:32 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 02:21:59PM -0400, Peter Hurley wrote:
>> [ + Heikki ]
>>
>> On 08/07/2015 12:33 PM, Russell King - ARM Linux wrote:
>>> What you have is a race condition in the code you a responsible for
>>> maintaining, caused by poorly implemented code.  Fix it, rather than
>>> whinging about drivers outside of your subsystem having never implemented
>>> _optional_ things that you choose to merge broken code which relied upon
>>> it _without_ checking that the operation succeeded.
>>>
>>> It is _entirely_ your code which is wrong here.
>>>
>>> I will wait for that to be fixed before acking the omap-dma change since
>>> you obviously need something to test with.
>>
>> I'm not sure to what you're referring here.
>>
>> A WARNing fixes nothing.
> 
> The warning can wait.
> 
>> If you mean some patch, as yet unwritten, that handles the dma cases when
>> dmaengine_pause() is unimplemented without data loss, ok, but please confirm
>> that's what you mean.
> 
> But the regression needs fixing.

I too would prefer the bug to be fixed.

But calling it a regression is incorrect. There is no previous SHA in which this
problem didn't exist, except before either 8250_dma or 8250_omap was added.

>From the outset, both the 8250 dma code and the 8250_omap driver (mistakenly)
relied on dmaengine_pause.


>> However, at some point one must look at the api and wonder if the separation
>> of concern has been drawn in the right place.
> 
> It _is_ in the right place.  dmaengine_pause() always has been permitted
> to fail.  It's the responsibility of the user of this API to _check_ the
> return code to find out whether it had the desired effect.  Not checking
> the return code is a bug in the caller's code.
> 
> If that wasn't the case, dmaengine_pause() would have a void return type.
> It doesn't.  It has an 'int' to allow failure

A resource error is significantly different than ENOSYS or EINVAL.


> or to allow non-
> implementation for cases where the underlying hardware can't pause the
> channel without causing data loss.


That's your assertion; I've seen no documentation to back that up
(other than the de facto commit).

And quite frankly, that's absurd.

1. No other driver implements _only some_ use-cases of dmaengine_pause().
2. The number of users expecting dmaengine_pause to be implemented for
   non-cyclic dma transfers _dwarfs_ cyclic users.
3. There's a dedicated query interface, dma_get_slave_caps(), for which
   omap-dma returns /true/ -- not /maybe/ -- to indicate dmaengine_pause()
   is implemented.

As a consumer of the api, I'd much rather opt-out at device initialization
time knowing that a required feature is unimplemented, than discover it
at i/o time when it's too late.


> What would you think is better: an API which silently loses data, or
> one which refuses to stop the transfer and reports an error code back
> to the caller.

An api which provides a means of determining if necessary functionality
is implemented _during setup_. That way the consumer of the api can
determine if the feature is supportable.

For example, dma_get_slave_caps() could differentiate
* pause for cyclic support
* pause for non-cyclic support
* pause and resume support
* pause and terminate support
....


> You seem to be arguing for the former, and as such, there's no way I
> can take you seriously.

Leaping to conclusions.


> In any case, Greg has now commented on the patch adding the feature,
> basically refusing it for stable tree inclusion.  So the matter is
> settled: omap-dma isn't going to get the pause feature added in stable
> trees any time soon.  So a different solution now needs to be found,
> which is what I've been saying all along...

While Sebastian's initial patch is a good first-cut at addressing
8250_omap's use of omap-dma, none of the patches address the general
design problem I have outlined above; namely, that simply returning
an error at use time for an unimplemented slave transaction is
fundamentally flawed.

Regards,
Peter Hurley
