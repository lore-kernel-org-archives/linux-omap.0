From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCHv5] OMAP3: Serial: Improved sleep logic
Date: Thu, 25 Feb 2010 09:43:51 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224BF580B19@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266421892-1021-1-git-send-email-tero.kristo@nokia.com>
 <877hq2sjpy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29646 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab0BYIoT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 03:44:19 -0500
In-Reply-To: <877hq2sjpy.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 24 February, 2010 18:05
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv5] OMAP3: Serial: Improved sleep logic
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> This patch contains following improvements:
>> - Only RX interrupt will now kick the sleep prevent timer
>> - TX fifo status is checked before disabling clocks, this 
>will prevent
>>   on-going transmission to be cut
>> - Smartidle is now enabled/disabled only while switching 
>clocks, as having
>>   smartidle enabled while RX/TX prevents any interrupts from being
>>   received from UART module
>> - Sleep prevent timer is changed to use timespec instead of 
>a jiffy timer
>>   as jiffy timers are not valid within idle loop (tick 
>scheduler is stopped)
>
>Could also probably use hrtimers for this.

Maybe, I didn't try this out though. It is possible that there are some issues as hrtimers use ktime() as far as I understand and it is not accessible during suspend. There is a separate issue with this patch and suspend though, I am currently working on a fix for that. Suspend skewes the timebase even more, and we get expire timers that point far into the future after suspend.

>
>That being said, I'm not sure what is the problem you're trying to
>solve with this change.  I don't see any timings that are timing events
>inside the idle loop.

Here is the call-chain that currently accesses jiffies count incorrectly:

cpu_idle:
   tick_nohz_stop_sched_tick(1); /* jiffy timer stops here */
   omap_sram_idle();
     omap_uart_prepare_idle();
     asm("wfi"); /* sleep here for N seconds */
     omap_uart_resume_idle(); /* This call uses incorrect jiffy timer now */
   tick_nohz_restart_sched_tick(); /* jiffy timer restarted here, and jiffy timer is refreshed also to correct value */

>
>> - Added RX ignore timer for ignoring the first character 
>received during
>>   first millisecond of wakeup, this prevents garbage 
>character to be receive
>>   in low sleep states
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>Something is still not quite right here.
>
>This doesn't work on my n900 here when testing this patch on top of
>the PM branch.  The default is now a default timeout of zero.  When I
>enable a 5 sec. timeout for UART2 on RX-51, when the timer expires, I
>no longer have response on the console.
>
>To test, I booted my n900 with init=/bin/sh to avoid all the setup
>done by /sbin/preinit.  Then I enabled a timeout for UART2 only, and
>then the console hangs.
>
>Here's my hunch as to what's happening:
>
>I think the problem is a deadlock in getrawmonotonic().  Nested calls
>here will deadlock due to the xtime_lock being held.

Looking at the seqlock code, I think a seqlock reader can "hang" only in a case where someone is constantly writing the seqlock. And, as we are inside interrupt, this should not be possible.

>When updading the timeout, sleep_timeout_store() does a
>getrawmonotonic() to update the expiry time.  While this happening,
>the UART interrupt could fire, causing an omap_uart_block_sleep()
>which would also getrawmonotonic() and deadlock in interrupt mode.

It does not really explain why it hangs after the 5 second period though, as the device has called getrawmonotonic several times by this already. I have not seen this kind of behavior in my testing, even while fiddling with the sleep_timeout_store().

Anyway, I'll attempt to re-run my test on the latest PM / master branches and see what happens.

