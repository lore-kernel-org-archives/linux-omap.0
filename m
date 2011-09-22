From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v2 1/3] TI81XX: Prepare for addition of TI814X support
Date: Thu, 22 Sep 2011 06:03:33 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4D17100@dbde02.ent.ti.com>
References: <1316626735-5597-1-git-send-email-hemantp@ti.com>
 <20110921204057.GJ2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39368 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab1IVAdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 20:33:47 -0400
In-Reply-To: <20110921204057.GJ2937@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Tony Lindgren wrote on Thursday, September 22, 2011 2:11 AM:

> * Hemant Pedanekar <hemantp@ti.com> [110921 10:05]:
>> --- a/arch/arm/mach-omap2/board-ti8168evm.c
>> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
>> @@ -37,16 +37,16 @@ static void __init ti8168_evm_init(void)
>> 
>>  static void __init ti8168_evm_map_io(void)
>>  {
>> -	omap2_set_globals_ti816x();
>> -	omapti816x_map_common_io();
>> +	omap2_set_globals_ti81xx();
>> +	omapti81xx_map_common_io();
>>  }
>> 
>>  MACHINE_START(TI8168EVM, "ti8168evm")
>>  	/* Maintainer: Texas Instruments */
>>  	.atag_offset	= 0x100,
>>  	.map_io		= ti8168_evm_map_io,
>> -	.init_early	= ti816x_init_early,
>> -	.init_irq	= ti816x_init_irq,
>> +	.init_early	= ti81xx_init_early,
>> +	.init_irq	= ti81xx_init_irq,
>>  	.timer		= &omap3_timer,
>>  	.init_machine	= ti8168_evm_init,
>>  MACHINE_END
> 
> Looks like you still need a minor rebase on the current cleanup
> branch as the ti8668_evm_map_io is no longer needed. The cleanup
> branch already has Paul's CHIP_IS removal, so that should be trivial.
>

Tony,
Can you please clarify? Do we not need ti8168_evm_map_io() for global data
initianlization and io init? Or, as you mentioned in comment on 3/3 of the
series, do you mean to rename this with ti81xx and move to common.c?
 
> Ideally the rename patch would be separate without any functional
> changes, maybe you can move the changes and additions to the next patch?
> 
> Tony

If the above understanding is correct, then I will just have to rename+move
ti8168_evm_map_io() so the change can still be in this patch, right? Or are
You referring to any other part which should not be in this patch?

Thanks.
 
   Hemant