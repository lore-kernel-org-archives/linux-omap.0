From: "nick loeve" <trickie@gmail.com>
Subject: Re: [PATCH] Fix n800 build - Remove kernel config conditional declaration of TSC2005 device config structures
Date: Mon, 26 May 2008 08:35:57 +0200
Message-ID: <83c2b2e00805252335v41da39b9n9e0ab71fd8f0fb5@mail.gmail.com>
References: <1211705141-12878-1-git-send-email-trickie@gmail.com>
	 <20080525085358.GC25784@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:18344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbYEZGf7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 May 2008 02:35:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1147085fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 25 May 2008 23:35:57 -0700 (PDT)
In-Reply-To: <20080525085358.GC25784@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

Hi Felipe

On Sun, May 25, 2008 at 10:53 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sun, May 25, 2008 at 10:45:41AM +0200, trickie@gmail.com wrote:
>>
>> Signed-off-by: Nick Loeve <trickie@gmail.com>
>> ---
>>  arch/arm/mach-omap2/board-n800.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
>> index ae85c2c..f902482 100644
>> --- a/arch/arm/mach-omap2/board-n800.c
>> +++ b/arch/arm/mach-omap2/board-n800.c
>> @@ -372,7 +372,6 @@ static struct omap2_mcspi_device_config cx3110x_mcspi_config = {
>>       .single_channel = 1,
>>  };
>>
>> -#ifdef CONFIG_TOUCHSCREEN_TSC2005
>>  static struct tsc2005_platform_data tsc2005_config = {
>>       .reset_gpio = 94,
>>       .dav_gpio = 106
>> @@ -382,7 +381,6 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
>>       .turbo_mode     = 0,
>>       .single_channel = 1,
>>  };
>> -#endif
>
> This one i think it should remain the way it is. I'm wondering if it'll
> generate warnings in any way.

I didn't notice any, but then i didn't test it much...

>
> Could you try something?
>
> Remove also the CONFIG_TOUCHSCREEN_TSC2301. And try building n800/n810,
> n800-only and n810-only. Also flash and boot test them, please.
>
> If you don't get any warnings and no errors. I'm ok with this patch when
> you remove also the TSC2301 ifdef.

Sure, i can try. I only have a n800 to test on though... but i will
try anyway. Pretty busy this week, but i will get to it.

Cheers

>
> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>



-- 
Nick Loeve
