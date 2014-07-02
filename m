From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [RFC PATCH] tty: serial: Add 8250-core based omap driver
Date: Wed, 2 Jul 2014 22:09:44 +0300
Message-ID: <20140702190944.GA567@drone.musicnaut.iki.fi>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140702160932.GF5541@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Jul 02, 2014 at 11:09:32AM -0500, Felipe Balbi wrote:
> > It has been only tested as console UART.
> > The tty name is ttyS based instead of ttyO. How big is the pain here,
> > what could be the easiest way to provide compatibility?
> 
> have been considering that myself for months. You could pass an optional
> argument to serial8250_register_8250_port() but that only solves part of
> the problem :-(

When ttyS -> ttyO change was done on OMAP, compatibility was not an issue.
Why should we care about it now?

A.
