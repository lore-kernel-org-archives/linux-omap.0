From: "nick loeve" <trickie@gmail.com>
Subject: Re: [PATCH] Fix n800 build - only register HW keyboard on i2c board if CONFIG_MACH_NOKIA_N810
Date: Fri, 2 May 2008 15:24:05 +0200
Message-ID: <83c2b2e00805020624vdad215er5bce9d082e2488e9@mail.gmail.com>
References: <1209733535-31057-1-git-send-email-trickie@gmail.com>
	 <63caa47ab5fe77c2addd937c3c1459c1@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:44817 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762293AbYEBNYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 09:24:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so941057fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 02 May 2008 06:24:05 -0700 (PDT)
In-Reply-To: <63caa47ab5fe77c2addd937c3c1459c1@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, May 2, 2008 at 3:17 PM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Fri,  2 May 2008 15:05:35 +0200, trickie@gmail.com wrote:
>> lm8323_pdata is only present if CONFIG_MACH_NOKIA_N810
>
> that's true but CONFIG_MACH_NOKIA_N810 is always true
> if you use n800_defconfig.

Yes true. I have been playing with a custom .config based on Tony's
experiments here: http://www.muru.com/linux/n8x0/ but for my n800
only.

Hence I noticed this if CONFIG_MACH_NOKIA_N810 is not defined.

>
> Anyways, good catch.
>
>> Signed-off-by: Nick Loeve <trickie@gmail.com>
>> ---
>>  arch/arm/mach-omap2/board-n800.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-n800.c
>> b/arch/arm/mach-omap2/board-n800.c
>> index 8b5956b..b62f2d5 100644
>> --- a/arch/arm/mach-omap2/board-n800.c
>> +++ b/arch/arm/mach-omap2/board-n800.c
>> @@ -654,12 +654,14 @@ static struct i2c_board_info __initdata
>> n800_i2c_board_info_2[] = {
>>               I2C_BOARD_INFO("tea5761", 0x10),
>>       },
>>  #endif
>> +#ifdef CONFIG_MACH_NOKIA_N810
>>       {
>>               I2C_BOARD_INFO("lm8323", 0x45),
>>               .type           = "lm8323",
>>               .irq            = OMAP_GPIO_IRQ(109),
>>               .platform_data  = &lm8323_pdata,
>>       },
>> +#endif
>>       {
>>               I2C_BOARD_INFO("tsl2563", 0x29),
>>               .type           = "tsl2563",
>> --
>> 1.5.5.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
>



-- 
Nick Loeve
