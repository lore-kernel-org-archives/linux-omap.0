From: Johan Hovold <johan@kernel.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Fri, 12 Jan 2018 15:46:47 +0100
Message-ID: <20180112144647.GA5992@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <20180109184347.28ba0a6e@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180109184347.28ba0a6e@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 09, 2018 at 06:43:47PM +0100, Andreas Kemnade wrote:
> On Fri, 22 Dec 2017 13:44:27 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> [...]
> > I'd suggest reiterating the problem you're trying to solve and
> > enumerating the previously discussed potential solutions in order to
> > find a proper abstraction level for this (before getting lost in
> > implementation details).
> > 
> The main point here is in short words: Having a device powered on or off
> when the uart it is attached to, is used or not used anymore,
> so the already available userspace applications do not need to be changed.

So we'd end up with something in-between a kernel driver and a
user-space solution. What about devices that need to be (partially)
powered also when the port isn't open? A pure user-space solution would
be able to handle all variants.

> I digged out a bit around:
> alternative aproaches were:
> adding hooks to the uart/tty layer:
> https://marc.info/?l=linux-kernel&m=143333222014616&w=2
> https://marc.info/?l=devicetree&m=143130955414580&w=2

Thanks for the pointers, I remember those threads...

> I do not find it right now in my archive:
> adding a virtual gpio for dtr to the omap_serial driver.
> The driver behind the virtual io would then handle pm. One reason it was
> rejected was that the devicetree should only contain real hardware and
> not virtual stuff.

Oh, yeah, I think something like that made it in briefly before getting
reverted again.

I'll respond to Nikolaus mail as well.

Johan
