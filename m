From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/6] tty: serial: 8250 core: add runtime pm
Date: Wed, 16 Jul 2014 10:26:38 +0200
Message-ID: <53C6373E.2010408@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de> <1404928177-26554-4-git-send-email-bigeasy@linutronix.de> <20140710062812.GF28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140710062812.GF28884@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 07/10/2014 08:28 AM, Tony Lindgren wrote:
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -571,7 +573,17 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>>  			serial_out(p, UART_EFR, 0);
>>  			serial_out(p, UART_LCR, 0);
>>  		}
>> +
>> +		if (!device_may_wakeup(p->port.dev)) {
>> +			if (sleep)
>> +				pm_runtime_forbid(p->port.dev);
>> +			else
>> +				pm_runtime_allow(p->port.dev);
>> +		}
>>  	}
>> +out:
>> +	pm_runtime_mark_last_busy(p->port.dev);
>> +	pm_runtime_put_autosuspend(p->port.dev);
>>  }
> 
> The device_may_wakeup logic here is wrong as I described in the
> earlier thread. For runtime PM, the wake-up events should be
> always enabled. So the device_may_wakeup checks should be only
> done for suspend and resume.

Okay. I dropped it from here.

> 
> Regards,
> 
> Tony
> 

Sebastian
