From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Wed, 17 Sep 2014 18:25:07 +0200
Message-ID: <5419B5E3.10307@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de> <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de> <5411B33F.10405@hurleysoftware.com> <54171B85.5060209@linutronix.de> <54186B89.8050505@linutronix.de> <54197C99.8030601@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49892 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbaIQQZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 12:25:17 -0400
In-Reply-To: <54197C99.8030601@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>

On 09/17/2014 02:20 PM, Peter Hurley wrote:
>> So I connected my am335x-evm
>> with beagle board xm because both of them have an old fashion UART
>> connector (instead those uart-to-usb). Both configured with HW-Flow =
and
>> I haven't seen the function invoked but I saw "port->icount.overrun"
>> being incremented. This shouldn't happen. So I am a little puzzled h=
ere=E2=80=A6
>=20
> Yeah, that's weird. Do you have a break-out box to confirm that RTS/C=
TS are
> being driven?

Yeah, I've been thinking about that, too. I will be gone next week and
hopefully when I get back I will something around to test this.

>=20
> Regards,
> Peter Hurley
>=20

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
