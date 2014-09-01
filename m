From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 03/15] tty: serial: 8250_core: add run time pm
Date: Mon, 01 Sep 2014 16:48:00 +0200
Message-ID: <54048720.9000003@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <1408124563-31541-4-git-send-email-bigeasy@linutronix.de> <20140820092319.GA20775@ci00147.xsens-tech.local> <20140820093936.GB20775@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140820093936.GB20775@ci00147.xsens-tech.local>
Sender: linux-serial-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 08/20/2014 11:39 AM, Frans Klaver wrote:

>>>  static int serial8250_get_poll_char(struct uart_port *port)
>>>  {
>>> -	unsigned char lsr = serial_port_in(port, UART_LSR);
>>> +	unsigned char lsr;
>>> +	int status;
>>> +
>>> +	serial8250_rpm_get(up);
>>
>> or up won't be defined below. You probably need 
> 
> Obviously I meant to say that 'up' won't be defined here.

Good catch, thanks. However I wouldn't bet my money it that won't be
defined here. The semaphore code provides up() and down() so it is
makes it kind of defined :) But it doesn't compile due to wrong pointer
types which is good (I run into this myself and looked confused at
first).
I didn't notice this at all because only kgdb uses this
CONFIG_CONSOLE_POLL which I had off. Once again, thank you.

>> +	struct uart_8250_port *up = up_to_u8250p(port);
>> somewhere in there.

Sebastian
