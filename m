From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Sat, 28 Nov 2015 12:33:28 +0000
Message-ID: <20151128123328.GC30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com>
 <20151127132722.GA30871@n2100.arm.linux.org.uk>
 <20151127195148.GB30871@n2100.arm.linux.org.uk>
 <11537945.4HX4Y84tjV@wuerfel>
 <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 27, 2015 at 06:28:50PM -0500, Nicolas Pitre wrote:
> On Fri, 27 Nov 2015, Arnd Bergmann wrote:
> 
> > I don't mind creating the /proc/atags compatibility hack from the kernel
> > for a DT based N700 kernel, as long as we limit it as much as we can
> > to the machines that need it. Leaving a board file for the N700 in place
> > that contains the procfs code (and not much more) seems reasonable
> > here, as we are talking about a board specific hack and the whole point
> > appears to be running unmodified user space.
> > 
> > Regarding how to get the data into the kernel in the first place, my
> > preferred choice would still be to have an intermediate bootloader
> > such as pxa-impedance-matcher, but I won't complain if others are
> > happy enough about putting it into the ATAGS compat code we already
> > have, as long as it's limited to the boards we know need it.
> 
> Assuming you have a N700 board file for special procfs code, then why 
> not getting at the atags in memory where the bootloader has put them 
> directly from that same board file? This way it'll really be limited to 
> the board we know needs it and the special exception will be contained 
> to that one file.  Amongst the machine specific hooks, there is one that 
> gets invoked early during boot before those atags are overwritten.

I've already suggested that.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
