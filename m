From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 10/10] OMAPDSS: HDMI: Implement DSS driver interface for
 audio
Date: Wed, 25 Apr 2012 18:01:54 -0500
Message-ID: <4F988262.7000703@ti.com>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>  <1332974305-4578-11-git-send-email-ricardo.neri@ti.com>  <1335186116.1535.23.camel@lappy>  <4F97820E.2020006@ti.com> <1335334757.1923.19.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60893 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932394Ab2DYXCM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 19:02:12 -0400
In-Reply-To: <1335334757.1923.19.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>

+alsa-devel list

On 04/25/2012 01:19 AM, Tomi Valkeinen wrote:
> On Tue, 2012-04-24 at 23:48 -0500, Ricardo Neri wrote:
>> On 04/23/2012 08:01 AM, Tomi Valkeinen wrote:
>>> On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
>>>> Implement the DSS device driver audio support interface in the HDMI
>>>> panel driver and generic driver. The implementation relies on the
>>>> IP-specific functions that are defined at DSS probe time.
>>>>
>>>> A HW-safe spinlock is used to protect the audio functions. This is because
>>>
>>> What is a "HW-safe spinlock"?
>> Sorry, I meant a spinlock that disables the HW irqs when held:hardirq-safe.
>>
>>>
>>>> the audio functions may be called while holding a lock; in such case,
>>>> the panel's driver mutex is not suitable. Functions should be used
>>>> to set registers and should not wait for any other event.
>>>
>>> Are you sure this is the only option? What lock is being held?
>> For instance, ALSA calls the start audio function while holding a
>> hardirq-safe readlock. Hence, when reaching the HDMI panel start
>> function, a lock is held and irqs are disabled. Using a mutex, that
>> might sleep, is not correct; nor it is using an hardirq-unsafe spinlock.
>> Otherwise, deadlocks and/or inverse lock ordering may arise. This
>> situation was signaled by lockdep.
>>
>> IMHO, as the DSS device driver does not know who is going to use it (at
>> least the audio part), it should not assume that no locks are held when
>> its functions are called.
>>
>>> While a spinlock may be ok for now, quite often enabling/disabling things do not
>>> happen immediately,and it's much easier to do the wait synchronously.
>> I don't understand this comment. To me, holding a lock until the
>> enabling function returns is synchronous. Would you please clarify?
>
> I meant that quite often when enabling things on hardware it takes time
> until the HW is actually up and running. Perhaps a regulator needs to be
> started, or such. And it's usually simpler to wait for the HW to be up
> synchronously in the enable function, instead of some kind of
> asynchronous mechanism. And if a function waits synchronously, a mutex
> is better than spinlock.
>
> And in that sense it's often better to define (define meaning, adding a
> comment, or just mentally taking note about it) that the functions in
> the API may sleep, so that the driver is free to do what is best for the
> case, and it's also future-proof in a way that you can easily add
> function calls that sleep to the functions in the future.
>
> But you are also right in your previous comment, it's better to define
> functions so that they never sleep, as that gives the callers the
> freedom to call the funcs in atomic context.
>
> Perhaps we can have audio_start() that never sleeps, it just enables a
> few bits that start the audio. But how about audio_enable()? Is it
> possible that on some OMAP version it would need to enable a regulator,
> or set a gpio that's in an external i2c controlled mux chip, or such?

I think it might be possible to have such a scenario if, for instance, 
an external chip is used to support DisplayPort on OMAP4/5. As 
DisplayPort can support audio-only use-cases, it would have to enable 
the adapter chip (but HDMI output would have to be enabled to feed the 
chip, though).
>
> If so, we need to make sure it's not currently called in an atomic
> context, because it would break if the function will sleep in the
> future. And with "make sure" I just mean that we check the code and keep
> it in mind. Or perhaps adding a comment in the header, that says
> "audio_enable may sleep, other audio functions do not sleep" or such.

I revisited the ALSA code. Only the audio_start function is atomic. 
Although ALSA may not be the only user, it makes sense to me to think 
that they will follow a similar approach in terms of locks.

Hence, based on that and on the reasons you describe (audio_enable 
potentially taking too long to return), Rephrasing what you stated, a 
mutex may be used for the enable/disable and config operations. Only 
start/stop would be protected by a spinlock. This should be described in 
comments in the header file. Does it make sense to you?

BR,

Ricardo
>
>   Tomi

