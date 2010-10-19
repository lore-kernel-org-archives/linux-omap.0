From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v2 6/6] TI816X: Add low level debug support
Date: Tue, 19 Oct 2010 14:40:06 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B035685E722@dbde02.ent.ti.com>
References: <1281546687-11593-1-git-send-email-hemantp@ti.com>
 <20100916222817.GS29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42278 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab0JSJKO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 05:10:14 -0400
In-Reply-To: <20100916222817.GS29610@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Tony Lindgren wrote on Friday, September 17, 2010 3:58 AM:

> * Hemant Pedanekar <hemantp@ti.com> [100811 10:04]:
>> This patch adds support for low level debugging on TI816X boards.
>> Currently the support for UART3 console on TI816X EVM is added.
> 
>> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
>> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
>> @@ -66,6 +66,12 @@ omap_uart_lsr:	.word	0
>>  		beq	34f			@ configure OMAP3UART4
>>  		cmp	\rx, #OMAP4UART4	@ only on 44xx
>>  		beq	44f			@ configure OMAP4UART4
>> +		cmp	\rx, #TI816XUART1	@ ti816x UART offsets different
>> +		beq	81f			@ configure UART1
>> +		cmp	\rx, #TI816XUART2	@ ti816x UART offsets different
>> +		beq	82f			@ configure UART2
>> +		cmp	\rx, #TI816XUART3	@ ti816x UART offsets different
>> +		beq	83f			@ configure UART3
>>  		cmp	\rx, #ZOOM_UART		@ only on zoom2/3
>>  		beq	95f			@ configure ZOOM_UART
>> 
> 
> Would be nice to have the TI816XUART defines in this patch too
> instead of defining them in some other patch earlier.
> 
> Tony

Can you please refer to the patch 
@https://patchwork.kernel.org/patch/118855/

The file arch/arm/plat-omap/include/plat/serial.h which has these defined, 
is part of this patch.

Thanks
-
Hemant

