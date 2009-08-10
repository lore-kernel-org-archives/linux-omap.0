From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2] OMAP2: Zoom2: Pass irqflags to 8250 driver
Date: Mon, 10 Aug 2009 22:14:09 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F59893C0@dbde02.ent.ti.com>
References: <1245713126-18312-1-git-send-email-vikram.pandita@ti.com>
 <20090810163859.GI1938@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58096 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218AbZHJQov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 12:44:51 -0400
In-Reply-To: <20090810163859.GI1938@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Monday, August 10, 2009 11:39 AM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH v2] OMAP2: Zoom2: Pass irqflags to 8250 driver
>
>* Vikram Pandita <vikram.pandita@ti.com> [090623 02:29]:
>> Pass irqflags to 8250 driver from zoom2 board file
>> Zoom2 has IRQF_TRIGGER_RISING requirement for the 8250 GPIO irq
>>
>> This patch is dependent on 8250 driver changes getting accepted upstream:
>> Refer: http://patchwork.kernel.org/patch/31884/
>
>FYI, I'll archive this for now, please resubmit once the related changes
>are integrated. Or if resubmitting the related changes, please submit this
>too via the serial list.

Looks like the dependency patch is already in linux-next tree at [1].
The dependency patch is already lined up stream. 

So looks like you can line this irqflag change for zoom2.

[1] http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commit;h=7053133124d5cdf207c1168c7a0c582a18e12ea7

>
>Acked-by: Tony Lindgren <tony@atomide.com>
>
>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>>
>> Warning:
>> could cause compilation break if 8250 patch is not integrated first
>>
>>  arch/arm/mach-omap2/board-zoom-debugboard.c |    2 ++
>>  arch/arm/mach-omap2/serial.c                |    2 +-
>>  2 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-
>debugboard.c
>> index bac5c43..f546063 100644
>> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
>> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/gpio.h>
>>  #include <linux/serial_8250.h>
>>  #include <linux/smsc911x.h>
>> +#include <linux/interrupt.h>
>>
>>  #include <mach/gpmc.h>
>>
>> @@ -84,6 +85,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
>>  		.mapbase	= 0x10000000,
>>  		.irq		= OMAP_GPIO_IRQ(102),
>>  		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
>> +		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
>>  		.iotype		= UPIO_MEM,
>>  		.regshift	= 1,
>>  		.uartclk	= QUART_CLK,
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index b094c15..45d4884 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -429,7 +429,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>>  		omap_ctrl_writew(v, uart->padconf);
>>  	}
>>
>> -	p->flags |= UPF_SHARE_IRQ;
>> +	p->irqflags |= IRQF_SHARED;
>>  	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
>>  			  "serial idle", (void *)uart);
>>  	WARN_ON(ret);
>> --
>> 1.6.0.3.613.g9f8f13
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

