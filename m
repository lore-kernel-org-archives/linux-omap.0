From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2]  McBSP preamble patch for 34xx support,
Date: Fri, 8 Aug 2008 09:59:25 +0300
Message-ID: <20080808065924.GF24923@atomide.com>
References: <34251.192.168.10.89.1218175609.squirrel@dbdmail.itg.ti.com> <20080808062612.GD24923@atomide.com> <00f001c8f923$53df16c0$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59530 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbYHHG70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 02:59:26 -0400
Content-Disposition: inline
In-Reply-To: <00f001c8f923$53df16c0$LocalHost@wipultra806>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "shekhar, chandra" <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

* shekhar, chandra <x0044955@ti.com> [080808 09:52]:
>
>
>>> ===================================================================
>>> --- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c 2008-08-07
>>> 16:39:51.000000000 +0530
>>> +++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c 2008-08-07  
>>> 16:45:00.000000000 +0530
>>> @@ -29,9 +29,31 @@
>>>
>>>  struct omap_mcbsp **mcbsp_ptr;
>>>  int omap_mcbsp_count;
>>> +int mcbsp_32_bit_ops;
>>> +
>>> +void omap_mcbsp_write(u32 io_base, u16 reg, u32 val)
>>> +{
>>> + if (!mcbsp_32_bit_ops)
>>> + __raw_writew((u16)val, io_base + reg);
>>> + else
>>> + __raw_writel(val, io_base + reg);
>>> +}
>>> +
>>> +int omap_mcbsp_read(u32 io_base, u16 reg)
>>> +{
>>> + if (!mcbsp_32_bit_ops)
>>> + return __raw_readw(io_base + reg);
>>> + else
>>> + return __raw_readl(io_base + reg);
>>> +}
>>> +
>>
>> The 16 vs 32-bit test above would be better done with cpu_is_omap2420()
>> than setting mcbsp_32_bit_ops. If 2420 is not selected, the test gets
>> optimized out as cpu_is_omap2420() is defined as 0.
>>
>> Regards,
>>
>> Tony
>
> If i put a cpu check here then i will have to put either 
> (cpu_class_is_omap1 || cpu_is_omap2420) check , or
> !( cpu_is_omap2430) & !(cpu_is_omap34xx)  - for 16 bit ops.
>
> i am not sure which one will be more optimized as in the second case we 
> will have
> a logical operator as well as cpu check. while in the first case we have  
> just a varable check.
>
> Let me know if i am missing something.

if (cpu_class_is_omap1() || cpu_is_omap2420())

is same as

if (0 || 0)

when none of the omap1 boards or 2420 are not selected. So that
should work.

Tony


>
>
>>
>>
>>> +#define OMAP_MCBSP_READ(base, reg) \
>>> + omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
>>> +#define OMAP_MCBSP_WRITE(base, reg, val) \
>>> + omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
>>>
>>>  #define omap_mcbsp_check_valid_id(id) (id < omap_mcbsp_count)
>>> -#define id_to_mcbsp_ptr(id) mcbsp_ptr[id];
>>> +#define id_to_mcbsp_ptr(id) mcbsp_ptr[id];
>>>
>>>  static void omap_mcbsp_dump_reg(u8 id)
>>>  {
>>> Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
>>> ===================================================================
>>> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h 2008-08-07
>>> 16:41:17.000000000 +0530
>>> +++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h 2008-08-07
>>> 16:45:00.000000000 +0530
>>> @@ -139,10 +139,6 @@
>>>
>>>  #endif
>>>
>>> -#define OMAP_MCBSP_READ(base, reg) __raw_readw((base) +  
>>> OMAP_MCBSP_REG_##reg)
>>> -#define OMAP_MCBSP_WRITE(base, reg, val) __raw_writew((val), (base) +
>>> OMAP_MCBSP_REG_##reg)
>>> -
>>> -
>>>  /************************** McBSP SPCR1 bit definitions  
>>> ***********************/
>>>  #define RRST 0x0001
>>>  #define RRDY 0x0002
>>> @@ -369,6 +365,7 @@
>>>  };
>>>  extern struct omap_mcbsp **mcbsp_ptr;
>>>  extern int omap_mcbsp_count;
>>> +extern int mcbsp_32_bit_ops;
>>>
>>>  int omap_mcbsp_init(void);
>>>  void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data  
>>> *config,
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html 
>
