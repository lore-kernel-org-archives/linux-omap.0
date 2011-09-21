From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 8/8] OMAP4: Fix the emif and dmm virtual mapping
Date: Wed, 21 Sep 2011 10:31:11 -0700
Message-ID: <87zkhx3iqo.fsf@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
	<1315459327-3285-9-git-send-email-santosh.shilimkar@ti.com>
	<87r53gnzfh.fsf@ti.com> <4E78AAD5.6010906@ti.com>
	<4E7A0292.4020408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33066 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821Ab1IURbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Sep 2011 13:31:22 -0400
Received: by mail-yw0-f45.google.com with SMTP id 39so2685393ywm.32
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 10:31:21 -0700 (PDT)
In-Reply-To: <4E7A0292.4020408@ti.com> (Santosh Shilimkar's message of "Wed,
	21 Sep 2011 20:58:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Girish S G <girishsg@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Tuesday 20 September 2011 08:31 PM, Santosh Shilimkar wrote:
>> On Friday 16 September 2011 11:26 PM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>
> [...]
>
>> 
>>>>  #define OMAP44XX_EMIF2_SIZE	SZ_1M
>>>>  
>>>>  #define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
>>>>  						/* 0x4e000000 --> 0xfd300000 */
>>>> -#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
>>>> +#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + SZ_1M)
>>>
>>> and '+ OMAP44XX_EMIF2_SIZE' here.
>>>
>> Will add OMAP44XX_EMIF_SIZE since 2 EMIFs instaces are and
>> suppose to be identical.Almost missed this email in other traffic.
>
> OPPs. It was already there. Dumb of me not using it. Below
> is the update what I will do.
>
> diff --git a/arch/arm/plat-omap/include/plat/io.h
> b/arch/arm/plat-omap/include/plat/io.h
> index d72ec85..db36292 100644
> --- a/arch/arm/plat-omap/include/plat/io.h
> +++ b/arch/arm/plat-omap/include/plat/io.h
> @@ -228,13 +228,13 @@
>
>  #define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
>  						/* 0x4d000000 --> 0xfd200000 */
> -#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF2_PHYS + OMAP4_L3_PER_IO_OFFSET)
>  #define OMAP44XX_EMIF2_SIZE	SZ_1M
> +#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + OMAP44XX_EMIF2_SIZE)

This doesn't look right either.

This #define is for the *start* of EMIF2 virtual address space, so 
assuming the start address of EMIF2 is immediatly after EMIF1, it should
be EMIF1_VIRT + EMIF1_SIZE (not EMIF2_SIZE.)

>  #define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
>  						/* 0x4e000000 --> 0xfd300000 */
> -#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
>  #define OMAP44XX_DMM_SIZE	SZ_1M
> +#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + OMAP44XX_DMM_SIZE)

And here, assuming DMM range is immediately after EMIF2, this should be
EMIF2_VIRT + EMFI2_SIZE)

Kevin
