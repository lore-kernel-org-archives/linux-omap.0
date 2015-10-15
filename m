From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] arm, omap2, sram: On HS/EMU devices, only 64K internal
 SRAM is available.
Date: Thu, 15 Oct 2015 05:57:13 +0200
Message-ID: <561F2419.3020201@denx.de>
References: <1444715655-30077-1-git-send-email-hs@denx.de>
 <20151014174920.GE10113@atomide.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151014174920.GE10113@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Ayoub Zaki <Ayoub.Zaki@bosch-si.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Georg.Soffel@bosch-si.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Tony,

Am 14.10.2015 um 19:49 schrieb Tony Lindgren:
> * Heiko Schocher <hs@denx.de> [151012 22:58]:
>> Of this, secure content (including PPA) uses initial
>> portion of the SRAM. This chunk is not (and shouldn't
>> be) accessible from the public code.
>>
>> The minimum size of this chunk (0x350) is used in this
>> patch. Available size is rounded off to 63K.
>>
>> Both values would require a change if size of secure
>> content grows beyond 0x350.
>
> Makes sense to me. And something similar is needed at least for
> dm814x to get rid of the imprecise abort during boot with
> commit bbeb92095159 ("ARM: 8422/1: enable imprecise aborts during
> early kernel startup") applied.
>
> Is this needed as a fix to the -rc cycle, or can this wait for
> v4.4?

I need it for an upcoming boards support, so 4.4 is fine for me,
thanks!

bye,
Heiko
>
> Regards,
>
> Tony
>
>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Signed-off-by: Ayoub Zaki <Ayoub.Zaki@bosch-si.com>
>> ---
>>
>>   arch/arm/mach-omap2/sram.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
>> index cd488b8..2e7c00f 100644
>> --- a/arch/arm/mach-omap2/sram.c
>> +++ b/arch/arm/mach-omap2/sram.c
>> @@ -47,6 +47,28 @@
>>
>>   #define GP_DEVICE		0x300
>>
>> +/**
>> + * Size of chunk used by secure content in the HS/EMU devices.
>> + *
>> + * This size is not fixed. It depends upon the implementation of PPA.
>> + * May need to be modified if the size grows.
>> + */
>> +#define AM33XX_HS_HEADER_SIZE   0x0350
>> +
>> +/**
>> + * Start of public SRAM on HS/EMU devices.
>> + */
>> +#define AM33XX_SRAM_PA		0x40300000
>> +#define AM33XX_SRAM_PUB_PA	(AM33XX_SRAM_PA + AM33XX_HS_HEADER_SIZE)
>> +
>> +/**
>> + * Size of public SRAM available on HS/EMU devices.
>> + *
>> + * This size also depends upon AM33XX_HS_HEADER_SIZE.
>> + * Current value is derived from nearest round-off.
>> + */
>> +#define AM33XX_SRAM_PUB_SIZE		0xfc00	/* 63K */
>> +
>>   #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
>>
>>   static unsigned long omap_sram_start;
>> @@ -99,6 +121,9 @@ static void __init omap_detect_sram(void)
>>   			} else {
>>   				omap_sram_size = 0x8000; /* 32K */
>>   			}
>> +		} else if (soc_is_am33xx()) {
>> +			omap_sram_start = AM33XX_SRAM_PUB_PA;
>> +			omap_sram_size  = AM33XX_SRAM_PUB_SIZE;
>>   		} else {
>>   			omap_sram_start = OMAP2_SRAM_PUB_PA;
>>   			omap_sram_size = 0x800; /* 2K */
>> --
>> 2.1.0
>>
>

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
