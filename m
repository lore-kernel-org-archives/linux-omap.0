From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix driver path in file comment
Date: Mon, 25 Apr 2016 13:00:40 -0400
Message-ID: <571E4D38.8060508@osg.samsung.com>
References: <1461101066-27753-1-git-send-email-javier@osg.samsung.com>
 <20160425140934.GG2713@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160425140934.GG2713@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hello Lee,

On 04/25/2016 10:09 AM, Lee Jones wrote:
> On Tue, 19 Apr 2016, Javier Martinez Canillas wrote:
> 
>> The driver's file path in the comment is wrong, use the correct one.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>>  drivers/mfd/twl4030-power.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
>> index 04b539850e72..f832233fd365 100644
>> --- a/drivers/mfd/twl4030-power.c
>> +++ b/drivers/mfd/twl4030-power.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * linux/drivers/i2c/chips/twl4030-power.c
>> + * linux/drivers/mfd/twl4030-power.c
> 
> These have a nasty habit of getting out of date, and since they serve
> very little purpose, I'd prefer it if you just removed the line
> completely.
> 

Ok, I'll post a v2 just removing it then.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
