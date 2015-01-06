From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 21:42:23 +0100
Message-ID: <20150106204223.GA13902@amd>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
 <20150106165903.GF4025@atomide.com>
 <20150106194443.GH30544@fuloong-minipc.musicnaut.iki.fi>
 <20150106195454.GW4081@atomide.com>
 <20150106201758.GX4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34978 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbAFUmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 15:42:25 -0500
Content-Disposition: inline
In-Reply-To: <20150106201758.GX4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Tue 2015-01-06 12:17:59, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150106 12:01]:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [150106 11:47]:
> > > Hi,
> > > 
> > > On Tue, Jan 06, 2015 at 08:59:03AM -0800, Tony Lindgren wrote:
> > > > * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> > > > > On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> > > > > > Revert "ARM: dts: Disable smc91x on n900 until bootloader
> > > > > > dependency is removed". We've now fixed the issues that
> > > > > > caused problems with uninitialized hardware depending on
> > > > > > the bootloader version. Mostly things got fixed with
> > > > > > the following commits:
> > > > > > 
> > > > > > 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
> > > > > > 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
> > > > > > 
> > > > > > Note that this only affects the early development boards
> > > > > > with Ethernet that we still have in a few automated boot
> > > > > > test systems.
> > > > > > 
> > > > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > > 
> > > > > Normally, the early development boards should have separate dts file
> > > > > (then include common parts), no?
> > > > 
> > > > In this case it won't matter. The GPMC hardware is there, the probe
> > > > just fails if no smsc91x is found.
> > > >  
> > > > > Could you at least add a note to the dts file what is it? Because I
> > > > > always thought it is a bug.
> > > > 
> > > > Sure, updated patch below. Can somebody please test boot it on
> > > > a production n900 too to make sure it no longer causes issues?
> > > 
> > > Seems to work fine with normal n900.
> > > 
> > > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > 
> > OK good to hear, thanks for testing.
> >  
> > > I also tested with a development board, eth0 seemed to appear,
> > > but couldn't configure the MAC address with busybox ifconfig.
> > > How should it be done, I guess the interface does not have any
> > > MAC by default?
> > 
> > You need to write the eeprom with ethtool from Linux, something
> > like this:
> > 
> > Run u-boot/tools/gen_eth_addr to generate a random local mac,
> > then swap the bytes for it for big endian. Enter them into a
> > file with hexedit in big endian order. Then just do:
> > 
> > # cat mac | ethtool -E eth0 offset 0x40 length 6
> > 
> > Then ethtool -e eth0 should show you the configuration.
> 
> Oh and I have some u-boot patches that I'll post that allow
> booting n900 with bootz and to use smsc91x tftp booting. I'll
> try to post those shortly..

Nice :-). If you have u-boot working, could you try to do generic
board conversion? We are a tiny bit past a deadline on that one.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
