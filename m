From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Tue, 16 Sep 2014 18:55:37 +0200
Message-ID: <54186B89.8050505@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de> <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de> <5411B33F.10405@hurleysoftware.com> <54171B85.5060209@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <54171B85.5060209@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 09/15/2014 07:01 PM, Sebastian Andrzej Siewior wrote:
> On 09/11/2014 04:35 PM, Peter Hurley wrote:
>> I do need to find out if omap hardware sets UART_MSR_DCTS when auto =
CTS
>> is on. Would you mind running the debug patch below with HW flow con=
trol on?
>=20
> I didn't forget about this. However I told minicom to use hardware fl=
ow
> control (and I see the driver set the HW bit) but I haven't seen that
> uart_handle_cts_change() has been invoked at all. I'm going to check
> two other boards and report then.

No, I don't get into this at all function. So I connected my am335x-evm
with beagle board xm because both of them have an old fashion UART
connector (instead those uart-to-usb). Both configured with HW-Flow and
I haven't seen the function invoked but I saw "port->icount.overrun"
being incremented. This shouldn't happen. So I am a little puzzled here=
=E2=80=A6

>> Regards,
>> Peter Hurley
>=20

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
