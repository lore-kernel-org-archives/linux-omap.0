From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2 v2] ARM: OMAP4: Fix NULL pointer dereference crash.
Date: Mon, 24 Aug 2009 14:49:14 +0300
Message-ID: <87pralqvnp.fsf@deeprootsystems.com>
References: <1250928012-5233-1-git-send-email-santosh.shilimkar@ti.com>
	<87hbvytich.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40273 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbZHXLtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 07:49:17 -0400
Received: by fxm17 with SMTP id 17so1401168fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 04:49:18 -0700 (PDT)
In-Reply-To: <87hbvytich.fsf@deeprootsystems.com> (Kevin Hilman's message of "Sun\, 23 Aug 2009 22\:56\:14 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, rmk@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> After the patch series "[PATCH 00/14] OMAP PM fixes for .31-rc"
>> merge in 2.6.31-rc5, the kernel crashed during boot on OMAP4430.
>> This patch fixes it by adding UART4 support and related code.
>> Without this patch omap_serial_init() would produce " NULL pointer
>> dereference" and kernel crashes in the bootup on OMAP4430 platform.
>>
>> Some more info on the merge issue can be found here.
>> More info- http://lkml.org/lkml/2009/8/20/192
>>
>> Note: While merging this patch,"IO_ADDRESS" needs to be changed
>> to "OMAP2_IO_ADDRESS" if the Tony's below series is already merged in.
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15072.html
>>
>> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> One other problem, after looking at the Zoom2 UART stuff...
>
>> ---
>>  arch/arm/mach-omap2/board-4430sdp.c |    2 +-
>>  arch/arm/mach-omap2/serial.c        |   27 ++++++++++++++++++++++++++-
>>  2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
>> index b0c7402..1b22307 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -39,7 +39,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
>>  };
>>  
>>  static struct omap_uart_config sdp4430_uart_config __initdata = {
>> -	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
>> +	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
>>  };
>>  
>>  static struct omap_lcd_config sdp4430_lcd_config __initdata = {
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index a7421a5..e1be77b 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -112,7 +112,21 @@ static struct plat_serial8250_port serial_platform_data2[] = {
>>  		.flags		= 0
>>  	}
>>  };
>> -
>> +#ifdef CONFIG_ARCH_OMAP4
>> +static struct plat_serial8250_port serial_platform_data3[] = {
>> +	{
>> +		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
>> +		.mapbase	= OMAP_UART4_BASE,
>> +		.irq		= 70,
>> +		.flags		= UPF_BOOT_AUTOCONF,
>> +		.iotype		= UPIO_MEM,
>> +		.regshift	= 2,
>> +		.uartclk	= OMAP24XX_BASE_BAUD * 16,
>> +	}, {
>> +		.flags		= 0
>> +	}
>> +};
>> +#endif
>>  static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
>>  					   int offset)
>>  {
>> @@ -550,6 +564,17 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
>>  			},
>>  		},
>>  	},
>> +#ifdef CONFIG_ARCH_OMAP4
>> +	{
>> +		.pdev = {
>> +			.name			= "serial8250",
>> +			.id			= PLAT8250_DEV_FOURPORT,
>
> This should not be FOURPORT, it should just be a number.  In this case,
> it should be 3 (the others start from zero.)

Santosh,

I've changed the .id field to '3' and will queue up this fix for the
next merge window along with my fixes queue[1].  Please let me know if you
want to do otherwise.

Kevin

[1] My fixes queue for the next window is the pm-upstream/fixes-32 branch
    which is based on Tony's for-next branch.
