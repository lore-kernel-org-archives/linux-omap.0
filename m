From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: GPMC clock question
Date: Thu, 18 Dec 2014 20:26:08 -0300
Message-ID: <54936290.3090500@vanguardiasur.com.ar>
References: <54933CC1.9010301@vanguardiasur.com.ar> <20141218210653.GI23854@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:57473 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaLRX17 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2014 18:27:59 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so1661596qcq.25
        for <linux-omap@vger.kernel.org>; Thu, 18 Dec 2014 15:27:58 -0800 (PST)
In-Reply-To: <20141218210653.GI23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?windows-1252?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>



On 12/18/2014 06:06 PM, Tony Lindgren wrote:
> * Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> [141218 12:49]:
>> Tony, Roger:
>>
>> As far as I can see, the GPMC interface clock (GPMC_FCLK) is not
>> properly modeled in the devicetree. Instead, hwmod magic seems to be used.
> 
> I guess you mean the functional clock not interface clock?
>  
>> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c:
>> struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
>>         .master         = &am33xx_l3_s_hwmod,
>>         .slave          = &am33xx_gpmc_hwmod,
>>         .clk            = "l3s_gclk",
>>         .addr           = am33xx_gpmc_addr_space,
>>         .user           = OCP_USER_MPU,
>> };
>>
>> I'd like to know what would be the appropriate DT model for this clock.
>> Perhaps, as child of CORE_M4_CLK, divided by 2:
>>
>> gpmc_fclk: gpmc_fclk {
>>                 #clock-cells = <0>;
>>                 compatible = "fixed-factor-clock";
>>                 clocks = <&dpll_core_m4_ck>;
>>                 clock-mult = <1>;
>>                 clock-div = <2>;
>>         };
>>
>> How does it look? Also, I'm wondering if this works OK when used with
>> the hwmod stuff.
> 
> Hmm we do have clocks or aliases for l3s_gclk, so it's there as otherwise
> the GPMC would not work at all :) Sure with device tree only systems we
> should have the clock phandle directly available though.
> 

Right.

> Note that the hwmod code takes care of runtime PM clock gating for the
> drivers.

Not entirely sure how that works, but I'll take a look.

> But the clock entry for am33xx_l3_s__gpmc should be coming
> from .dts.

Right.

> Please also check out the hwmod dts related changes Felipe
> posted last week, that might allow populating .clk from .dts already.
> 

Ah, nice. I'll take a look.

Thanks Tony!
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
