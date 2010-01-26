From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 0/4] twl4030 threaded_irq support
Date: Tue, 26 Jan 2010 10:07:49 +0000
Message-ID: <20100126100748.GC15759@rakim.wolfsonmicro.main>
References: <20091212183410.GF3092@sirena.org.uk>
 <1260786654-13294-1-git-send-email-felipe.balbi@nokia.com>
 <201001252306.55625.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753052Ab0AZKHx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201001252306.55625.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Samuel Ortiz <sameo@openedhand.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 25, 2010 at 11:06:55PM -0800, David Brownell wrote:
> On Monday 14 December 2009, Felipe Balbi wrote:

> > move twl4030 children to threaded irq.

> But nothing in drivers/mfd ... the entry to the whole stack?

> Did the threaded IRQ stuff ever get set up so that the top
> level IRQ thread didn't have to hand off to another thread
> each time?  (That's how the current stuff works.  One thread
> calling out to each handler.)

Yes, that's in mainline now.  There's two bits required to use it which
are (from the driver point of view) fairly orthogonal - one is to
convert the interrupt controller to use the new stuff, the other is to
make sure that all the drivers that are requesting the interrupts over
to threaded IRQ handlers.  genirq will require the threaded handlers
once it's being used.
