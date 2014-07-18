From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
Date: Fri, 18 Jul 2014 11:53:21 -0400
Message-ID: <53C942F1.2000408@hurleysoftware.com>
References: <1405521903-5877-5-git-send-email-bigeasy@linutronix.de> <20140716151604.GG1365@saruman.home> <53C6A050.2050409@linutronix.de> <20140716160614.GI1365@saruman.home> <53C7EC6F.6060902@hurleysoftware.com> <20140717154300.GA16623@linutronix.de> <20140717160206.GI10459@saruman.home> <53C7F4A3.5080508@linutronix.de> <20140717161848.GK10459@saruman.home> <53C8DC3E.3020701@linutronix.de> <20140718153116.GN24914@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140718153116.GN24914@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 07/18/2014 11:31 AM, Felipe Balbi wrote:
> On Fri, Jul 18, 2014 at 10:35:10AM +0200, Sebastian Andrzej Siewior wrote:
>> >On 07/17/2014 06:18 PM, Felipe Balbi wrote:
>> >
>>>> > >>No, this is okay. If you look, it checks for "up->ier &
>>>> > >>UART_IER_THRI". On the second invocation it will see that this
>>>> > >>bit is already set and therefore won't call get_sync() for the
>>>> > >>second time. That bit is removed in the _stop_tx() path.
>>> > >
>>> > >oh, right. But that's actually unnecessary. Calling
>>> > >pm_runtime_get() multiple times will just increment the usage
>>> > >counter multiple times, which means you can call __stop_tx()
>>> > >multiple times too and everything gets balanced, right ?
>> >
>> >No. start_tx() will be called multiple times but only the first
>> >invocation invoke pm_runtime_get(). Now I noticed that I forgot to
> right, but that's unnecessary. You can pm_runtime_get() every time
> start_tx() is called. Just make sure to put everytime stop_tx() is
> called too.

The interface is asymmetric.

start_tx() may be invoked multiple times for which only 1 interrupt
will occur, and thus only invoke __stop_tx() once.

Regards,
Peter Hurley
