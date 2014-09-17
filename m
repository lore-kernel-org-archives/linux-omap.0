From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Wed, 17 Sep 2014 08:20:41 -0400
Message-ID: <54197C99.8030601@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de> <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de> <5411B33F.10405@hurleysoftware.com> <54171B85.5060209@linutronix.de> <54186B89.8050505@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54186B89.8050505@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 09/16/2014 12:55 PM, Sebastian Andrzej Siewior wrote:
> On 09/15/2014 07:01 PM, Sebastian Andrzej Siewior wrote:
>> On 09/11/2014 04:35 PM, Peter Hurley wrote:
>>> I do need to find out if omap hardware sets UART_MSR_DCTS when auto=
 CTS
>>> is on. Would you mind running the debug patch below with HW flow co=
ntrol on?
>>
>> I didn't forget about this. However I told minicom to use hardware f=
low
>> control (and I see the driver set the HW bit) but I haven't seen tha=
t
>> uart_handle_cts_change() has been invoked at all. I'm going to check
>> two other boards and report then.
>=20
> No, I don't get into this at all function.

Ok, good to know. Thanks for testing that.

> So I connected my am335x-evm
> with beagle board xm because both of them have an old fashion UART
> connector (instead those uart-to-usb). Both configured with HW-Flow a=
nd
> I haven't seen the function invoked but I saw "port->icount.overrun"
> being incremented. This shouldn't happen. So I am a little puzzled he=
re=E2=80=A6

Yeah, that's weird. Do you have a break-out box to confirm that RTS/CTS=
 are
being driven?

Regards,
Peter Hurley
