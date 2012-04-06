From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default pads
Date: Fri, 6 Apr 2012 11:35:27 +0530
Message-ID: <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com> <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42879 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752876Ab2DFGFt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Apr 2012 02:05:49 -0400
Received: by obbuo13 with SMTP id uo13so3485823obb.34
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 23:05:47 -0700 (PDT)
In-Reply-To: <20120405165811.GB3785@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

On Thu, Apr 5, 2012 at 10:28 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Raja, Govindraj <govindraj.raja@ti.com> [120403 23:18]:
>> On Tue, Apr 3, 2012 at 11:49 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> > * Govindraj.R <govindraj.raja@ti.com> [120321 03:06]:
>> >> From: "Govindraj.R" <govindraj.raja@ti.com>
>> >>
>> >> The following commit:
>> >> (7496ba3 =A0ARM: OMAP2+: UART: Add default mux for all uarts)
>> >> added default pads for all uarts. But not all boards tend to
>> >> use all uarts and most of unused uart pins are muxed for
>> >> other purpose. This commit breaks the modules which where trying
>> >> to use unused uart pins on their boards.
>> >>
>> >> So remove all default pads except uart1/3 as most boards
>> >> tend to use either uart1/3 as console port and use only tx/rx
>> >> lines, declare only those pads for uart1/3.
>> >> If any boards tend to use any other uart other uart1/3
>> >> the mux data should to passed from board file and init individual
>> >> uart port using omap_serial_init_port api.
>> >
>> > This is still wrong. We can't mux any serial pins unless specifica=
lly
>> > requested from the board-*.c files. So please do a fix to get back=
 to
>> > v3.2 behaviour where you basically revert 7496ba3.
>>
>> How to do we fix the rx pin wakeup capability?
>> The mux data has the info about the rx pin wakeup
>>
>> Without rx pin wakeup PM will be broken.
>
> Let's first make things work reliably before even getting started
> about PM being broken.
>

okay.

>> Fix all board files with duplicated data for uart3 or
>> uart1 having rx pin marked as wakeup capable?
>
> And how do you know which pins to mux? You don't, unless you look
> at the schematics for all the boards.
>

agree even I am not sure of uarts used for console on all boards


> The only safe option without looking at the schematics is to
> make omap_serial_init not do any muxing. If you want muxing and
> PM wake-up events, then use omap_serial_init_port for those ports
> with board specific pins.

okay.

>
>> Behavior in v3.2 was raw_write to all uarts rx_pin to enable wakeup
>> enable bit.
>
> Hmm I don't think any muxing was done automatically unless
> omap_serial_init_port was being called with pins.

Muxing was happening even if we don't call omap_serial_init_port
rx pin was muxed for wakeup capability for all uart pins

omap_uart_idle_init =3D> was populating padconf offset value for ech ua=
rt
which was used in omap_uart_enable/disable_wakeup functions.
This mechanism was keeping PM happening for all boards.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
