From: Johan Hovold <johan@kernel.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Mon, 19 Mar 2018 15:02:52 +0100
Message-ID: <20180319140252.GM18359@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <20180109184347.28ba0a6e@aktux>
 <20180112144647.GA5992@localhost>
 <20180112194022.7da1e726@kemnade.info>
 <20180118064736.GH3286@localhost>
 <20180308071459.310d0ba2@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308071459.310d0ba2@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 08, 2018 at 07:16:44AM +0100, Andreas Kemnade wrote:
> Hi,
> 
> On Thu, 18 Jan 2018 17:47:36 +1100
> Johan Hovold <johan@kernel.org> wrote:
> 
> [...]
> > > 
> > > So to avoid having hardware information spread all over the table at least
> > > these information would need to be in devicetree. But that also all feels
> > > like a hack and hard to maintain.  
> > 
> > Having the device described in the device tree is certainly desirable,
> > not least for chip identification. And with a GPS framework in the
> > kernel with a well-defined interface, implementing power management
> > would be straight forward.
> > 
> Hmm, devicetree without in-kernel drivers, do we have anything like that
> somewhere? I thought that was a big no-go. But maybe I am wrong.

No, that's probably not a good idea, even if it may be possible (what
about ACPI then, for example?).

> > I'm just not convinced that the proposed tty interface is the right
> > interface for this. User space would still rely on gpsd for the GPS
> > protocols, and would also ultimately be managing power by killing gpsd
> > or whatever daemon that would otherwise be holding the port open.
> > 
> > Something like the generic power sequences that has been discussed
> > elsewhere might be a better fit for this if all you want to do is power
> > on and off on port open and close (and on suspend/resume). There really
> > isn't anything GPS-specific in the current proposal (besides the
> > suggested tty-device name).
> 
> So a bit like that mmc-powerseq stuff we already have?

Yeah, the generic power sequence patches were inspired by that and
intended to generalise it (e.g. to be used by the USB bus to power on
devices so that they could be enumerated). There were some issues with
that work though (which also precludes it from being used for something
like this), and it still wouldn't be sufficient to deal with the gps
device in question (which needs to monitor the incoming data).

> > But sure, that wouldn't be sufficient to deal with the
> > unknown-power-state problem with the device in question.
>
> Maybe there could be a kind of active flag set by the tty if
> there is traffic, so that active flag could be used in these
> power sequence stuff? But then again the tty layer has to be extended
> which would probably also cause a lot of ruffled feathers.

Yeah, I think this is a dead end. We need some kind of gps framework
with drivers that can implement the device specific bits.

I may have some time to look at little closer at it this week.

Johan
