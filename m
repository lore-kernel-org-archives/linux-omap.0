From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 14:04:30 -0800
Message-ID: <20150106220429.GA4081@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
 <20150106165903.GF4025@atomide.com>
 <20150106194443.GH30544@fuloong-minipc.musicnaut.iki.fi>
 <20150106195454.GW4081@atomide.com>
 <20150106215634.GB6071@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47548 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbbAFWIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 17:08:20 -0500
Content-Disposition: inline
In-Reply-To: <20150106215634.GB6071@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>

* Aaro Koskinen <aaro.koskinen@iki.fi> [150106 13:59]:
> Hi,
> 
> On Tue, Jan 06, 2015 at 11:54:55AM -0800, Tony Lindgren wrote:
> > Run u-boot/tools/gen_eth_addr to generate a random local mac,
> > then swap the bytes for it for big endian. Enter them into a
> > file with hexedit in big endian order. Then just do:
> > 
> > # cat mac | ethtool -E eth0 offset 0x40 length 6
> > 
> > Then ethtool -e eth0 should show you the configuration.
> 
> Does any other eeprom data need to be set? It seems to be all 0xff.
> I generated a mac from /dev/random and it shows up fine in those offsets
> and with ifconfig, but I still can't get a link up:
> 
> ifconfig: SIOCSIFFLAGS: Cannot assign requested address

Chances are you did not swap the mac address bits around
and it's trying to use a reserved mac address now? The
mac needs to be the other way around..

Regards,

Tony
