From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] tty: serial: omap: use mctrl_gpio helpers
Date: Fri, 22 May 2015 09:52:13 -0700
Message-ID: <20150522165212.GZ10274@atomide.com>
References: <1432297017-1264-1-git-send-email-yegorslists@googlemail.com>
 <555F4C7F.9020307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53038 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945929AbbEVQwQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 May 2015 12:52:16 -0400
Content-Disposition: inline
In-Reply-To: <555F4C7F.9020307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: yegorslists@googlemail.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Sekhar Nori <nsekhar@ti.com>

* Nishanth Menon <nm@ti.com> [150522 08:36]:
> On 05/22/2015 07:16 AM, yegorslists@googlemail.com wrote:
> > From: Yegor Yefremov <yegorslists@googlemail.com>
> > 
> > This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
> > signals.
> > 
> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > ---
> >  .../devicetree/bindings/serial/omap_serial.txt     |    9 +
> >  drivers/tty/serial/Kconfig                         |    1 +
> >  drivers/tty/serial/omap-serial.c                   |  168 +++++++++++++++++++-
> >  3 files changed, 171 insertions(+), 7 deletions(-)
> 
> Would we rather move introducing new features to 8250_omap.c rather
> than doing that to omap-serial and keep feature creeping it such that
> we wont ever be able to switch to 8250_omap ?

Yes please. Also, do we really want to allow mapping
random GPIO pins to the UART driver? I guess it would be
handy for powering UART connected devices like BT up
and down..

There's one fix pending to 8250_omap for mainline BTW:

[PATCH] serial: 8250_omap: provide complete custom startup & shutdown callbacks

But other than that it seems to behave at least for me.

Regards,

Tony
