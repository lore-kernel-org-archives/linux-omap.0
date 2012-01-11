From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Wed, 11 Jan 2012 15:23:44 +0100
Message-ID: <4F0D9B70.3000309@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com> <4EEB086A.2050607@ti.com> <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com> <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com> <87hb03tw8h.fsf@ti.com> <4F0D26DF.1020108@ti.com> <alpine.DEB.2.00.1201110619090.31702@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1201110619090.31702-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 1/11/2012 2:29 PM, Paul Walmsley wrote:
> On Wed, 11 Jan 2012, Shubhrajyoti wrote:
>
>> On Tuesday 10 January 2012 08:56 PM, Kevin Hilman wrote:
>>> "Datta, Shubhrajyoti"<shubhrajyoti-l0cyMroinI0@public.gmane.org>  writes:
>>>
>>>> On Tue, Jan 10, 2012 at 11:53 AM, Datta, Shubhrajyoti
>>>> <shubhrajyoti-l0cyMroinI0@public.gmane.org>  wrote:
>>>>>
>>>>> On Fri, Dec 16, 2011 at 2:29 PM, Shubhrajyoti<shubhrajyoti-l0cyMroinI0@public.gmane.org>  wrote:
>>>>>> On Friday 16 December 2011 02:10 PM, Paul Walmsley wrote:
>>>>>>
>>>>>>> This patch either needs to be acked by Ben with a note that it's okay for
>>>>>>> us to merge through the OMAP tree, or needs to be merged by Ben during the
>>>>>>> 3.4 merge window, after patches 1-3 have reached the mainline tree.
>>>>>> I agree.
>>>>>> Ben do you have any comments .
>>>>>
>>>> If there are no further comments can this be merged also ?
>>> As Benoit mentioned earlier, the addition of new pdata fields will cause
>>> problems with the DT support already queued for v3.3.
>>>
>>> This series should be reworked on top of the DT support which Ben has
>>> now queued for v3.3 (my branch: for_3.3/i2c/misc)
>>
>> Yes will rework it.
>
> Depending on what you plan to do, you'll probably need to coordinate this
> with Tony also.  He's already pulled some of the patches from this series
> into his i2c branch.
>
> The real question is how you plan to handle the device reset function,
> given that the driver should compile on a non-OMAP build (meaning that you
> can't call omap_device*() functions from the driver directly), nor should
> the driver touch the SYSCONFIG register directly.

Something that puzzle me on that point is most architecture does not use 
plateform_device and thus does not have any pdata to hack some custom 
function pointers here an there.
It means that there is probably some better solution to handle that.

AFAIU, the way PPC is handling that is by splitting the driver in a 
generic part and in a platform specific part.

You can then add any OMAP specific hacks in the OMAP specific part while 
keeping most of generic code in a generic driver.

In this case, we just have to implement a small shim that will handle 
the OMAP specific code for the reset. The generic driver will handle the 
rest.

Maybe I'm missing some important details, but that does seems easily 
doable for the i2c case.

Regards,
Benoit
