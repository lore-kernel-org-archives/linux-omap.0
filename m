From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] I2C: OMAP: Recover from Bus Busy condition
Date: Thu, 12 Jan 2012 11:37:30 +0530
Message-ID: <4F0E78A2.6050900@ti.com>
References: <1326303693-30106-1-git-send-email-shubhrajyoti@ti.com> <87vcoh27sr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vcoh27sr.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 12 January 2012 03:58 AM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>
>> From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>>
>> In case a peripheral is driving SDA bus low (ie. a start condition), provide
>> a constant clock output using the test mode of the OMAP I2C controller to
>> try and clear the bus. Soft reset I2C controller after attempting the bus clear
>> to ensure that controller is in a good state.
>>
>> Based upon Vikram Pandita's patch from TI Android 3.0 kernel and modified for
>> mainline by Jon Hunter. 
>>
>> A couple differences from the original patch ...
>> 1. Add a new function for bus clear
>> 2. Ensure that the CON.I2C_EN bit is set when using the SYSTEST feature to
>>    output a permanent clock. This bit needs to be set and tpyically it would
>>    be set by the unidle function but this is not the case for all OMAP
>>    generations.
>> 3. Program the SYSTEST setting only the bits we care about. However, restore
>>    SYSTEST registers to there original state as some OMAP generations do not
>>    implement perform a soft-reset.
>> 4. Clear the CON register after performing the bus clear, so when we call the
>>    init function the controller is disabled and the init function will
>>    re-enable later.
>>
>> Cc:  Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>> Original patch can be found here:
>> http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=a2ab04192ba25e60f95ba1ff3af5601a2d7b5bd1
>> applies on Kevin's for_3.3/i2c/misc
> Please also explain how this was tested, and on what platforms.

Please ignore will  resend.
> Thanks,
>
> Kevin
