From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: serial-omap: depend on !8250_omap
Date: Sat, 29 Nov 2014 10:48:23 +0100
Message-ID: <20141129094823.GA10840@linutronix.de>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36707 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaK2Js0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Nov 2014 04:48:26 -0500
Content-Disposition: inline
In-Reply-To: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>, uwe@kleine-koenig.org

* Sebastian Andrzej Siewior | 2014-11-26 23:01:46 [+0100]:

>Technically speaking this is not required. If both are enabled then th=
e
>Maikefile order says that 8250 one wins, the second is never probed.
>
>If we choose to enable 8250_omap via defconfig then one might get supp=
rised
>that his console isn't working anymore since nothing says use ttySx
>instead ttyOx.
>This patch _tries_ to bring this to the users' attention by not showin=
g
>the serial-omap driver once the 8250 one is enabled. So the user might
>choose to use the help text which says that this driver (8250_omap)
>uses ttySx instead ttyOx.
>
>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>---
>This is my attempt to warn the defconfig user of the defconfig change
>(which did not yet happen). Any suggestions?

This is was Uwe Kleine-K=C3=B6nig suggested off-list:

|Currently there are two drivers for the serial device. Until the new o=
ne
|matured enough to drop the old one, let them conflict each other. They
|both handle the same devices, but only one can be responsible for a
|single device. There is no technical need, but having two drivers in t=
he
|same kernel might result in surprises.

I personally don't mind having two drivers enabled since the makefile
order is always the same. My main concern is the ttyOx -> ttySx switch
after the newer driver is enabled by default via defconfig (and the use=
r
does not know it). "make oldconfig" is covered by "default n".
Uwe's has a point about "matured enough to drop the old one". It isn't
mentioned anywhere that the newer driver supports also DMA. Is this
something we want to add to the help text?
Could someone that will probably be dealling with possible fallout comm=
ent
on this? This patch shouldn't go in without an ACK.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
