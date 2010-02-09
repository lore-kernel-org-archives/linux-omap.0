From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: Serial: Improved sleep logic
Date: Tue, 9 Feb 2010 16:40:40 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224BA884E17@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1265110224-29473-1-git-send-email-tero.kristo@nokia.com>
 <87ljf83dhw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41453 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255Ab0BIPlW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 10:41:22 -0500
In-Reply-To: <87ljf83dhw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 04 February, 2010 23:20
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: Serial: Improved sleep logic
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Only RX interrupt will now kick the sleep prevent timer. In 
>addition, TX
>> fifo status is checked before disabling clocks, this will 
>prevent occasional
>> garbage being printed on serial line. Smartidle is also 
>disabled while
>> entering idle if we have data in the transmit buffer, 
>because having this
>> enabled will prevent wakeups from the TX interrupt, and this causes
>> pauses while sending large blocks of data.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>After doing some more testing with this, something is not quite right
>still.  I haven't taken the time to debug further, but with this patch
>on top of the current PM branch, the timer seems to expire and disable
>clocks whether or not there is UART activity.

This seems to be caused by the buggy timer usage inside serial.c. The code uses jiffy timers for expire checks, and this is actually invalid inside omap_sram_idle. Jiffy timer is stopped inside the ARM idle entry (cpu_idle -> tick_nohz_stop_sched_tick()). This causes the jiffies value to be the same when we enter idle, and while we are resuming idle, thus making the timer to expire at rather random time. If you sleep for 4 seconds and wake using serial, the device enters sleep again after one second. This can be fixed by using ktime_get() instead of jiffy timer, as ktime_get() uses directly HW 32k tick timer. I'll hack together a version of this code where I use ktime_get() for the sleep expiry checks and see if it fixes this issue.

>In particular, using a UART1 console on OMAP3EVM, I notice that while
>typing longer commands (that take more that <timeout> seconds to type),
>I notice that I loose chars in the middle of typing.  /me doesn't like.
>
>So I won't be applying this to the PM branch until we can figure out
>what's happening here.
>
>Kevin
>
>> ---
>>  arch/arm/mach-omap2/serial.c |   19 +++++++++++++++----
>>  1 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c 
>b/arch/arm/mach-omap2/serial.c
>> index 777e802..e11dfe9 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -317,7 +317,8 @@ static void omap_uart_allow_sleep(struct 
>omap_uart_state *uart)
>>  	if (!uart->clocked)
>>  		return;
>>  
>> -	omap_uart_smart_idle_enable(uart, 1);
>> +	if (serial_read_reg(uart->p, UART_LSR) & UART_LSR_TEMT)
>> +		omap_uart_smart_idle_enable(uart, 1);
>>  	uart->can_sleep = 1;
>>  	del_timer(&uart->timer);
>>  }
>> @@ -335,7 +336,11 @@ void omap_uart_prepare_idle(int num)
>>  
>>  	list_for_each_entry(uart, &uart_list, node) {
>>  		if (num == uart->num && uart->can_sleep) {
>> -			omap_uart_disable_clocks(uart);
>> +			if (serial_read_reg(uart->p, UART_LSR) &
>> +					UART_LSR_TEMT)
>> +				omap_uart_disable_clocks(uart);
>> +			else
>> +				omap_uart_smart_idle_enable(uart, 0);
>>  			return;
>>  		}
>>  	}
>> @@ -407,8 +412,14 @@ int omap_uart_can_sleep(void)
>>  static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
>>  {
>>  	struct omap_uart_state *uart = dev_id;
>> +	u8 lsr;
>>  
>> -	omap_uart_block_sleep(uart);
>> +	lsr = serial_read_reg(uart->p, UART_LSR);
>> +	/* Check for receive interrupt */
>> +	if (lsr & UART_LSR_DR)
>> +		omap_uart_block_sleep(uart);
>> +	if (lsr & UART_LSR_TEMT && uart->can_sleep)
>> +		omap_uart_smart_idle_enable(uart, 1);
>>  
>>  	return IRQ_NONE;
>>  }
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>