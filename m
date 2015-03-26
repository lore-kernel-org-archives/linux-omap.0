From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 11/35] ARM: OMAP2+: clock: move clock provider infrastructure
 to clock driver
Date: Thu, 26 Mar 2015 09:24:22 +0200
Message-ID: <5513B426.1070205@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com> <1426877086-17131-12-git-send-email-t-kristo@ti.com> <5512D069.4080906@ti.com> <20150325231659.GD31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47303 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbbCZHYp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2015 03:24:45 -0400
In-Reply-To: <20150325231659.GD31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, sakari.ailus@iki.fi, linux-arm-kernel@lists.infradead.org

On 03/26/2015 01:17 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [150325 08:12]:
>>
>> Splits the clock provider init out of the PRM driver and moves it to
>> clock driver. This is needed so that once the PRCM drivers are separated,
>> they can logically just access the clock driver not needing to go through
>> common PRM code. This would be wrong in the case of control module for
>> example.
> ...
>
>> --- a/arch/arm/mach-omap2/clock.c
>> +++ b/arch/arm/mach-omap2/clock.c
> ...
>> -u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
>> +u32 omap2_clk_memmap_readl(void __iomem *reg)
>>   {
>> -	u32 val;
>> +	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
>>
>> -	if (clk->flags & MEMMAP_ADDRESSING) {
>> -		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
>> -		val = readl_relaxed(clk_memmaps[r->index] + r->offset);
>> -	} else {
>> -		val = readl_relaxed(reg);
>> -	}
>> +	return readl_relaxed(clk_memmaps[r->index] + r->offset);
>> +}
>
> The cast from void __iomem *reg to struct clk_omap_reg *r looks still
> nasty.. Why don't you add the IO address into struct clk_omap_reg:
>
> struct clk_omap_reg {
> 	u16 offset;
> 	u16 index;
> 	struct regmap *regmap;
> 	void __iomem *addr;
> };
> ...
>
> Then populate it during init and then have the clock code use it
> directly if available? Then it seems you would not need the
> static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS] at all?

Doing a change like this should probably be planned, but it is a larger 
modification. Currently none of the low-level clock APIs support this, 
but instead expect a direct iomem pointer against which they can do 
arithmetic operations. The major problem is the companion clocks, which 
just XOR some bits in the registers to get ICLK / IDLEST register offset 
from FCLK.

So, for now, clock code just uses the void __iomem pointer as a storage 
class for struct clk_omap_reg, on which arithmetic operations can be done.

-Tero