>
>Kevin
>
>> ---
>>  arch/arm/mach-omap2/serial.c |   98 
>+++++++++++++++++++++++++++++------------
>>  1 files changed, 69 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c 
>b/arch/arm/mach-omap2/serial.c
>> index 5f3035e..f49c465 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -29,6 +29,8 @@
>>  #include <plat/clock.h>
>>  #include <plat/control.h>
>>  
>> +#include <asm/div64.h>
>> +
>>  #include "prm.h"
>>  #include "pm.h"
>>  #include "prm-regbits-34xx.h"
>> @@ -42,13 +44,14 @@
>>   * disabled via sysfs. This also causes that any deeper 
>omap sleep states are
>>   * blocked. 
>>   */
>> -#define DEFAULT_TIMEOUT 0
>> +#define DEFAULT_TIMEOUT (0LL * NSEC_PER_SEC)
>>  
>>  struct omap_uart_state {
>>  	int num;
>>  	int can_sleep;
>> -	struct timer_list timer;
>> -	u32 timeout;
>> +	struct timespec expire_time;
>> +	struct timespec garbage_time;
>> +	u64 timeout;
>>  
>>  	void __iomem *wk_st;
>>  	void __iomem *wk_en;
>> @@ -243,6 +246,9 @@ static inline void 
>omap_uart_save_context(struct omap_uart_state *uart) {}
>>  static inline void omap_uart_restore_context(struct 
>omap_uart_state *uart) {}
>>  #endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
>>  
>> +static void omap_uart_smart_idle_enable(struct 
>omap_uart_state *uart,
>> +		int enable);
>> +
>>  static inline void omap_uart_enable_clocks(struct 
>omap_uart_state *uart)
>>  {
>>  	if (uart->clocked)
>> @@ -250,8 +256,13 @@ static inline void 
>omap_uart_enable_clocks(struct omap_uart_state *uart)
>>  
>>  	clk_enable(uart->ick);
>>  	clk_enable(uart->fck);
>> +	omap_uart_smart_idle_enable(uart, 0);
>>  	uart->clocked = 1;
>>  	omap_uart_restore_context(uart);
>> +
>> +	/* Set up garbage timer to ignore RX during first 1ms */
>> +	getrawmonotonic(&uart->garbage_time);
>> +	timespec_add_ns(&uart->garbage_time, NSEC_PER_MSEC);
>>  }
>>  
>>  #ifdef CONFIG_PM
>> @@ -263,6 +274,7 @@ static inline void 
>omap_uart_disable_clocks(struct omap_uart_state *uart)
>>  
>>  	omap_uart_save_context(uart);
>>  	uart->clocked = 0;
>> +	omap_uart_smart_idle_enable(uart, 1);
>>  	clk_disable(uart->ick);
>>  	clk_disable(uart->fck);
>>  }
>> @@ -320,12 +332,11 @@ static void 
>omap_uart_block_sleep(struct omap_uart_state *uart)
>>  {
>>  	omap_uart_enable_clocks(uart);
>>  
>> -	omap_uart_smart_idle_enable(uart, 0);
>>  	uart->can_sleep = 0;
>> -	if (uart->timeout)
>> -		mod_timer(&uart->timer, jiffies + uart->timeout);
>> -	else
>> -		del_timer(&uart->timer);
>> +	if (uart->timeout) {
>> +		getrawmonotonic(&uart->expire_time);
>> +		timespec_add_ns(&uart->expire_time, uart->timeout);
>> +	}
>>  }
>>  
>>  static void omap_uart_allow_sleep(struct omap_uart_state *uart)
>> @@ -338,25 +349,24 @@ static void 
>omap_uart_allow_sleep(struct omap_uart_state *uart)
>>  	if (!uart->clocked)
>>  		return;
>>  
>> -	omap_uart_smart_idle_enable(uart, 1);
>>  	uart->can_sleep = 1;
>> -	del_timer(&uart->timer);
>> -}
>> -
>> -static void omap_uart_idle_timer(unsigned long data)
>> -{
>> -	struct omap_uart_state *uart = (struct omap_uart_state *)data;
>> -
>> -	omap_uart_allow_sleep(uart);
>>  }
>>  
>>  void omap_uart_prepare_idle(int num)
>>  {
>>  	struct omap_uart_state *uart;
>> +	struct timespec t;
>>  
>>  	list_for_each_entry(uart, &uart_list, node) {
>> +		if (num == uart->num && !uart->can_sleep && 
>uart->timeout) {
>> +			getrawmonotonic(&t);
>> +			if (timespec_compare(&t, 
>&uart->expire_time) > 0)
>> +				uart->can_sleep = 1;
>> +		}
>>  		if (num == uart->num && uart->can_sleep) {
>> -			omap_uart_disable_clocks(uart);
>> +			if (serial_read_reg(uart->p, UART_LSR) &
>> +					UART_LSR_TEMT)
>> +				omap_uart_disable_clocks(uart);
>>  			return;
>>  		}
>>  	}
>> @@ -381,6 +391,7 @@ void omap_uart_resume_idle(int num)
>>  			/* Check for normal UART wakeup */
>>  			if (__raw_readl(uart->wk_st) & uart->wk_mask)
>>  				omap_uart_block_sleep(uart);
>> +
>>  			return;
>>  		}
>>  	}
>> @@ -399,11 +410,18 @@ int omap_uart_can_sleep(void)
>>  {
>>  	struct omap_uart_state *uart;
>>  	int can_sleep = 1;
>> +	struct timespec t;
>>  
>>  	list_for_each_entry(uart, &uart_list, node) {
>>  		if (!uart->clocked)
>>  			continue;
>>  
>> +		if (!uart->can_sleep && uart->timeout) {
>> +			getrawmonotonic(&t);
>> +			if (timespec_compare(&t, 
>&uart->expire_time) > 0)
>> +				uart->can_sleep = 1;
>> +		}
>> +
>>  		if (!uart->can_sleep) {
>>  			can_sleep = 0;
>>  			continue;
>> @@ -428,10 +446,25 @@ int omap_uart_can_sleep(void)
>>  static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
>>  {
>>  	struct omap_uart_state *uart = dev_id;
>> +	u8 lsr;
>> +	int ret = IRQ_NONE;
>> +	struct timespec t;
>>  
>> -	omap_uart_block_sleep(uart);
>> +	lsr = serial_read_reg(uart->p, UART_LSR);
>> +	/* Check for receive interrupt */
>> +	if (lsr & UART_LSR_DR) {
>> +		omap_uart_block_sleep(uart);
>> +		if (uart->garbage_time.tv_sec) {
>> +			getrawmonotonic(&t);
>> +			if (timespec_compare(&t, 
>&uart->garbage_time) < 0) {
>> +				serial_read_reg(uart->p, UART_RX);
>> +				uart->garbage_time.tv_sec = 0;
>> +				ret = IRQ_HANDLED;
>> +			}
>> +		}
>> +	}
>>  
>> -	return IRQ_NONE;
>> +	return ret;
>>  }
>>  
>>  static void omap_uart_idle_init(struct omap_uart_state *uart)
>> @@ -441,10 +474,12 @@ static void omap_uart_idle_init(struct 
>omap_uart_state *uart)
>>  
>>  	uart->can_sleep = 0;
>>  	uart->timeout = DEFAULT_TIMEOUT;
>> -	setup_timer(&uart->timer, omap_uart_idle_timer,
>> -		    (unsigned long) uart);
>> -	if (uart->timeout)
>> -		mod_timer(&uart->timer, jiffies + uart->timeout);
>> +
>> +	if (uart->timeout) {
>> +		getrawmonotonic(&uart->expire_time);
>> +		timespec_add_ns(&uart->expire_time, uart->timeout);
>> +	}
>> +
>>  	omap_uart_smart_idle_enable(uart, 0);
>>  
>>  	if (cpu_is_omap34xx()) {
>> @@ -527,8 +562,12 @@ static ssize_t 
>sleep_timeout_show(struct device *dev,
>>  					struct platform_device, dev);
>>  	struct omap_uart_state *uart = container_of(pdev,
>>  					struct omap_uart_state, pdev);
>> +	u64 val;
>> +
>> +	val = uart->timeout;
>>  
>> -	return sprintf(buf, "%u\n", uart->timeout / HZ);
>> +	do_div(val, NSEC_PER_SEC);
>> +	return sprintf(buf, "%llu\n", val);
>>  }
>>  
>>  static ssize_t sleep_timeout_store(struct device *dev,
>> @@ -546,10 +585,11 @@ static ssize_t 
>sleep_timeout_store(struct device *dev,
>>  		return -EINVAL;
>>  	}
>>  
>> -	uart->timeout = value * HZ;
>> -	if (uart->timeout)
>> -		mod_timer(&uart->timer, jiffies + uart->timeout);
>> -	else
>> +	uart->timeout = (u64)value * NSEC_PER_SEC;
>> +	if (uart->timeout) {
>> +		getrawmonotonic(&uart->expire_time);
>> +		timespec_add_ns(&uart->expire_time, uart->timeout);
>> +	} else
>>  		/* A zero value means disable timeout feature */
>>  		omap_uart_block_sleep(uart);
>>  
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>