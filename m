From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 1/3] OMAP UART: Adding support for omap-serial driver.
Date: Thu, 24 Sep 2009 12:47:16 +0530
Message-ID: <d6a0f7aa0909240017o3b201848j87bafeebebd048c2@mail.gmail.com>
References: <51076.192.168.10.88.1253639068.squirrel@dbdmail.itg.ti.com>
	 <20090922180356.GJ14890@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20090922180356.GJ14890@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 22, 2009 at 11:33 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Govindraj.R <govindraj.raja@ti.com> [090922 10:06]:
>> From: Govindraj R <govindraj.raja@ti.com>
>>
>> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>
> Why do you have the same subject anad description is the same for all=
 of them?
>
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -1359,6 +1359,98 @@ config SERIAL_OF_PLATFORM
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
>> + =A0 =A0 =A0to this option.
>> +
>
> Didn't I already comment these options should be passed in platform_d=
ata
> from board-*.c files?
>

Will resend PATCH v1 incorporating SERIAL_OMAP_UARTx_RXDMA_BUFSIZE
and SERIAL_OMAP_UARTx_RXDMA_BUFSIZE values into platform data and will
clean up in Kconfig.

Thanks for your review comments.

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
