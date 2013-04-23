From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] OMAP: fix boot sequence
Date: Tue, 23 Apr 2013 20:50:52 +0300
Message-ID: <5176C9FC.4080306@ti.com>
References: <1366723151-23209-1-git-send-email-grygorii.strashko@ti.com> <20130423173442.GF10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130423173442.GF10155-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/23/2013 08:34 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [130423 06:25]:
>> Hi
>>
>> There are two public discussions now related to OMAP boot and drivers
>> initialization issues:
>> "Multiple issues with omap4 panda es in linux next"
>>    http://www.spinics.net/lists/linux-omap/msg90241.html
>> "[BUG] omap: mfd/regulator: twl/core: init order"
>>    http://www.spinics.net/lists/linux-omap/msg89980.html
>>
>> In both cases there are pinctrl-single/I2C/MFD/Regulators initailization issue:
>> - regulators are not initialized because of twl,
>> - twl is not initialized because of I2C,
>> - I2C is not initialized because of pinctrl-single,
>> - pinctrl-single is initialized at mudule/device init time.
>> So, most everything will be shifted at late_initcall time.
>>
>> This may cause boot delay (more over, it can broken initialization of drivers
>> which are not ready to use deferred probe mechanism yet, for example DSS).
>>
>> Introduced pathes shift I2C and TWL iniialization to module/device init layer
>> instead of subsys init layer where initialization dependencies resolved
>> indirectly in drivers/Makefile now.
>>
>> Grygorii Strashko (2):
>>    i2c: omap: convert to module_platform_driver()
>>    mfd: twl-core: convert to module_i2c_driver()
>>
>>   drivers/i2c/busses/i2c-omap.c |   14 +-------------
>>   drivers/mfd/twl-core.c        |   12 +-----------
>>   2 files changed, 2 insertions(+), 24 deletions(-)
> Thanks, I have few questions:
>
> 1. It seems that the real fix to the issues we're seeing
>     is to make the broken drivers to support -EPROBE_DEFER?
yes.
>
> 2. If so, can these be merged later on as clean-up?
if i understand Tomi correctly, he has problems with DSS updating to use
  -EPROBE_DEFER, so this is rather fix than clean-up.
But need confirmation that it's true from him.
>
> 3. Can these two patches be merged separately without
>     breaking things?
I think, yes.
>
> Regards,
>
> Tony
