From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] OMAP1: AMS_DELTA: add modem support
Date: Mon, 24 Aug 2009 15:51:55 +0300
Message-ID: <20090824125155.GJ7069@atomide.com>
References: <20090811094348.32577.81307.stgit@localhost> <20090811095150.32577.10474.stgit@localhost> <4A8AAA48.8020702@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56460 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZHXMwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:52:21 -0400
Content-Disposition: inline
In-Reply-To: <4A8AAA48.8020702@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090818 16:20]:
> Tony Lindgren wrote:
>> From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>>
>> This patch adds support for modem device found on Amstrad E3 (Delta) board.
>>
>> Based on earlier patch by Jonathan McDowell, available at
>> http://the.earth.li/pub/e3/2.6.19/ams-delta-modem.patch.
>> Modified after Ladislav Michl's arch/arm/mach-omap1/board-voiceblue.c.
>>
>> This patch is dependent on 8250 driver changes getting accepted upstream:
>> http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commit;h=7053133124d5cdf207c1168c7a0c582a18e12ea7
>>
>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/mach-omap1/board-ams-delta.c |   38 +++++++++++++++++++++++++++++++++
>>  1 files changed, 38 insertions(+), 0 deletions(-)
>>
> Russel,
>
> Unlike all others from the series, this one got no single comment from  
> you, niether your "OK" nor anything else. I'm not sure what that could  
> mean, but if there is still something I can do to help getting it into  
> 2.6.32, please let me know.

I've queued this series into omap for-next branch along with other omap
code going upstream.

Regards,

Tony


>
> Thanks,
> Janusz
>
>> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
>> index db4d9a4..40dfa63 100644
>> --- a/arch/arm/mach-omap1/board-ams-delta.c
>> +++ b/arch/arm/mach-omap1/board-ams-delta.c
>> @@ -15,8 +15,11 @@
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>>  #include <linux/input.h>
>> +#include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/serial_8250.h>
>>  +#include <asm/serial.h>
>>  #include <mach/hardware.h>
>>  #include <asm/mach-types.h>
>>  #include <asm/mach/arch.h>
>> @@ -234,6 +237,41 @@ static void __init ams_delta_init(void)
>>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
>>  }
>>  +static struct plat_serial8250_port ams_delta_modem_ports[] = {
>> +	{
>> +		.membase	= (void *) AMS_DELTA_MODEM_VIRT,
>> +		.mapbase	= AMS_DELTA_MODEM_PHYS,
>> +		.irq		= -EINVAL, /* changed later */
>> +		.flags		= UPF_BOOT_AUTOCONF,
>> +		.irqflags	= IRQF_TRIGGER_RISING,
>> +		.iotype		= UPIO_MEM,
>> +		.regshift	= 1,
>> +		.uartclk	= BASE_BAUD * 16,
>> +	},
>> +	{ },
>> +};
>> +
>> +static struct platform_device ams_delta_modem_device = {
>> +	.name	= "serial8250",
>> +	.id	= PLAT8250_DEV_PLATFORM1,
>> +	.dev		= {
>> +		.platform_data = ams_delta_modem_ports,
>> +	},
>> +};
>> +
>> +static int __init ams_delta_modem_init(void)
>> +{
>> +	omap_cfg_reg(M14_1510_GPIO2);
>> +	ams_delta_modem_ports[0].irq = gpio_to_irq(2);
>> +
>> +	ams_delta_latch2_write(
>> +		AMS_DELTA_LATCH2_MODEM_NRESET | AMS_DELTA_LATCH2_MODEM_CODEC,
>> +		AMS_DELTA_LATCH2_MODEM_NRESET | AMS_DELTA_LATCH2_MODEM_CODEC);
>> +
>> +	return platform_device_register(&ams_delta_modem_device);
>> +}
>> +arch_initcall(ams_delta_modem_init);
>> +
>>  static void __init ams_delta_map_io(void)
>>  {
>>  	omap1_map_common_io();
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
