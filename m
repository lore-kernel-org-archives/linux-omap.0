From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Thu, 12 Feb 2015 11:32:04 -0500
Message-ID: <54DCD584.3010500@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-4-git-send-email-bigeasy@linutronix.de> <54D8B772.1010405@freebox.fr> <54D9441B.7070403@hurleysoftware.com> <54D9F3C7.5000809@freebox.fr> <54DA43F8.9090904@hurleysoftware.com> <54DBB531.2030504@hurleysoftware.com> <20150211200313.GE2531@atomide.com> <54DBBE9E.90104@hurleysoftware.com> <54DC6832.3070507@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54DC6832.3070507@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Nicolas Schichan <nschichan@freebox.fr>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/12/2015 03:45 AM, Sebastian Andrzej Siewior wrote:
> On 02/11/2015 09:42 PM, Peter Hurley wrote:
> 
>>> Reverting makes sense to me if it has caused a regression. Maybe Sebastian
>>> can update his patch to do this based on some quirk flag instead?
>>
>> That's fine with me. There's a 'bugs' field in struct 8250_uart_port and
>> UART_BUG_* defines in 8250/8250.h for that purpose.
> 
> Makes sense. Reading an empty FIFO does not look right. Maybe we should
> do the bug flag the other way around? But I can do what I am told to so
> if there is more fallout than just this Marvell UART I could come
> around with a patch to the bug field for the older OMAP.

I agree with Russell on this; better to stick with the rx read that's been
running on 20 years of hardware.

That said, I don't think serial8250_do_startup() is really doing that much
for OMAP h/w startup; open-coding what omap_8250 really needs is probably
< 10 loc.

Regards,
Peter Hurley
