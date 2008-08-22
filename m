From: "Girish. S. G." <girishsg@ti.com>
Subject: Re: [RFC][PATCH 1/1] serial: OMAP driver
Date: Fri, 22 Aug 2008 18:12:21 +0530 (IST)
Message-ID: <38077.192.168.10.89.1219408941.squirrel@dbdmail.itg.ti.com>
References: <45510.192.168.10.88.1217503495.squirrel@dbdmail.itg.ti.com>
    <20080806100552.GK19813@atomide.com>
Reply-To: girishsg@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35714 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYHVMxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 08:53:41 -0400
In-Reply-To: <20080806100552.GK19813@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony,

> Hi,
>
> Some comments below.
>
> * Girish. S. G. <girishsg@ti.com> [080731 14:26]:
>> Serial driver for OMAP Uart controllers
>>
>> Signed-off-by: Girish S G <girishsg@ti.com>
>> ---
>>  arch/arm/configs/omap_3430sdp_defconfig |   12
>>  arch/arm/mach-omap2/serial.c            |  166 ++---
>>  drivers/serial/Kconfig                  |   23
>>  drivers/serial/Makefile                 |    1
>>  drivers/serial/omap-serial.c            |  887
>> ++++++++++++++++++++++++++++++++
>>  include/linux/serial_core.h             |    3
>>  6 files changed, 974 insertions(+), 118 deletions(-)
>>
>> Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig

>>  	}
>> -}
>> -
>> -static struct platform_device serial_device = {
>> -	.name			= "serial8250",
>> -	.id			= PLAT8250_DEV_PLATFORM,
>> -	.dev			= {
>> -		.platform_data	= serial_platform_data,
>> -	},
>> -};
>
> What about powering UART on/off? I suggest you provide set_power()
> function in platform_data. That way the UART power function can be
> generic on later omaps, or external like the FPGA on omap1510.

There isn't any specific power on/off for UART as such(or any on omap1510?).
But yes we can have all the clk and pm related functions to be grouped under
uart_ops->pm().

>> +static struct console serial_omap_console = {
>> +	.name		= "ttyS",
>> +	.write		= serial_omap_console_write,
>> +	.device		= uart_console_device,
>> +	.setup		= serial_omap_console_setup,
>> +	.flags		= CON_PRINTBUFFER,
>> +	.index		= -1,
>> +	.data		= &serial_omap_reg,
>> +};
>> +
>
> AFAIK using ttyS name will break hot-plug 8250 ports, such as CF ports.
> How about using ttyO or something similar? I guess the minor number also
> needs to be different then.
>
> In general, will this driver also work on DaVinci? Maybe use name like
> serial_ti or similar?

I don't think the name would conflict as only our uart instance would be up and
working. Right now this driver is supported and tested only on OMAP2/OMAP3. But
yes, once it's in it can be easily ported on other TI platforms.

I will resend the patch with only OMAP2/OMAP3 support as of now.

Regards,
Girish

