From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
Date: Fri, 08 Nov 2013 10:51:11 -0800
Message-ID: <87wqkiafs0.fsf@linaro.org>
References: <1383863549-7438-1-git-send-email-zonque@gmail.com>
	<87siv7pxpp.fsf@linaro.org> <527C6F70.1010103@ti.com>
	<CAGa+x85W_N9FCYu=dWTG8OgURr9Fo6oZ2KpW_XY9j_xZr8bBrg@mail.gmail.com>
	<527D0DE6.6090506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54600 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039Ab3KHSvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Nov 2013 13:51:15 -0500
Received: by mail-pd0-f177.google.com with SMTP id p10so2486676pdj.8
        for <linux-omap@vger.kernel.org>; Fri, 08 Nov 2013 10:51:14 -0800 (PST)
In-Reply-To: <527D0DE6.6090506@ti.com> (Joel Fernandes's message of "Fri, 8
	Nov 2013 10:14:30 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Gururaja Hebbar <gururaja.hebbar@ti.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Russ Dill <Russ.Dill@ti.com>, Nishanth Menon <nm@ti.com>, Vaibhav Bedia <vaibhav.bedia@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Joel Fernandes <joelf@ti.com> writes:

> On 11/08/2013 12:28 AM, Kevin Hilman wrote:
> [..]
>>>> Also, I believe it was already suggested by Nishanth, but the late/early
>>>> callbacks are probably more appropriate here than the noirq callbacks.
>>>> Unless there's a *really* good reason to use the noirq callbacks, they
>>>> should be avoided.
>>>>
>>>> That being said, I wonder if the whole approach here is the right one.
>>>> I know you're basing your stuff on some TI tree, but that doesn't make
>>>> it the right way (usually, it's the opposite, but I digress...)  ;)
>>>>
>>>> IMO, EDMA should be done like we currently do I2C and not implement
>>>> suspend/resume at all.  Instead, the driver should do runtime PM done on
>>>
>>> But a potential problem with this is powering edma on or off between xfers may
>>> slow things down quite a bit because xfers happen so much often and there is
>>> some overhead in the pm_runtime calls which adds up overtime when dealing with
>>> something as frequent as EDMA. Also we would lose the global EDMA context right
>>> so we'd have to restore the context every time during runtime PM (?).
>> 
>> Have a look at the autosuspend feature of runtime PM.  (c.f.
>> Documentation/power/pm_runtime.txt)
>
> Sure, will do that. Thanks :)
>
> Just one more silly question, in very frequent operations is there no over-head
> even when using autosuspend? Because when I traced last time (without
> autosuspend), the depth of pm runtime calls were quite a lot but this could also
> be because of the OMAP implementation.

The depth of calls is shallow until it's actually time to really runtime
suspend (after the autosuspend timeout.)  IOW, you don't even get into
OMAP specific code until the autosuspend timeout expires, so the
overhead is only coming from the runtime PM core, and is very minimal.

We're already using this technique in the I2C driver which typically has
less data than EDMA, but does have frequent, bursty xfers.

Kevin
