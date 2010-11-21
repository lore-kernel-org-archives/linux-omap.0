From: Cosmin Cojocar <cosmin.cojocar@gmail.com>
Subject: Re: [PATCH 1/1] serial: omap-serial: Add support for kernel debugger
Date: Sun, 21 Nov 2010 14:12:58 +0100
Message-ID: <4CE91ADA.5060502@gmail.com>
References: <1290286296-3589-1-git-send-email-cosmin.cojocar@gmail.com> <1290336975.26899.16.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48080 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab0KUNNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Nov 2010 08:13:04 -0500
Received: by eye27 with SMTP id 27so3478789eye.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 05:13:02 -0800 (PST)
In-Reply-To: <1290336975.26899.16.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: govindraj.raja@ti.com, manjugk@ti.com, khilman@deeprootsystems.com, ben-linux@fluff.org, tklauser@distanz.ch, feng.tang@intel.com, gregkh@suse.de, alan@linux.intel.com, linux-omap@vger.kernel.org

Hi Ionut,

Ionut Nicu wrote:
> Hi Cosmin,
> 
> On Sat, 2010-11-20 at 21:51 +0100, Cosmin Cojocar wrote:
>> The kgdb invokes the poll_put_char and poll_get_char when communicating
>> with the host. This patch also changes the initialization order because the
>> kgdb will check at the very beginning, if there is a valid serial
>> driver.
>>
>> Signed-off-by: Cosmin Cojocar <cosmin.cojocar@gmail.com>
>> ---
>>  drivers/serial/Makefile      |    2 +-
>>  drivers/serial/omap-serial.c |   38 ++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
>> index c570576..ad86113 100644
>> --- a/drivers/serial/Makefile
>> +++ b/drivers/serial/Makefile
>> @@ -80,6 +80,7 @@ obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
>>  obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
>>  obj-$(CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL) += nwpserial.o
>>  obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
>> +obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
>>  obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
>>  obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
>>  obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
>> @@ -88,4 +89,3 @@ obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
>>  obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
>>  obj-$(CONFIG_SERIAL_MRST_MAX3110)	+= mrst_max3110.o
>>  obj-$(CONFIG_SERIAL_MFD_HSU)	+= mfd.o
>> -obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
>> diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
>> index 03a96db..df6ba03 100644
>> --- a/drivers/serial/omap-serial.c
>> +++ b/drivers/serial/omap-serial.c
>> @@ -866,14 +866,44 @@ serial_omap_type(struct uart_port *port)
>>  	return up->name;
>>  }
>>  
>> +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
>> +
>> +#ifdef CONFIG_CONSOLE_POLL
>> +static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
>> +{
>> +	struct uart_omap_port *up = (struct uart_omap_port *)port;
>> +	unsigned int status;
>> +
>> +	do {
>> +		status = serial_in(up, UART_LSR);
>> +		udelay(1);
>> +	} while ((status & BOTH_EMPTY) != BOTH_EMPTY);
>> +
> 
> Shouldn't you use wait_for_xmitr() instead? If you do that, then you
> don't need to move the BOTH_EMPTY macro anymore.
> 
Initially, I had used the wait_for_xmitr, but the gdb couldn't establish
a connection. I will retest it.

>> +	serial_out(up, UART_TX, ch);
>> +}
>> +
>> +static int serial_omap_poll_get_char(struct uart_port *port)
>> +{
>> +	struct uart_omap_port *up = (struct uart_omap_port *)port;
>> +	unsigned int status;
>> +	int ch;
>> +
>> +	do {
>> +		status = serial_in(up, UART_LSR);
>> +		udelay(1);
>> +	} while ((status & UART_LSR_DR) != UART_LSR_DR);
>> +
> 
> I think you should be returning NO_POLL_CHAR if the condition is false,
> instead of busy looping.
> 
>> +	ch = (int)serial_in(up, UART_RX);
>> +	return ch;
>> +}
> 
> I don't think you need the extra ch variable. Just return serial_in(up,
> UART_RX).
> 
Here, I agree with your comments.

> Cheers,
> Ionut.
> 
> 

Regards,
Cosmin
