From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/6] tty: serial: 8250-core: add rs485 support
Date: Thu, 10 Jul 2014 17:55:08 +0200
Message-ID: <53BEB75C.70304@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de> <1404928177-26554-6-git-send-email-bigeasy@linutronix.de> <20140709190143.GF17769@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140709190143.GF17769@csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/09/2014 09:01 PM, Lennart Sorensen wrote:
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index c7c3bf7..bf06a4c 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -1281,10 +1283,34 @@ static void autoconfig_irq(struct uart_8250_port *up)
>>  
>>  static inline void __stop_tx(struct uart_8250_port *p)
>>  {
>> +	if (p->rs485.flags & SER_RS485_ENABLED) {
>> +		int ret;
>> +
>> +		ret = (p->rs485.flags & SER_RS485_RTS_AFTER_SEND) ? 1 : 0;
>> +		if (gpio_get_value(p->rts_gpio) != ret) {
>> +			if (p->rs485.delay_rts_after_send > 0)
>> +				mdelay(p->rs485.delay_rts_after_send);
>> +			gpio_set_value(p->rts_gpio, ret);
> 
> Usually the delay for RS485 is done in bit times, not msec.  Not sure
> how you expect this to work.  Not sure doing it in software is precise
> enough either.  It probably should be calculated based on the current
> baudrate with a bit time rather than msec in the DT data.  No one wants
> to have to change the DT data to change the baud rate.  After all this
> is very often used with modbus and the modbus rules specify turn around
> times in bit times.

My understanding is that this is not baudrate related. This is the
delay that the hardware (the transceiver) to perform the change and
work.
There is the ioctl() interface which can change the delay, too. The
only required thing is the gpio.

> I hope TI puts this into the UART in future designs where it belongs
> (similar to what Exar and many others already did).
> 

Sebastian
