From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 16:13:19 +0000
Message-ID: <20100126161319.GX15759@rakim.wolfsonmicro.main>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <201001260535.21689.david-b@pacbell.net>
 <20100126142102.GU15759@rakim.wolfsonmicro.main>
 <201001260744.46780.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754650Ab0AZQNX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201001260744.46780.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 26, 2010 at 07:44:46AM -0800, David Brownell wrote:
> On Tuesday 26 January 2010, Mark Brown wrote:

> > In the sort of design I'm talking about there is generally a system
> > power rail which is generated from the various power sources available
> > to the system, which might include a combination of batteries, USB and
> > wall adaptors.

> Just as an example:  drivers/mfd/tps6510.c supports exactly
> that trio of power sources.

Yup, it's a fairly standard feature set for all in one PMICs, WM835x and
WM831x are also examples of this.

>                              More than one system rail though,
> which (as you know) is pretty common -- core != I/O.

Yes, in this context the system rail is the supply input to the
regulators rather than the regulated voltages that are (mostly)
used directly by the chips.

> Bus powered devices can come up on that 100mA, running
> enough to enumerate ... and request more power, if they
> need it.

> Not all Linux systems can boot with that little power!

Some can even brown themselves out going full pelt with the full 500mA
supply if there's no battery to supplement it :/
