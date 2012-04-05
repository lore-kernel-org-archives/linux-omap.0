From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default
 pads
Date: Thu, 5 Apr 2012 10:02:56 -0700
Message-ID: <20120405170255.GC3785@atomide.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com>
 <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27517 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab2DERC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 13:02:59 -0400
Content-Disposition: inline
In-Reply-To: <20120405165811.GB3785@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

* Tony Lindgren <tony@atomide.com> [120405 10:01]:
> * Raja, Govindraj <govindraj.raja@ti.com> [120403 23:18]:
> > On Tue, Apr 3, 2012 at 11:49 PM, Tony Lindgren <tony@atomide.com> w=
rote:
> > > * Govindraj.R <govindraj.raja@ti.com> [120321 03:06]:
> > >> From: "Govindraj.R" <govindraj.raja@ti.com>
> > >>
> > >> The following commit:
> > >> (7496ba3 =C2=A0ARM: OMAP2+: UART: Add default mux for all uarts)
> > >> added default pads for all uarts. But not all boards tend to
> > >> use all uarts and most of unused uart pins are muxed for
> > >> other purpose. This commit breaks the modules which where trying
> > >> to use unused uart pins on their boards.
> > >>
> > >> So remove all default pads except uart1/3 as most boards
> > >> tend to use either uart1/3 as console port and use only tx/rx
> > >> lines, declare only those pads for uart1/3.
> > >> If any boards tend to use any other uart other uart1/3
> > >> the mux data should to passed from board file and init individua=
l
> > >> uart port using omap_serial_init_port api.
> > >
> > > This is still wrong. We can't mux any serial pins unless specific=
ally
> > > requested from the board-*.c files. So please do a fix to get bac=
k to
> > > v3.2 behaviour where you basically revert 7496ba3.
> >=20
> > How to do we fix the rx pin wakeup capability?
> > The mux data has the info about the rx pin wakeup
> >=20
> > Without rx pin wakeup PM will be broken.
>=20
> Let's first make things work reliably before even getting started
> about PM being broken.
>=20
> > Fix all board files with duplicated data for uart3 or
> > uart1 having rx pin marked as wakeup capable?
>=20
> And how do you know which pins to mux? You don't, unless you look
> at the schematics for all the boards.
>=20
> The only safe option without looking at the schematics is to
> make omap_serial_init not do any muxing. If you want muxing and
> PM wake-up events, then use omap_serial_init_port for those ports
> with board specific pins.

Something that might be doable is to read the pin settings for the
uart in question in omap_serial_init. And then bail out for that
port if the rx or tx pin is not already muxed to uart in question.
Only if the rx and tx pin is muxed for uart, then you can enable
the wake-up events.

So basically doing remuxing in serial.c is only safe when
omap_serial_init_port with mux data is being used.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
