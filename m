From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Fri, 14 Sep 2012 16:10:41 +0530
Message-ID: <505309A9.8030808@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com> <20120912131615.GB16547@pengutronix.de> <87pq5quaqr.fsf@deeprootsystems.com> <87wqzysuu3.fsf@deeprootsystems.com> <87sjaldcjp.fsf@deeprootsystems.com> <20120913183705.GA17430@arwen.pp.htv.fi> <87txv1bokd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87txv1bokd.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 14 September 2012 02:58 AM, Kevin Hilman wrote:
> Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>
>> Hi,
>>
>> On Thu, Sep 13, 2012 at 11:04:42AM -0700, Kevin Hilman wrote:
>>> Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> writes:
>>>
>>>> Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> writes:
>>>>
>>> [...]
>>>
>>>>> Sorry to be late to the party (again), but still catching up after some
>>>>> time off.
>>>>>
>>>>> Unfortunately, this series causes PM regressions on several OMAP
>>>>> platforms.  I hope we can hold off on this until those issues are
>>>>> addressed.
>>>> I tracked the regression down to [PATCHv8 21/22] (see reply there.)
>>>>
>>>> Since this series is already merged, I suggest that the problem patch be
>>>> reverted, at least for v3.7 and until the problem is better understood
>>>> and tested.
>>>>
>>>> With that patch reverted, all my PM tests are passing.  Feel free to
>>>> add:
>>> OK, the i2c series is off the hook.
>>>
>>> Felipe and I spent a little time tracking this down.  Felipe suggested
>>> that there might be a driver with periodic i2c activity keeping I2C
>>> awake, and thus preventing CORE retention.  He was right.
>> FYI, the original idea came from Shubhro. We agreed that would be the
>> only way i2c would be prevented from idling.
> Great, thanks Shubhro!
>
> Also, FYI, I just submitted a patch to the TWL RTC driver which was the
> source of all the I2C activity since it's on the I2C-connected PMIC.
>
> Thanks for the help and suggestions,
>
> Kevin
>
> [1] https://groups.google.com/forum/#!topic/rtc-linux/sFbYmAzCRLQ
Thanks for the testing and the patch.
