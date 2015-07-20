From: Adam Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] [TWL4030 MADC] Fix ADC[3:6] readings
Date: Mon, 20 Jul 2015 11:23:46 -0700
Message-ID: <CAFeBWL4dEZ09UdNH6moDzDy8S+2w7XpM6vWcK6yVW++H7qZTjA@mail.gmail.com>
References: <1437085227-28845-1-git-send-email-adam.yh.lee@gmail.com>
	<1437085227-28845-2-git-send-email-adam.yh.lee@gmail.com>
	<20150717090039.GC9331@earth>
	<alpine.DEB.2.02.1507171136180.14972@pmeerw.net>
	<CAFeBWL6ARBReHq8jom3kGu3iOaPib41nOJ3-gx358nYwsGKLfw@mail.gmail.com>
	<55AD35D1.7000607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55AD35D1.7000607-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello Jonathan, I sent the same patch with linux-iio cc'd.
I expanded the cover letter with the quotes from TI's documents, but
the text has been removed in the email somehow.
The discussion in this thread should be enough (I think) for linux-iio
maintainers, so we will see!

Thanks,

Adam

On Mon, Jul 20, 2015 at 10:54 AM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On 20/07/15 18:47, Adam Lee wrote:
>> Hello, here is some more context from the TPS65950's TRM [1].
>>
>> Quoting from section 15.3.1.2.1 VUSB3V1 section:
>>
>>     "VUSB3V1 is also used to bias analog multiplexers on the four MCPC
>> pins between the carkit and the MADC (supplied by VINTANA2)."
>>
>>
>> And from section 15.4.11. MADC Monitoring Using MCPC:
>>
>>     "Four MCPC pins can be selected as analog conversion input pins by
>> setting the CARKIT_ANA_CTRL[3] SEL_MADC_MCPC bit."
>>
>> My patch addresses both (set the register, and enable 3v1). And yes it
>> has been tested on Gumstix Overo COMs (OMAP3 + TPS65950).
>>
>> Hope to hear from IIO maintainers!
> I dug the patch out of the archives.
>
> Looks clear enough to me.  Could you resend the patch with linux-iio cc'd?
> I will want an Ack from Sebastian.
>
> Thanks,
>
> Jonathan
>
>>
>> [1] http://www.droid-developers.org/images/2/21/Tps65950_TRM.pdf
>>
>> On Fri, Jul 17, 2015 at 2:42 AM, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org> wrote:
>>> Hello,
>>>
>>> adding linux-iio...
>>>
>>>> To get a chance of this patch being considered for inclusion, you
>>>> should send this to the maintainers of the phy and iio framework.
>>>> There is a high chance, that none of them will see your mail.
>>>>
>>>> On Thu, Jul 16, 2015 at 03:20:27PM -0700, Adam YH Lee wrote:
>>>>> MADC[3:6] reads incorrect values without these two following changes:
>>>>
>>>> uhm MADC[3:6] are externally available analog inputs. Your
>>>> change will result in them being tied to the USB module.
>>>
>>> change regarding TWL4030_USB_SEL_MADC_MCPC is necessary at
>>> least for some hardware revisions to get proper ADC values
>>>
>>>>> - enable the 3v1 bias regulator for ADC[3:6]
>>>>
>>>> The regulator is not required for correct MADC functionality, but
>>>> for correct USB measureing. The regulator should not be requested
>>>> by the madc module, but by the usb module, which is connected to
>>>> the madc.
>>>
>>> in my experience, the MADC exhibits several strange things, I wouldn't be
>>> surprised that this bias is somehow necessary for operation even if it is
>>> not what the spec says -- has this been tested?
>>>
>>>>> - configure ADC[3:6] lines as input, not as USB
>>>>
>>>> I don't think that should be done for all boards.
>>>>
>>>>> [...]
>>>>
>>>> -- Sebastian
>>>>
>>>
>>> --
>>>
>>> Peter Meerwald
>>> +43-664-2444418 (mobile)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
