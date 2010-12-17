From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
Date: Fri, 17 Dec 2010 15:59:00 +0100
Message-ID: <AANLkTimYoa3baXbcwOOx-xXLXiEbKmiEWj1xR3xVCC=+@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<1292580506-4421-3-git-send-email-j-pihet@ti.com>
	<4D0B66ED.8030302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62282 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0LQO7B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 09:59:01 -0500
Received: by qyk12 with SMTP id 12so884734qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 06:59:01 -0800 (PST)
In-Reply-To: <4D0B66ED.8030302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Nishant,

On Fri, Dec 17, 2010 at 2:34 PM, Nishanth Menon <nm@ti.com> wrote:
> jean.pihet@newoldbits.com had written, on 12/17/2010 04:08 AM, the
> following:
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The SRAM PA addresses are locally defined and used at
>> different places, i.e. SRAM management code and idle sleep code.
>>
>> The macros are now defined at a centralized place, for
>> easier maintenance.
>>
>> Tested on N900 and Beagleboard with full RET and OFF modes,
>> using cpuidle and suspend.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/sdrc.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
>> =A0arch/arm/mach-omap2/sleep34xx.S =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0arch/arm/plat-omap/include/plat/sram.h | =A0 11 +++++++++++
>> =A0arch/arm/plat-omap/sram.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 +=
+-----
>> =A04 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
>> index 68f57bb..b3f8379 100644
>> --- a/arch/arm/mach-omap2/sdrc.h
>> +++ b/arch/arm/mach-omap2/sdrc.h
>> @@ -74,5 +74,4 @@ static inline u32 sms_read_reg(u16 reg)
>> =A0*/
>> =A0#define SDRC_MPURATE_LOOPS =A0 =A0 =A0 =A0 =A0 =A0 96
>> =A0-
>
> spurious change.
Cosmetic change!

>
> [...]
>
>> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
>> index 819ea0c..1a686c8 100644
>> --- a/arch/arm/plat-omap/sram.c
>> +++ b/arch/arm/plat-omap/sram.c
>> @@ -41,15 +41,12 @@
>> =A0#define OMAP1_SRAM_PA =A0 =A0 =A0 =A0 0x20000000
>> =A0#define OMAP1_SRAM_VA =A0 =A0 =A0 =A0 =A0VMALLOC_END
>> -#define OMAP2_SRAM_PA =A0 =A0 =A0 =A0 =A00x40200000
>> -#define OMAP2_SRAM_PUB_PA =A0 =A0 =A00x4020f800
>> +#define OMAP2_SRAM_PUB_PA =A0 =A0 =A0(OMAP2_SRAM_PA + 0xf800)
>> =A0#define OMAP2_SRAM_VA =A0 =A0 =A0 =A0 =A00xfe400000
>> =A0#define OMAP2_SRAM_PUB_VA =A0 =A0 =A0(OMAP2_SRAM_VA + 0x800)
>> -#define OMAP3_SRAM_PA =A0 =A0 =A0 =A0 =A0 0x40200000
>> =A0#define OMAP3_SRAM_VA =A0 =A0 =A0 =A0 =A0 0xfe400000
>> -#define OMAP3_SRAM_PUB_PA =A0 =A0 =A0 0x40208000
>> +#define OMAP3_SRAM_PUB_PA =A0 =A0 =A0 (OMAP3_SRAM_PA + 0x8000)
>
> Though not directly related to the patch, information sake: the PUB p=
hysical
> address on a GP device !=3D public SRAM address on a HS/EMU device - =
in theory
> PPA can reconfigure how much is available for a HS/EMU device here.
Ok good to know.

>
>> =A0#define OMAP3_SRAM_PUB_VA =A0 =A0 =A0 (OMAP3_SRAM_VA + 0x8000)
>> -#define OMAP4_SRAM_PA =A0 =A0 =A0 =A0 =A00x40300000
>> =A0#define OMAP4_SRAM_VA =A0 =A0 =A0 =A0 =A00xfe400000
>> =A0#define OMAP4_SRAM_PUB_PA =A0 =A0 =A0(OMAP4_SRAM_PA + 0x4000)
>> =A0#define OMAP4_SRAM_PUB_VA =A0 =A0 =A0(OMAP4_SRAM_VA + 0x4000)
>
> Tested-by: Nishanth Menon<nm@ti.com>
> Tested on:
> SDP3630
> SDP3430
> Test script:
> http://pastebin.mozilla.org/889933
Nice test script btw

>
> --
> Regards,
> Nishanth Menon
>

Thanks!
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
