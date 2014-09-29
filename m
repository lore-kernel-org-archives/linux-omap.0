From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Mon, 29 Sep 2014 18:15:05 +0200
Message-ID: <20140929161505.GF13142@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300>
 <54118AAB.2010205@linutronix.de>
 <5411967A.6090406@hurleysoftware.com>
 <54119AAA.9080907@linutronix.de>
 <5411B33F.10405@hurleysoftware.com>
 <54171B85.5060209@linutronix.de>
 <54186B89.8050505@linutronix.de>
 <54197C99.8030601@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54197C99.8030601@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

* Peter Hurley | 2014-09-17 08:20:41 [-0400]:

>> So I connected my am335x-evm
>> with beagle board xm because both of them have an old fashion UART
>> connector (instead those uart-to-usb). Both configured with HW-Flow =
and
>> I haven't seen the function invoked but I saw "port->icount.overrun"
>> being incremented. This shouldn't happen. So I am a little puzzled h=
ere=E2=80=A6
>
>Yeah, that's weird. Do you have a break-out box to confirm that RTS/CT=
S are
>being driven?

=3D>
- beagle board
  According to schematics the board has only RX and TX connected. No
  RTS/CTS

- am335x-evm
  The schematics say "DNI" next to a resistor on RTS/CTS. DNI stands
  most likely for "Do Not Install". With a scope it looks like the the
  wire behind the MAX is open.

- beagle bone black
  Only RX and TX are wired towards the USB2serial device.

In short: each device I have has RTS/CTS not working/connected and I
can't test HW handshake with HW available.

>Regards,
>Peter Hurley

Sebastian
