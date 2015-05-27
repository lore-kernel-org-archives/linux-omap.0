From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] tty: serial: omap: use mctrl_gpio helpers
Date: Wed, 27 May 2015 11:31:03 +0530
Message-ID: <55655D9F.107@ti.com>
References: <1432297017-1264-1-git-send-email-yegorslists@googlemail.com> <555F4C7F.9020307@ti.com> <20150522165212.GZ10274@atomide.com> <20150522173816.GE5582@saruman.tx.rr.com> <20150522175429.GB10274@atomide.com> <CAGm1_ksofPwNmvmzo_8h0L1xHnZjEfYa7YYey6dF=TsYVPELtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49869 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbbE0GBW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2015 02:01:22 -0400
In-Reply-To: <CAGm1_ksofPwNmvmzo_8h0L1xHnZjEfYa7YYey6dF=TsYVPELtQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Tuesday 26 May 2015 12:34 PM, Yegor Yefremov wrote:
> Hi Tony, Nishanth and Felipe,
> 
> On Fri, May 22, 2015 at 7:54 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Felipe Balbi <balbi@ti.com> [150522 10:41]:
>>> On Fri, May 22, 2015 at 09:52:13AM -0700, Tony Lindgren wrote:
>>>> * Nishanth Menon <nm@ti.com> [150522 08:36]:
>>>>> On 05/22/2015 07:16 AM, yegorslists@googlemail.com wrote:
>>>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>>>
>>>>>> This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
>>>>>> signals.
>>>>>>
>>>>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/serial/omap_serial.txt     |    9 +
>>>>>>  drivers/tty/serial/Kconfig                         |    1 +
>>>>>>  drivers/tty/serial/omap-serial.c                   |  168 +++++++++++++++++++-
>>>>>>  3 files changed, 171 insertions(+), 7 deletions(-)
>>>>>
>>>>> Would we rather move introducing new features to 8250_omap.c rather
>>>>> than doing that to omap-serial and keep feature creeping it such that
>>>>> we wont ever be able to switch to 8250_omap ?
>>>>
>>>> Yes please. Also, do we really want to allow mapping
>>>> random GPIO pins to the UART driver? I guess it would be
>>>
>>> See drivers/tty/serial/serial_mctrl_gpio.[ch], these are used for UARTs
>>> on SoCs with enough GPIOs available whose UART don't have full Modem
>>> signals. It's pretty handy for BT, GSM, LTE, whatever type of modem-like
>>> device.
>>
>> OK
> 
> I need this functionality for a real device having switchable
> RS232/422/485 driver. So I need both RS232 signals, that are not all
> possible to get via pinmux, and RS485 transmitter switching.
> 
> AFAIK RS485 feature is still not implemented in 8250. That's why I
> would like this patch to be still included into omap_serial for now.

No one I know in TI has used or tested the RS485 functionality. Thats
why Sebastian left it when he created the 8250_omap driver. Since you
have the setup to test it, is it possible for you to migrate that
functionality to 8250_omap.c itself rather than enhance omap-serial.c?

We really want to be gravitating towards 8250_omap.c and this patch will
take us backwards. As a bonus you get more efficient interrupt handling
etc with the new driver.

Thanks,
Sekhar
