From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/3] serial: 8250: unlock port for uart_write_wakeup()
Date: Thu, 30 Jul 2015 19:53:24 -0400
Message-ID: <55BAB8F4.1060205@hurleysoftware.com>
References: <87h9ol2r4y.fsf@linutronix.de> <55BAB00B.3010806@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BAB00B.3010806@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2015 07:15 PM, Peter Hurley wrote:
> On 07/30/2015 06:54 PM, John Ogness wrote:
>> uart_write_wakeup() should be called without holding the port lock.
>> Otherwise a possible recursive spinlock issue can occur, such as
>> the following callchain:
>>
>> 8250_core.c:serial8250_tx_chars() - called with port locked
>>  serial_core.c:uart_write_wakeup()
>>   tty_io.c:tty_wakeup()
>>    st_core.c:st_tty_wakeup()
>>     st_core.c:st_tx_wakeup()
>>      st_core.c:st_int_write()
>>       serial_core.c:uart_write() - locks port
> 
> NAK.
> 
> This is a bug in the N_TI_WL line discipline, specifically in the
> st_tx_wakeup() function, which cannot perform the write synchronously.
> 
> This is a common line discipline bug, and typically fixed by performing
> the wakeup operations from a kworker instead.

Also, seriously consider if you want to use that TI line discipline at all.

If you're using it only for bluetooth w/ kernel bluetooth stack, you don't
need btwilink + st_drv anyway.

Regards,
Peter Hurley
