From: "Arun KS" <getarunks@gmail.com>
Subject: Re: [PATCH 1/3] OMAP2EVM: add ethernet support (smc911x)
Date: Tue, 24 Jun 2008 17:59:09 +0530
Message-ID: <dfeb90390806240529v27c8e615leabdf441efff6004@mail.gmail.com>
References: <dfeb90390806240504t3a900901t8879c3fc07aebb0f@mail.gmail.com>
	 <0d8b982e9147570fe343aff404e7a1c6@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:12293 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYFXM3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 08:29:11 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1313367tic.23
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 05:29:09 -0700 (PDT)
In-Reply-To: <0d8b982e9147570fe343aff404e7a1c6@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Hi Felipe,

I will do the changes and resend the patches.

Best Regards,
Arun

On Tue, Jun 24, 2008 at 5:42 PM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Tue, 24 Jun 2008 17:34:59 +0530, "Arun KS" <getarunks@gmail.com> wrote:
>> From 58efa8d0019a7f777aaad2d43afb05170df25fae Mon Sep 17 00:00:00 2001
>> From: Arun KS <arunks@mistralsolutions.com>
>> Date: Tue, 24 Jun 2008 16:01:32 +0530
>> Subject: [PATCH] OMAP2EVM:  Adding ethernet support
>>
>> OMAP2EVM: add ethernet support (smc911x)
>>
>> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
>> ---
>>  arch/arm/mach-omap2/board-omap2evm.c       |   37
>> ++++++++++++++++++++++++++++
>>  include/asm-arm/arch-omap/board-omap2evm.h |    5 ++-
>>  2 files changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap2evm.c
>> b/arch/arm/mach-omap2/board-omap2evm.c
>> index d00e502..e9a2cef 100644
>> --- a/arch/arm/mach-omap2/board-omap2evm.c
>> +++ b/arch/arm/mach-omap2/board-omap2evm.c
>> @@ -27,11 +27,43 @@
>>  #include <asm/arch/board.h>
>>  #include <asm/arch/common.h>
>>
>> +static struct resource omap2evm_smc911x_resources[] = {
>> +   [0] =   {
>> +       .start  = OMAP2EVM_ETHR_START,
>> +       .end    = (OMAP2EVM_ETHR_START + OMAP2EVM_ETHR_SIZE - 1),
>> +       .flags  = IORESOURCE_MEM,
>> +   },
>> +   [1] =   {
>> +       .start  = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
>> +       .end    = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
>> +       .flags  = IORESOURCE_IRQ,
>
> it looks like drivers/net/smc911x doesn't use IORESOURCE_IRQ, am I
> misreading it ?
>
>> +   },
>> +};
>> +
>> +static struct platform_device omap2evm_smc911x_device = {
>> +   .name       = "smc911x",
>> +   .id     = -1,
>> +   .num_resources  = ARRAY_SIZE(omap2evm_smc911x_resources),
>> +   .resource   = &omap2evm_smc911x_resources [0],
>> +};
>> +
>> +static inline void __init omap2evm_init_smc911x(void)
>> +{
>> +    if (omap_request_gpio(OMAP2EVM_ETHR_GPIO_IRQ) < 0) {
>> +       printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
>> +       OMAP2EVM_ETHR_GPIO_IRQ);
>> +       return;
>> +    }
>> +
>> +    omap_set_gpio_direction(OMAP2EVM_ETHR_GPIO_IRQ, 1);
>
> please use gpiolib ;-)
>
>> +}
>> +
>>  static void __init omap2_evm_init_irq(void)
>>  {
>>     omap2_init_common_hw();
>>     omap_init_irq();
>>     omap_gpio_init();
>> +   omap2evm_init_smc911x();
>>  }
>>
>>  static struct omap_uart_config omap2_evm_uart_config __initdata = {
>> @@ -53,8 +85,13 @@ static int __init omap2_evm_i2c_init(void)
>>     return 0;
>>  }
>>
>> +static struct platform_device *omap2_evm_devices[] __initdata = {
>> +    &omap2evm_smc911x_device,
>> +};
>> +
>>  static void __init omap2_evm_init(void)
>>  {
>> +   platform_add_devices(omap2_evm_devices,
>> ARRAY_SIZE(omap2_evm_devices));
>>     omap_board_config = omap2_evm_config;
>>     omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
>>     omap_serial_init();
>> diff --git a/include/asm-arm/arch-omap/board-omap2evm.h
>> b/include/asm-arm/arch-omap/board-omap2evm.h
>> index 98273a9..d770c58 100644
>> --- a/include/asm-arm/arch-omap/board-omap2evm.h
>> +++ b/include/asm-arm/arch-omap/board-omap2evm.h
>> @@ -30,7 +30,8 @@
>>  #define __ASM_ARCH_OMAP2_EVM_H
>>
>>  /* Placeholder for OMAP2EVM specific defines */
>> -#define OMAP24XX_ETHR_START        0x08000300
>> -#define OMAP24XX_ETHR_GPIO_IRQ     149
>> +#define OMAP2EVM_ETHR_START            0x2c000000
>> +#define OMAP2EVM_ETHR_SIZE         1024
>> +#define OMAP2EVM_ETHR_GPIO_IRQ     149
>>
>>  #endif /* __ASM_ARCH_OMAP2_EVM_H */
>> --
>> 1.5.3.4
> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
>
