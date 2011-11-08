From: David Anders <x0132446-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] omap4: i2c: add post idle reset registers flag
Date: Tue, 8 Nov 2011 11:17:19 -0600
Message-ID: <4EB9641F.3060606@ti.com>
References: <1320701500-14535-1-git-send-email-x0132446@ti.com> <4EB8E445.4050604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EB8E445.4050604-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: danders.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, aneesh-l0cyMroinI0@public.gmane.org, jayabharath-l0cyMroinI0@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/08/2011 02:11 AM, Shubhrajyoti wrote:
> On Tuesday 08 November 2011 03:01 AM, David Anders wrote:
>    
>> omap44xx i2c devices need to have the registers reset post idle
>> similar to omap3xxx devices. this adds the additional flag for
>> OMAP_I2C_FLAG_RESET_REGS_POSTIDLE to the omap44xx i2c_dev_attr.
>>      
> Hello Anders a similar patch is already posted
> http://www.spinics.net/lists/linux-i2c/msg05913.html
>
>    

oops, i did a quick search of the mailing lists but didn't see your 
patch, so submitted this one.

are you going to babysit this one through?

>> Signed-off-by: David Anders<x0132446-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 7695e5d..e93dc40 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -2257,7 +2257,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>>   };
>>
>>   static struct omap_i2c_dev_attr i2c_dev_attr = {
>> -	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
>> +	.flags	= OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
>> +		  OMAP_I2C_FLAG_BUS_SHIFT_NONE,
>>   };
>>
>>   /* i2c1 */
>>      
>    

Dave
