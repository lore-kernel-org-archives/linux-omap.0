From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 8/8] OMAP4: Fix the emif and dmm virtual mapping
Date: Thu, 22 Sep 2011 11:23:43 +0530
Message-ID: <CAMQu2gwPs=4-RxvMZFF6-Uk6GGQPjNSCJhzaYFsM2gmdi4NfEA@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
 <1315459327-3285-9-git-send-email-santosh.shilimkar@ti.com>
 <87r53gnzfh.fsf@ti.com> <4E78AAD5.6010906@ti.com> <4E7A0292.4020408@ti.com> <87zkhx3iqo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58257 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964Ab1IVFyF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 01:54:05 -0400
Received: by mail-yw0-f47.google.com with SMTP id 7so2849725ywf.6
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 22:54:03 -0700 (PDT)
In-Reply-To: <87zkhx3iqo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Girish S G <girishsg@ti.com>

On Wed, Sep 21, 2011 at 11:01 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> On Tuesday 20 September 2011 08:31 PM, Santosh Shilimkar wrote:
>>> On Friday 16 September 2011 11:26 PM, Kevin Hilman wrote:
>>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>>
>>
>> [...]
>>
>>>
>>>>> =A0#define OMAP44XX_EMIF2_SIZE =A0 =A0 =A0 SZ_1M
>>>>>
>>>>> =A0#define OMAP44XX_DMM_PHYS OMAP44XX_DMM_BASE
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* 0x4e000000 --> 0xfd300000 */
>>>>> -#define OMAP44XX_DMM_VIRT (OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_O=
=46FSET)
>>>>> +#define OMAP44XX_DMM_VIRT (OMAP44XX_EMIF2_VIRT + SZ_1M)
>>>>
>>>> and '+ OMAP44XX_EMIF2_SIZE' here.
>>>>
>>> Will add OMAP44XX_EMIF_SIZE since 2 EMIFs instaces are and
>>> suppose to be identical.Almost missed this email in other traffic.
>>
>> OPPs. It was already there. Dumb of me not using it. Below
>> is the update what I will do.
>>
>> diff --git a/arch/arm/plat-omap/include/plat/io.h
>> b/arch/arm/plat-omap/include/plat/io.h
>> index d72ec85..db36292 100644
>> --- a/arch/arm/plat-omap/include/plat/io.h
>> +++ b/arch/arm/plat-omap/include/plat/io.h
>> @@ -228,13 +228,13 @@
>>
>> =A0#define OMAP44XX_EMIF2_PHYS =A0OMAP44XX_EMIF2_BASE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* 0x4d000000 --> 0xfd200000 */
>> -#define OMAP44XX_EMIF2_VIRT =A0(OMAP44XX_EMIF2_PHYS + OMAP4_L3_PER_=
IO_OFFSET)
>> =A0#define OMAP44XX_EMIF2_SIZE =A0SZ_1M
>> +#define OMAP44XX_EMIF2_VIRT =A0(OMAP44XX_EMIF1_VIRT + OMAP44XX_EMIF=
2_SIZE)
>
> This doesn't look right either.
>
> This #define is for the *start* of EMIF2 virtual address space, so
> assuming the start address of EMIF2 is immediatly after EMIF1, it sho=
uld
> be EMIF1_VIRT + EMIF1_SIZE (not EMIF2_SIZE.)
>
>> =A0#define OMAP44XX_DMM_PHYS =A0 =A0OMAP44XX_DMM_BASE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* 0x4e000000 --> 0xfd300000 */
>> -#define OMAP44XX_DMM_VIRT =A0 =A0(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_=
IO_OFFSET)
>> =A0#define OMAP44XX_DMM_SIZE =A0 =A0SZ_1M
>> +#define OMAP44XX_DMM_VIRT =A0 =A0(OMAP44XX_EMIF2_VIRT + OMAP44XX_DM=
M_SIZE)
>
> And here, assuming DMM range is immediately after EMIF2, this should =
be
> EMIF2_VIRT + EMFI2_SIZE)
>
I agree.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
