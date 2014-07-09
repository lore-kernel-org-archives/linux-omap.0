From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V4 2/2] arm: dts: dra7: add crossbar device binding
Date: Wed, 9 Jul 2014 08:44:17 -0700
Message-ID: <20140709154417.GC28884@atomide.com>
References: <1403767532-19290-1-git-send-email-r.sricharan@ti.com>
 <1403767532-19290-3-git-send-email-r.sricharan@ti.com>
 <20140626074417.GF28884@atomide.com>
 <53ABDA9A.8000108@ti.com>
 <20140626102650.GH28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140626102650.GH28884@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, joe@perches.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140626 03:28]:
> * Sricharan R <r.sricharan@ti.com> [140626 01:36]:
> > Hi Tony,
> > 
> > On Thursday 26 June 2014 01:14 PM, Tony Lindgren wrote:
> > > * Sricharan R <r.sricharan@ti.com> [140626 00:29]:
> > >> From: R Sricharan <r.sricharan@ti.com>
> > >>
> > >> There is a IRQ crossbar device in the soc, which
> > >> maps the irq requests from the peripherals to the
> > >> mpu interrupt controller's inputs. The Peripheral irq
> > >> requests are connected to only one crossbar
> > >> input and the output of the crossbar is connected to only one
> > >> controller's input line. The crossbar device is used to map
> > >> a peripheral input to a free mpu's interrupt controller line.
> > >>
> > >> Here, adding a new crossbar device node and replacing all the peripheral
> > >> interrupt numbers with its fixed crossbar input lines.
> > > 
> > > I think these two patches need to be a single patch to avoid
> > > breaking booting for git bisect inbetween these patches?
> >   This does not cause booting issues. irq_desc gets allocated linearly,
> >    but that does not create boot issues.
> 
> OK

These are now applied on top of Jason's immutable irqchip branch
and merged and pushed out into omap-for-v3.17/dt. Can you guys
please test?

Regards,

Tony
