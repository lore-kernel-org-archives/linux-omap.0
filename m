From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Thu, 3 Dec 2015 07:39:28 -0800
Message-ID: <20151203153927.GJ23396@atomide.com>
References: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
 <20151019145039.GA21839@atomide.com>
 <5625DD9F.6010106@ti.com>
 <876122c7vd.fsf@linutronix.de>
 <20151020145255.GB3078@atomide.com>
 <56602769.9050708@ti.com>
 <20151203150222.GH23396@atomide.com>
 <56605EBD.9050001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56605EBD.9050001@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [151203 07:25]:
> On Thursday 03 December 2015 08:32 PM, Tony Lindgren wrote:
> > 
> > Yes we should naturally fix up the kernel locking.
> 
> Alright. Thanks!
> 
> > 
> > Please also add something like "enable debug for more information"
> > to the warning. And then print out the current and previous interrupt
> 
> So I am unconvinced (based on the debug above) that the previous
> interrupt information is actually giving any more useful information
> than what can be gleaned from observing /proc/interrupts. It seems
> previous interrupt noted can be any interrupt you would expect to occur
> during the test case anyway.

OK and the fact that I've fixed up 4-5 of these and all of them were
really caused by missing flush of posted write makes me still suspicious :)

> > if DEBUG is enabled. And in the comments mention that often the spurious
> > interrupts has been fixed by adding a flush of the posted write to the
> > previous interrupt handler in the device driver.
> 
> I can add the comment, no problem.

OK thanks. We can add more debug once you figure out what is the root
cause.

> > Also, do you have a reproducable test case with mainline kernel I
> > could add to my collection of shell scripts?
> 
> The way I reproduce this is to run the serial port at 3Mbaud in internal
> loopback mode with DMA enabled. The test program I use[1] compares the
> data sent and received byte-for-byte. With current mainline, that can
> mismatch pretty soon. The test will likely end before you see any
> spurious irq. There are some patches John Ogness is working on
> (currently included in TI's v4.1 kernel) which helps sustain the test
> for long and then actually expose the spurious irq issue.

OK. One thing you have to consider here though is that the EDMA driver
may still wrongly consider several interconnect targets as a single entity.
This can lead to issues where flushing a posted write really only flushes
one of the interconnect targets and that may not be the right one.

Peter has been patching the EDMA driver to solve this problem, but I don't
know if all of them are merged yet, I've added him to Cc.

My bets are on a lack of flush of posted write in the EDMA driver somewhere
and I suggest you investigate that a bit more considering the multiple
interconnect targets :)

Regards,

Tony

> [1] https://git.breakpoint.cc/cgit/bigeasy/serialcheck.git
