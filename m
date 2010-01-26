From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 0/4] twl4030 threaded_irq support
Date: Tue, 26 Jan 2010 04:18:42 -0800
Message-ID: <201001260418.43107.david-b@pacbell.net>
References: <20091212183410.GF3092@sirena.org.uk> <201001252306.55625.david-b@pacbell.net> <20100126110247.GB13062@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753406Ab0AZMSz@vger.kernel.org>
In-Reply-To: <20100126110247.GB13062@nokia.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@openedhand.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 January 2010, Felipe Balbi wrote:
> >But nothing in drivers/mfd ... the entry to the whole stack?
> >...
> 
> correct, that's still missing. I tried to play with it for a while, but 
> had to give up due to other musb tasks. So if someone wants to step up 
> and code that part, I'd be glad

I'm quite sure I sent a patch doing that ... sometime early last
summer, when the threaded IRQ stuff was being thrashed out!  (To
show what it'd look like, and see what problems remained.)  That
interface hasn't changed much since then, except for addition of
a stuff like ONESHOT support, set_irq_nested_thread(), and the
bus_lock stuff.  It's surely in LKML archives.  :)

My point here was more like:  these patches shouldn't merge without
that top-level change.  Just switch the whole current structure
(one thread, nesting) over to the now-standard interfaces at the
same time, not incrementally.  Later, the bus_lock stuff can switch
over too (for cleaner mask/unmask).

That's clearly material for 2.6.34 though ...

- Dave
