From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Sun, 29 Nov 2015 19:09:17 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr>
References: <20150713131902.GH26485@atomide.com> <20151127132722.GA30871@n2100.arm.linux.org.uk> <20151127195148.GB30871@n2100.arm.linux.org.uk> <11537945.4HX4Y84tjV@wuerfel> <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr> <20151128123328.GC30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511281232440.22569@knanqh.ubzr> <20151129180939.GE30871@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151129180939.GE30871@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

On Sun, 29 Nov 2015, Russell King - ARM Linux wrote:

> On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> > Good. And Arnd likes the idea too. So we might be converging at last 
> > which is a good thing.
> 
> I disagree with the idea that there is convergence.  There might be
> convergence towards an idea, but... Here's a mail extract, from July
> 7th, from earlier in this very thread:
> 
> Pali:
> > Me:
> > > Are the ATAGs at a fixed address on the N900?
> > 
> > Yes, in board-rx51.c is:
> > 
> > .atag_offset    = 0x100
> > 
> > and Nokia Bootloader (proprietary) store them to that address.
> > 
> > > Can that be handled in
> > > some kind of legacy file for the N900 which calls save_atags() on it, so
> > > we don't end up introducing yet more stuff that we have to maintain into
> > > the distant future?  If not, what about copying a known working atag
> > > structure into a legacy file for the N900?
> > >
> > 
> > I already asked question if it is possible to read ATAGs from DT booted
> > kernel. And somebody (do not remember who) wrote to ML, that it is not
> > possible and it can be done in that uncompress code.

Who is that somebody? If ever it happened to be me then objection is 
withdrawn. Otherwise that somebody should come forth and speak up again.

> So you're converging on an idea that has already been rejected.  That's
> not a good thing, IMHO.

All the alternatives are worse and being rejected as well.

In that case we should settle on the idea that satisfies the most 
people.


Nicolas
