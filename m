From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv1 1/3] OMAP UART: Adds omap-serial driver support.
Date: Thu, 8 Oct 2009 11:44:15 +0530
Message-ID: <d6a0f7aa0910072314h77383e31r2330725b614ba472@mail.gmail.com>
References: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>
	 <20091007215116.GB29320@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:65083 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbZJHGPW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 02:15:22 -0400
In-Reply-To: <20091007215116.GB29320@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Oct 8, 2009 at 3:21 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [090924 03:29]:
>> From: Govindraj R <govindraj.raja@ti.com>
>>
>> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>>
>> Signed-off-by: =A0 =A0 =A0 =A0Govindraj R <govindraj.raja@ti.com>
>> Reviewed-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>
> You should only add Reviewed-by if Alan or me have replied with it.
>
> So far I've only replied with some comments that have not yet
> been fixed, so we're few more steps from being Reviewd-by.
>
> <snip>
>
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 6553833..67a7129 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -1359,6 +1359,53 @@ config SERIAL_OF_PLATFORM
>> =A0 =A0 =A0 =A0 Currently, only 8250 compatible ports are supported,=
 but
>> =A0 =A0 =A0 =A0 others can easily be added.
>>
>> +config SERIAL_OMAP
>> + =A0 =A0 bool "OMAP serial port support"
>> + =A0 =A0 depends on ARM && ARCH_OMAP
>> + =A0 =A0 select SERIAL_CORE
>> + =A0 =A0 help
>> + =A0 =A0 If you have a machine based on an Texas Instruments OMAP C=
PU you
>> + =A0 =A0 can enable its onboard serial ports by enabling this optio=
n.
>> +
>> +config SERIAL_OMAP_CONSOLE
>> + =A0 =A0 bool "Console on OMAP serial port"
>> + =A0 =A0 depends on SERIAL_OMAP
>> + =A0 =A0 select SERIAL_CORE_CONSOLE
>> + =A0 =A0 help
>> + =A0 =A0 If you have enabled the serial port on the Texas Instrumen=
ts OMAP
>> + =A0 =A0 CPU you can make it the console by answering Y to this opt=
ion.
>> +
>> + =A0 =A0 Even if you say Y here, the currently visible virtual cons=
ole
>> + =A0 =A0 (/dev/tty0) will still be used as the system console by de=
fault, but
>> + =A0 =A0 you can alter that using a kernel command line option such=
 as
>> + =A0 =A0 "console=3DttyS0". (Try "man bootparam" or see the documen=
tation of
>> + =A0 =A0 your boot loader (lilo or loadlin) about how to pass optio=
ns to the
>> + =A0 =A0 kernel at boot time.)
>> +
>> +config SERIAL_OMAP_DMA_UART1
>> + =A0 =A0 bool "UART1 DMA support"
>> + =A0 =A0 depends on SERIAL_OMAP
>> + =A0 =A0 help
>> + =A0 =A0 If you have enabled the serial port on the Texas Instrumen=
ts OMAP
>> + =A0 =A0 CPU you can enable the DMA transfer on UART 1 by answering
>> + =A0 =A0 to this option.
>> +
>> +config SERIAL_OMAP_DMA_UART2
>> + =A0 =A0 bool "UART2 DMA support"
>> + =A0 =A0 depends on SERIAL_OMAP
>> + =A0 =A0 help
>> + =A0 =A0 If you have enabled the serial port on the Texas Instrumen=
ts OMAP
>> + =A0 =A0 CPU you can enable the DMA transfer on UART 2 by answering
>> + =A0 =A0 to this option.
>> +
>> +config SERIAL_OMAP_DMA_UART3
>> + =A0 =A0 bool "UART3 DMA support"
>> + =A0 =A0 depends on SERIAL_OMAP
>> + =A0 =A0 help
>> + =A0 =A0 If you have enabled the serial port on the Texas Instrumen=
ts OMAP
>> + =A0 =A0 CPU you can enable the DMA transfer on UART 3 by answering
>> + =A0 =A0 to this option.
>> +
>> =A0config SERIAL_OF_PLATFORM_NWPSERIAL
>> =A0 =A0 =A0 tristate "NWP serial port driver"
>> =A0 =A0 =A0 depends on PPC_OF && PPC_DCR
>
> There's absolutely no need for having Kconfig options for the DMA
> support. Please pass that in platform_data from the board-*.c files.
>
> This is the third time I'm commenting on the same issue!
>
> What's the point of posting these patches for review if the issues
> don't get solved?


The omap-serial uart driver is designed to work either in interrupt
mode or in DMA mode,
We have provided this option so that one can select interrupt mode or
DMA mode based on the uart usage, if somebody is using uart as console
then interrupt mode will do, else if used with bluetooth which does
huge data transfer then DMA mode can be selected.

Don't you think this should be a configurable option using kconfig
rather than passing as platform data?

if used as platform data then one has to modify platform data to
switch between the interrupt and DMA mode.

Regards,
Govindraj.R


>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
