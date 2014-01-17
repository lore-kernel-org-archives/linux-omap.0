From: Tony Lindgren <tony@atomide.com>
Subject: Re: Issues with GPIO and wake from sleep
Date: Fri, 17 Jan 2014 09:39:03 -0800
Message-ID: <20140117173902.GD7235@atomide.com>
References: <F690310232FDDF4AB457E8B3EF90DDE09A56D39C@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32268 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbaAQRjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 12:39:07 -0500
Content-Disposition: inline
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE09A56D39C@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Marc Murphy <marcmltd@marcm.co.uk> [140117 04:32]:
> I have resisted contacting the list with regards to an issue I am hav=
ing trying to get what should be a simple part of my system working but=
 I cannot find any documentation or other posts to help.
> =20
> I am using 3.6 kernel but have tried 3.12 to see if the issue has bee=
n addressed in that but its exactly the same.
> =20
> I am attempting to get a GPIO to wake my AM3517 system up from a susp=
end to memory.  I have tried with a few different options for GPIO=E2=80=
=99s
> I have available GPIO-10, GPIO-28 and GPIO-30.
> =20
> I started by using GPIO-28 and that would configure nicely and I set =
up the interrupt handler and could see my debug when triggering the inp=
ut (brilliant) but for some reason I cannot use it  to wake the system =
as it is not in the correct group for wakeup.  There is a note in the T=
ech Ref Man -
>=20
> Only gpio_1, gpio_9, gpio_10, gpio_11, gpio_30, and gpio_31 can be us=
ed to generate a direct wake-up event.
>=20
> So have to use a different one. GPIO-30 cannot be used as that holds =
the system in reset, so all that is left is GPIO-10.
> All seems to be good for initialisation;

I think you don't need the mux wake-up bits for the first GPIO bank, it=
's
always powered. So just setting gpio10 as an interrupt should keep it
working through suspend. The GPIO driver has it's own idle handling for
the first bank, see _set_gpio_wakeup().

Maybe you just need to do set_irq_wake() in the interrupt number
for gpio10?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
