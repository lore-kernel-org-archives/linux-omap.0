From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
Date: Wed, 11 Jan 2012 11:36:23 +0530
Message-ID: <4F0D26DF.1020108@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>	<1323773758-6375-5-git-send-email-shubhrajyoti@ti.com>	<alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>	<4EEB086A.2050607@ti.com>	<CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>	<CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com> <87hb03tw8h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87hb03tw8h.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 January 2012 08:56 PM, Kevin Hilman wrote:
> "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>
>> On Tue, Jan 10, 2012 at 11:53 AM, Datta, Shubhrajyoti
>> <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>>
>>> On Fri, Dec 16, 2011 at 2:29 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>>>> Ben,
>>>>
>>>> On Friday 16 December 2011 02:10 PM, Paul Walmsley wrote:
>>>>> Hi
>>>>>
>>>>> On Tue, 13 Dec 2011, Shubhrajyoti D wrote:
>>>>>
>>>>>> -  The reset in the driver at init is not needed anymore as the
>>>>>>    hwmod framework takes care of reseting it.
>>>>>> -  Reset is removed from omap_i2c_init, which was called
>>>>>>    not only during probe, but also after time out and error handling.
>>>>>>    device_reset were added in those places to effect the reset.
>>>>>> -  Earlier the hwmod SYSC settings were over-written in the driver.
>>>>>>    Removing the same and letting the hwmod take care of the settings.
>>>>>> -  Clean up the SYSS_RESETDONE_MASK macro as it is no longer needed.
>>>>>> -  Clean up the SYSCONFIG SYSC bit definition macros.
>>>>>> -  Fix the typos in wakeup.
>>>>>>
>>>>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>>>>> ---
>>>>>>  drivers/i2c/busses/i2c-omap.c |   83 +++++++++++-----------------------------
>>>>>>  1 files changed, 23 insertions(+), 60 deletions(-)
>>>>> This patch either needs to be acked by Ben with a note that it's okay for
>>>>> us to merge through the OMAP tree, or needs to be merged by Ben during the
>>>>> 3.4 merge window, after patches 1-3 have reached the mainline tree.
>>>> I agree.
>>>> Ben do you have any comments .
>>>
>> If there are no further comments can this be merged also ?
> As Benoit mentioned earlier, the addition of new pdata fields will cause
> problems with the DT support already queued for v3.3.
>
> This series should be reworked on top of the DT support which Ben has
> now queued for v3.3 (my branch: for_3.3/i2c/misc)

Yes will rework it.
> Kevin
