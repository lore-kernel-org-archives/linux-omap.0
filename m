From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
Date: Fri, 17 Dec 2010 11:13:33 +0100
Message-ID: <AANLkTi=uBwKt1Y_8tsRZoM2DmrTh9Tu-=h+LGHina90Z@mail.gmail.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
	<1292521858-3810-3-git-send-email-j-pihet@ti.com>
	<252f6bd3f3d077d771418d374eee173d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47675 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab0LQKNd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 05:13:33 -0500
Received: by qwa26 with SMTP id 26so504312qwa.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:13:33 -0800 (PST)
In-Reply-To: <252f6bd3f3d077d771418d374eee173d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

Hi Santosh,

On Fri, Dec 17, 2010 at 5:48 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
>> Sent: Thursday, December 16, 2010 11:21 PM
>> To: linux-omap@vger.kernel.org
>> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.or=
g;
>> Jean Pihet
>> Subject: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addre=
sses
>>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The SRAM PA addresses are locally defined and used in both the
>> SRAM management code and the idle sleep code.
>> A global macro defines the values at a centralized place, for
>> easier maintenance.
>>
>> Tested on N900 and Beagleboard with full RET and OFF modes,
>> using cpuidle and suspend.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/sdrc.h | =A0 =A07 +++++++
>> =A0arch/arm/plat-omap/sram.c =A0| =A0 =A07 ++-----
>> =A02 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
>> index 68f57bb..ada596b 100644
>> --- a/arch/arm/mach-omap2/sdrc.h
>> +++ b/arch/arm/mach-omap2/sdrc.h
>> @@ -74,5 +74,12 @@ static inline u32 sms_read_reg(u16 reg)
>> =A0 */
>> =A0#define SDRC_MPURATE_LOOPS =A0 =A0 =A0 =A0 =A0 96
>>
>> +/*
>> + * OMAP2+: define the SRAM PA addresses.
>> + * Used by the SRAM management code and the idle sleep code.
>> + */
>> +#define OMAP2_SRAM_PA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40200000
>> +#define OMAP3_SRAM_PA =A0 =A0 =A0 =A0 =A0 0x40200000
>> +#define OMAP4_SRAM_PA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40300000
>>
> Header choice is wrong. Certainly SDRC is not the place.
> Right place should be "#include <plat/sram.h>"
> OMAP4 doesn't even have SDRC IP
This is correct
=46urthermore it would have broken the OMAP1 build since sdrc.h is only
included for OMAP2 & 3.

Nice catch!

Thanks,
Jean

>
>> =A0#endif
>> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
>> index 819ea0c..1a686c8 100644
>> --- a/arch/arm/plat-omap/sram.c
>> +++ b/arch/arm/plat-omap/sram.c
>> @@ -41,15 +41,12 @@
>>
>> =A0#define OMAP1_SRAM_PA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x20000000
>> =A0#define OMAP1_SRAM_VA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0VMALLOC_END
>> -#define OMAP2_SRAM_PA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40200000
>> -#define OMAP2_SRAM_PUB_PA =A0 =A00x4020f800
>> +#define OMAP2_SRAM_PUB_PA =A0 =A0(OMAP2_SRAM_PA + 0xf800)
>> =A0#define OMAP2_SRAM_VA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xfe400000
>> =A0#define OMAP2_SRAM_PUB_VA =A0 =A0(OMAP2_SRAM_VA + 0x800)
>> -#define OMAP3_SRAM_PA =A0 =A0 =A0 =A0 =A0 0x40200000
>> =A0#define OMAP3_SRAM_VA =A0 =A0 =A0 =A0 =A0 0xfe400000
>> -#define OMAP3_SRAM_PUB_PA =A0 =A0 =A0 0x40208000
>> +#define OMAP3_SRAM_PUB_PA =A0 =A0 =A0 (OMAP3_SRAM_PA + 0x8000)
>> =A0#define OMAP3_SRAM_PUB_VA =A0 =A0 =A0 (OMAP3_SRAM_VA + 0x8000)
>> -#define OMAP4_SRAM_PA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40300000
>> =A0#define OMAP4_SRAM_VA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xfe400000
>> =A0#define OMAP4_SRAM_PUB_PA =A0 =A0(OMAP4_SRAM_PA + 0x4000)
>> =A0#define OMAP4_SRAM_PUB_VA =A0 =A0(OMAP4_SRAM_VA + 0x4000)
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
