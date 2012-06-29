From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP: fix runtime PM get/put balance on error
Date: Fri, 29 Jun 2012 09:00:48 -0500
Message-ID: <87395emd4f.fsf@ti.com>
References: <1340960868-7371-1-git-send-email-shubhrajyoti@ti.com>
	<874npunx6a.fsf@ti.com> <4FEDA5C2.3000905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FEDA5C2.3000905-l0cyMroinI0@public.gmane.org> (shubhrajyoti-l0cyMroinI0@public.gmane.org's message of "Fri,
	29 Jun 2012 18:25:30 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> On Friday 29 June 2012 05:32 PM, Kevin Hilman wrote:
>> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>>
>>>     ensure pm_runtime_put() is called, on pm_runtime_get_sync()
>>>     failure.
>>>
>>>     Without this, after a failed call, the runtime PM usecount will have
>>>     been incremented, but not decremented causing the usecount to never
>>>     reach zero after a failure. Thanks to Kevin for educating about it. 
>>>     While at it also fix a missing pm_runtime_disable in the probe error
>>>     path.
>> This is the same subject and changelog as the patch I sent, but is a
>> different patch.  
>>
>> Please write a new subject and a changelog specific to your patch.
> OK.
> Actually I did that on purpose your patch fixed the xfer call only.
> I thought that since get_sync increments the count always we could extend
> the patch to all the callers.
>>
>> As this changes the error/failure path, please be specific about how
>> the failure modes were tested, and on which platforms.
> I found and fixed by review only.
> Didnt really hit the failure case.

Which is why you should't just add stuff to other peoples work.

My patch was targetted at the XFER problem during suspend/resume which I
found by testing and and proved the fix by testing.

Your patch adds several additional functional changes that were not well
described and not tested.  That calls for a separate patch with seprate
subject/changelog etc.

Kevin
