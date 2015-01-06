From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 21:44:43 +0200
Message-ID: <20150106194443.GH30544@fuloong-minipc.musicnaut.iki.fi>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
 <20150106165903.GF4025@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:54743 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932816AbbAFTow (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 14:44:52 -0500
Content-Disposition: inline
In-Reply-To: <20150106165903.GF4025@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

Hi,

On Tue, Jan 06, 2015 at 08:59:03AM -0800, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> > On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> > > Revert "ARM: dts: Disable smc91x on n900 until bootloader
> > > dependency is removed". We've now fixed the issues that
> > > caused problems with uninitialized hardware depending on
> > > the bootloader version. Mostly things got fixed with
> > > the following commits:
> > > 
> > > 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
> > > 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
> > > 
> > > Note that this only affects the early development boards
> > > with Ethernet that we still have in a few automated boot
> > > test systems.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Normally, the early development boards should have separate dts file
> > (then include common parts), no?
> 
> In this case it won't matter. The GPMC hardware is there, the probe
> just fails if no smsc91x is found.
>  
> > Could you at least add a note to the dts file what is it? Because I
> > always thought it is a bug.
> 
> Sure, updated patch below. Can somebody please test boot it on
> a production n900 too to make sure it no longer causes issues?

Seems to work fine with normal n900.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I also tested with a development board, eth0 seemed to appear,
but couldn't configure the MAC address with busybox ifconfig.
How should it be done, I guess the interface does not have any
MAC by default?

A.
