From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default
 pads
Date: Thu, 5 Apr 2012 09:58:12 -0700
Message-ID: <20120405165811.GB3785@atomide.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com>
 <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64080 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2DEQ6Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 12:58:16 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

* Raja, Govindraj <govindraj.raja@ti.com> [120403 23:18]:
> On Tue, Apr 3, 2012 at 11:49 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Govindraj.R <govindraj.raja@ti.com> [120321 03:06]:
> >> From: "Govindraj.R" <govindraj.raja@ti.com>
> >>
> >> The following commit:
> >> (7496ba3 =C2=A0ARM: OMAP2+: UART: Add default mux for all uarts)
> >> added default pads for all uarts. But not all boards tend to
> >> use all uarts and most of unused uart pins are muxed for
> >> other purpose. This commit breaks the modules which where trying
> >> to use unused uart pins on their boards.
> >>
> >> So remove all default pads except uart1/3 as most boards
> >> tend to use either uart1/3 as console port and use only tx/rx
> >> lines, declare only those pads for uart1/3.
> >> If any boards tend to use any other uart other uart1/3
> >> the mux data should to passed from board file and init individual
> >> uart port using omap_serial_init_port api.
> >
> > This is still wrong. We can't mux any serial pins unless specifical=
ly
> > requested from the board-*.c files. So please do a fix to get back =
to
> > v3.2 behaviour where you basically revert 7496ba3.
>=20
> How to do we fix the rx pin wakeup capability?
> The mux data has the info about the rx pin wakeup
>=20
> Without rx pin wakeup PM will be broken.

Let's first make things work reliably before even getting started
about PM being broken.

> Fix all board files with duplicated data for uart3 or
> uart1 having rx pin marked as wakeup capable?

And how do you know which pins to mux? You don't, unless you look
at the schematics for all the boards.

The only safe option without looking at the schematics is to
make omap_serial_init not do any muxing. If you want muxing and
PM wake-up events, then use omap_serial_init_port for those ports
with board specific pins.
=20
> Behavior in v3.2 was raw_write to all uarts rx_pin to enable wakeup
> enable bit.

Hmm I don't think any muxing was done automatically unless
omap_serial_init_port was being called with pins.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
