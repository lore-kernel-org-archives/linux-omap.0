From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] tty: serial: omap: use mctrl_gpio helpers
Date: Tue, 26 May 2015 09:04:52 +0200
Message-ID: <CAGm1_ksofPwNmvmzo_8h0L1xHnZjEfYa7YYey6dF=TsYVPELtQ@mail.gmail.com>
References: <1432297017-1264-1-git-send-email-yegorslists@googlemail.com>
 <555F4C7F.9020307@ti.com> <20150522165212.GZ10274@atomide.com>
 <20150522173816.GE5582@saruman.tx.rr.com> <20150522175429.GB10274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33896 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbEZHFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2015 03:05:14 -0400
In-Reply-To: <20150522175429.GB10274@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sekhar Nori <nsekhar@ti.com>

Hi Tony, Nishanth and Felipe,

On Fri, May 22, 2015 at 7:54 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Balbi <balbi@ti.com> [150522 10:41]:
>> On Fri, May 22, 2015 at 09:52:13AM -0700, Tony Lindgren wrote:
>> > * Nishanth Menon <nm@ti.com> [150522 08:36]:
>> > > On 05/22/2015 07:16 AM, yegorslists@googlemail.com wrote:
>> > > > From: Yegor Yefremov <yegorslists@googlemail.com>
>> > > >
>> > > > This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
>> > > > signals.
>> > > >
>> > > > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> > > > ---
>> > > >  .../devicetree/bindings/serial/omap_serial.txt     |    9 +
>> > > >  drivers/tty/serial/Kconfig                         |    1 +
>> > > >  drivers/tty/serial/omap-serial.c                   |  168 +++++++++++++++++++-
>> > > >  3 files changed, 171 insertions(+), 7 deletions(-)
>> > >
>> > > Would we rather move introducing new features to 8250_omap.c rather
>> > > than doing that to omap-serial and keep feature creeping it such that
>> > > we wont ever be able to switch to 8250_omap ?
>> >
>> > Yes please. Also, do we really want to allow mapping
>> > random GPIO pins to the UART driver? I guess it would be
>>
>> See drivers/tty/serial/serial_mctrl_gpio.[ch], these are used for UARTs
>> on SoCs with enough GPIOs available whose UART don't have full Modem
>> signals. It's pretty handy for BT, GSM, LTE, whatever type of modem-like
>> device.
>
> OK

I need this functionality for a real device having switchable
RS232/422/485 driver. So I need both RS232 signals, that are not all
possible to get via pinmux, and RS485 transmitter switching.

AFAIK RS485 feature is still not implemented in 8250. That's why I
would like this patch to be still included into omap_serial for now.

Yegor
