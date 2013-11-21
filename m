From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Thu, 21 Nov 2013 08:55:20 -0300
Message-ID: <20131121115519.GC2942@localhost>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131120220212.GA12776@localhost>
 <528DC168.7090204@linutronix.de>
 <20131121113025.GA2942@localhost>
 <528DF233.40502@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58071 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750844Ab3KULzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 06:55:14 -0500
Content-Disposition: inline
In-Reply-To: <528DF233.40502@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roger Quadros <rogerq@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>

On Thu, Nov 21, 2013 at 12:44:51PM +0100, Sebastian Andrzej Siewior wro=
te:
> On 11/21/2013 12:30 PM, Ezequiel Garcia wrote:
> > Ah, good to know. That patch should be picked ASAP, without it the =
USB
> > in AM335x is broken. Is it already too late to -rc1?
> Yes.
>=20
> > Who is supposed to merge that? Greg?
>=20
> Felipe will start collecting fixes once -rc1 is out [0] so it should =
be
> part of -rc2.
>=20

OK, fine by me. Please note that Felipe's commit is a much bigger (and
nicer) rework of the code, and that it doesn't clearly state it fixes
the current code.

=46elipe: Maybe you should add some message stating it fixes a regressi=
on?

Just a suggestion though...
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
