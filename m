From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/2] OMAP: Zoom2: Add DEBUG_LL interface using Quart
Date: Fri, 11 Sep 2009 15:28:45 -0700
Message-ID: <4AAACF1D.9050002@deeprootsystems.com>
References: <1252691870-9785-1-git-send-email-vikram.pandita@ti.com> <871vmd40va.fsf@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F9C311DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:39668 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbZIKW2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 18:28:45 -0400
Received: by pxi27 with SMTP id 27so1109949pxi.15
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 15:28:48 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9C311DB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Erik Gilling <konkers@android.com>

Pandita, Vikram wrote:
> 
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>
>>> This patch adds DEBUG_LL interface for Zoom2 board.
>>> The low level debug uart now points corrctly to External Quad uart
>>> controller on detachable debug board.
>>>
>>> The Quad uart is available over GPMC chip select with physical address
>>> 0x10000000.
>>>
>>> This physical address has been mapped to virtual address 0xFB000000
>>> as per static mapping.
>> I see you dropped the UPF_IOREMAP flag. Why do we need a static
>> mapping here?  The early access will be taken care of by the .phys_io
>> field of the mach_desc, no?
> 
> Step 1:
> The first early mapping happens with phys_io. Just for debug uart access.
> Step 2:
> This is over-written by mapping done by omap2_map_common_io -> iotable_init
> 
> I removed the flag UPF_IOREMAP for the serial 8250 driver.
> If UPF_IOREMAP flag is given, then serial driver will do yet one more mapping, 
> which is already done by step 2.
> 
> Hence the flag is no longer needed for serial port mapping.

OK, thanks for clarifying.  After reviewing your DEBUG_LL rework, I also 
notice that it requires a static mapping too.

Kevin

>> Kevin
>>
>>> This patch is adapted from a version by Erik Gilling:
>>> http://android.git.kernel.org/?p=kernel/omap.git;
>>> a=commit;h=e9d72efdd88877d2d6ea74a08983ace0dcc771d3
>>>
>>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>>> Cc: Erik Gilling <konkers@android.com>
>>> ---
>>>  arch/arm/mach-omap2/board-zoom-debugboard.c |    5 +++--
>>>  arch/arm/mach-omap2/board-zoom2.c           |   19 +++++++++++++++++--
>>>  arch/arm/plat-omap/include/mach/io.h        |    6 ++++++
>>>  3 files changed, 26 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-
>> debugboard.c
>>> index 1f13e2a..70a4bba 100644
>>> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
>>> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
>>> @@ -82,9 +82,10 @@ static inline void __init zoom2_init_smsc911x(void)
>>>
>>>  static struct plat_serial8250_port serial_platform_data[] = {
>>>  	{
>>> -		.mapbase	= 0x10000000,
>>> +		.membase	= IOMEM(ZOOM2_EXT_QUART_VIRT),
>>> +		.mapbase	= ZOOM2_EXT_QUART_PHYS,
>>>  		.irq		= OMAP_GPIO_IRQ(102),
>>> -		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
>>> +		.flags		= UPF_BOOT_AUTOCONF|UPF_SHARE_IRQ,
>>>  		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
>>>  		.iotype		= UPIO_MEM,
>>>  		.regshift	= 1,
>>> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
>>> index 324009e..467e961 100644
>>> --- a/arch/arm/mach-omap2/board-zoom2.c
>>> +++ b/arch/arm/mach-omap2/board-zoom2.c
>>> @@ -19,10 +19,12 @@
>>>
>>>  #include <asm/mach-types.h>
>>>  #include <asm/mach/arch.h>
>>> +#include <asm/mach/map.h>
>>>
>>>  #include <mach/common.h>
>>>  #include <mach/usb.h>
>>>  #include <mach/keypad.h>
>>> +#include <mach/uncompress.h>
>>>
>>>  #include "mmc-twl4030.h"
>>>
>>> @@ -269,15 +271,28 @@ static void __init omap_zoom2_init(void)
>>>  	usb_musb_init();
>>>  }
>>>
>>> +static struct map_desc zoom2_io_desc[] __initdata = {
>>> +	{
>>> +		.virtual	= ZOOM2_EXT_QUART_VIRT,
>>> +		.pfn		= __phys_to_pfn(ZOOM2_EXT_QUART_PHYS),
>>> +		.length		= ZOOM2_EXT_QUART_SIZE,
>>> +		.type		= MT_DEVICE
>>> +	}
>>> +};
>>> +
>>>  static void __init omap_zoom2_map_io(void)
>>>  {
>>>  	omap2_set_globals_343x();
>>> +
>>> +	/* Map external quad UART virt to phy mapping */
>>> +	iotable_init(zoom2_io_desc, ARRAY_SIZE(zoom2_io_desc));
>>> +
>>>  	omap2_map_common_io();
>>>  }
>>>
>>>  MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
>>> -	.phys_io	= 0x48000000,
>>> -	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
>>> +	.phys_io	= ZOOM2_EXT_QUART_PHYS,
>>> +	.io_pg_offst	= ((ZOOM2_EXT_QUART_VIRT) >> 18) & 0xfffc,
>>>  	.boot_params	= 0x80000100,
>>>  	.map_io		= omap_zoom2_map_io,
>>>  	.init_irq	= omap_zoom2_init_irq,
>>> diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
>>> index 8d32df3..d67f06c 100644
>>> --- a/arch/arm/plat-omap/include/mach/io.h
>>> +++ b/arch/arm/plat-omap/include/mach/io.h
>>> @@ -169,6 +169,12 @@
>>>  #define DSP_MMU_34XX_VIRT	0xe2000000
>>>  #define DSP_MMU_34XX_SIZE	SZ_4K
>>>
>>> +/* Map External Quad UART for Zoom2 board */
>>> +#define ZOOM2_EXT_QUART_PHYS		0x10000000 /* PHY address if fixed */
>>> +#define ZOOM2_EXT_QUART_PHY_TO_VIRT_OFF	0xEB000000
>>> +#define ZOOM2_EXT_QUART_VIRT		0xFB000000
>>> +#define ZOOM2_EXT_QUART_SIZE		SZ_16
>>> +
>>>  /*
>>>   * ----------------------------------------------------------------------------
>>>   * Omap4 specific IO mapping
>>> --
>>> 1.6.3.3.334.g916e1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

