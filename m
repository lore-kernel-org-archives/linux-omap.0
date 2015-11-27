From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Fri, 27 Nov 2015 22:06:20 +0100
Message-ID: <11537945.4HX4Y84tjV@wuerfel>
References: <20150713131902.GH26485@atomide.com> <20151127132722.GA30871@n2100.arm.linux.org.uk> <20151127195148.GB30871@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151127195148.GB30871@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

On Friday 27 November 2015 19:51:48 Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2015 at 01:27:23PM +0000, Russell King - ARM Linux wrote:
> > It is possible to redirect any program to open any other file.  You can
> > do it via a LD preload, and intercepting the open(), and possibly the
> > read() calls if you want to do something more fancy.  The down-side is
> > that you have to arrange for the preloaded object to be used by the
> > linker, and the additional overhead it places on the intercepted
> > functions.
> 
> Another idea if people don't like the preload idea.
> 
> We could create a zero-sized /proc/atags, and then use a bind mount in
> userspace to bind some other file containing the required information
> on top.  That could even be the atag blob from /sys/firmware/whatever.
> The N700 (or whatever platform needs it) could be responsible for
> creating the zero-sized /proc/atags so that we don't have it everywhere.

I don't mind creating the /proc/atags compatibility hack from the kernel
for a DT based N700 kernel, as long as we limit it as much as we can
to the machines that need it. Leaving a board file for the N700 in place
that contains the procfs code (and not much more) seems reasonable
here, as we are talking about a board specific hack and the whole point
appears to be running unmodified user space.

Regarding how to get the data into the kernel in the first place, my
preferred choice would still be to have an intermediate bootloader
such as pxa-impedance-matcher, but I won't complain if others are
happy enough about putting it into the ATAGS compat code we already
have, as long as it's limited to the boards we know need it.

	Arnd
