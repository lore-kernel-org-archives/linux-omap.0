From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: Serial: Improved sleep logic
Date: Thu, 4 Feb 2010 09:00:54 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A223727D496C@NOK-EUMSG-02.mgdnok.nokia.com>
References: <> <1265110224-29473-1-git-send-email-tero.kristo@nokia.com>
 <20100203175000.GF22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45381 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab0BDIBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 03:01:42 -0500
In-Reply-To: <20100203175000.GF22747@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Tony Lindgren [mailto:tony@atomide.com] 
>Sent: 03 February, 2010 19:50
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: Serial: Improved sleep logic
>
>* Tero Kristo <tero.kristo@nokia.com> [100202 01:38]:
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
>
>Sounds this is for 2.6.34 merge window and does not contain anything
>that needs to be fixed for 2.6.33. 

Yeah, this only fixes a couple of annoying issues, but nothing fatal. Also improves power efficiency in some cases which is a nice to have feature, and basically eases the development of PM code as the UART does not block the system from sleeping always.

-Tero

>
>Regards,
>
>Tony
>
> 
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
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