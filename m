From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI
	charger
Date: Fri, 27 Nov 2009 16:23:22 +0000
Message-ID: <20091127162321.GF29512@sirena.org.uk>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com> <20091127145426.GA6135@oksana.dev.rtsoft.ru> <6ed0b2680911270747k4bd5610eg1e0ef83c41622bba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752256AbZK0QXY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ed0b2680911270747k4bd5610eg1e0ef83c41622bba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: avorontsov@ru.mvista.com, linux-kernel@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 27, 2009 at 05:47:40PM +0200, Grazvydas Ignotas wrote:
> On Fri, Nov 27, 2009 at 4:54 PM, Anton Vorontsov

> >> + ? ? /* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
> >> + ? ? ?* we don't want and can't tolerate. ?Although it might be
> >> + ? ? ?* friendlier not to borrow this thread context...
> >> + ? ? ?*/
> >> + ? ? local_irq_enable();
> >> +#endif

> > Can you explain why the driver can't tolerate disabled irqs?
> > Calling schedule_delayed_work() from an irq context should be OK.

> Ah, this is leftover from TI code this driver is based on, which used
> to do more things directly in interrupt handler. So I guess it can be
> removed, updated patch attached.

Actually, the genirq infrastructure in 2.6.32 has been improved to allow
I2C based interrupt controllers properly so even those twl4030 drivers
that do I/O in interrupt callbacks should now be able to run without
these workarounds once the core has been updated.
