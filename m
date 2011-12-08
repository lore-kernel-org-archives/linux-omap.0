From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c_omap: correct OMAP_I2C_SYSC_REG offset
Date: Thu, 8 Dec 2011 13:31:29 -0600
Message-ID: <4EE11091.20404@ti.com>
References: <1323355433-8508-1-git-send-email-a.aring@phytec.de> <87obvjj5l5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87obvjj5l5.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Alexander Aring <a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On 12/8/2011 12:12, Kevin Hilman wrote:
> Alexander Aring<a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>  writes:
>
>> Correct OMAP_I2C_SYSC_REG offset in omap4 register map.
>> Offset 0x20 is reserved and OMAP_I2C_SYSC_REG has 0x10 as offset.
>>
>> Signed-off-by: Alexander Aring<a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
>
> Thanks for the patch!
>
> A different approach to fix this is being done by Shubhrajyoti[1] as
> part of his reset series.
>
> However, I think we should probably apply this patch for v3.2 and also
> send to the stable kernel for v3.0&  v3.1.
>
> Shubhrajyoti/Jon, any objections to me queuing this fix for v3.2 (and
> stable.)  It would just mean rebasing your other fixes and cleanup
> series on top of this.

I have no issue with that and I am in favour of getting the fix in now.

Cheers
Jon

>
>> ---
>>   drivers/i2c/busses/i2c-omap.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index a43d002..fc3bb37 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -235,7 +235,7 @@ static const u8 reg_map_ip_v2[] = {
>>   	[OMAP_I2C_BUF_REG] = 0x94,
>>   	[OMAP_I2C_CNT_REG] = 0x98,
>>   	[OMAP_I2C_DATA_REG] = 0x9c,
>> -	[OMAP_I2C_SYSC_REG] = 0x20,
>> +	[OMAP_I2C_SYSC_REG] = 0x10,
>>   	[OMAP_I2C_CON_REG] = 0xa4,
>>   	[OMAP_I2C_OA_REG] = 0xa8,
>>   	[OMAP_I2C_SA_REG] = 0xac,
