From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/4] tty: omap-serial: use threaded interrupt handler
Date: Mon, 15 Sep 2014 13:31:56 -0400
Message-ID: <5417228C.5070503@hurleysoftware.com>
References: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com> <1410789610-23059-4-git-send-email-frans.klaver@xsens.com> <54170823.7040801@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54170823.7040801-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexey Pelykh <alexey.pelykh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/15/2014 11:39 AM, Peter Hurley wrote:
> On 09/15/2014 10:00 AM, Frans Klaver wrote:
>> At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we see 1600 uart
>> rx buffer overflows within 30 seconds. Threading the interrupt handling reduces
>> this to about 170 overflows in 10 minutes.
> 
> Why is the threadirqs kernel boot option not sufficient?
> Or conversely, shouldn't this be selectable?

Also, do you see the same performance differential when you implement this
in the 8250 driver (that is, on top of Sebastian's omap->8250 conversion)?


> Regards,
> Peter Hurley
> 
> PS - To overflow the 64 byte RX FIFO at those data rates means interrupt
> latency in excess of 250us?
> 
>> In practice this therefore reduces the need for hardware flow control,
>> meaning the sending side doesn't have to buffer as much either.
>>
>> Signed-off-by: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/tty/serial/omap-serial.c | 30 +++++++++++++++++++++++-------
>>  1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index 7d3f557..398139a 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -575,6 +575,20 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
>>  }
>>  
>>  /**
>> + * serial_omap_fast_irq() - schedule interrupt handling
>> + */
>> +static irqreturn_t serial_omap_fast_irq(int irq, void *dev_id)
>> +{
>> +	struct uart_omap_port *up = dev_id;
>> +	unsigned int iir = serial_in(up, UART_IIR);
>> +
>> +	if (iir & UART_IIR_NO_INT)
>> +		return IRQ_NONE;
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +/**
>>   * serial_omap_irq() - This handles the interrupt from one port
>>   * @irq: uart port irq number
>>   * @dev_id: uart port info
>> @@ -584,7 +598,6 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
>>  	struct uart_omap_port *up = dev_id;
>>  	unsigned int iir, lsr;
>>  	unsigned int type;
>> -	irqreturn_t ret = IRQ_NONE;
>>  	int max_count = 256;
>>  
>>  	spin_lock(&up->port.lock);
>> @@ -595,7 +608,6 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
>>  		if (iir & UART_IIR_NO_INT)
>>  			break;
>>  
>> -		ret = IRQ_HANDLED;
>>  		lsr = serial_in(up, UART_LSR);
>>  
>>  		/* extract IRQ type from IIR register */
>> @@ -634,7 +646,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
>>  	pm_runtime_put_autosuspend(up->dev);
>>  	up->port_activity = jiffies;
>>  
>> -	return ret;
>> +	return IRQ_HANDLED;
>>  }
>>  
>>  static unsigned int serial_omap_tx_empty(struct uart_port *port)
>> @@ -731,15 +743,19 @@ static int serial_omap_startup(struct uart_port *port)
>>  	/*
>>  	 * Allocate the IRQ
>>  	 */
>> -	retval = request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
>> -				up->name, up);
>> +	retval = request_threaded_irq(up->port.irq, serial_omap_fast_irq,
>> +						serial_omap_irq,
>> +						IRQF_ONESHOT | up->port.irqflags,
>> +						up->name, up);
>>  	if (retval)
>>  		return retval;
>>  
>>  	/* Optional wake-up IRQ */
>>  	if (up->wakeirq) {
>> -		retval = request_irq(up->wakeirq, serial_omap_irq,
>> -				     up->port.irqflags, up->name, up);
>> +		retval = request_threaded_irq(up->wakeirq, serial_omap_fast_irq,
>> +						serial_omap_irq,
>> +						IRQF_ONESHOT | up->port.irqflags,
>> +						up->name, up);
>>  		if (retval) {
>>  			free_irq(up->port.irq, up);
>>  			return retval;
>>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
