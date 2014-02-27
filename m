From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Help running latest linux-omap kernel on Nokia N810
Date: Thu, 27 Feb 2014 21:38:02 +0200
Message-ID: <20140227193802.GC671@drone.musicnaut.iki.fi>
References: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk>
 <20140226185331.GA17632@earth.universe>
 <20140226212927.GB671@drone.musicnaut.iki.fi>
 <530EE6F2.7040903@ti.com>
 <277ac9055a67992eb1c03e89788afebf@doppler.thel33t.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:57291 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaB0TjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Feb 2014 14:39:12 -0500
Content-Disposition: inline
In-Reply-To: <277ac9055a67992eb1c03e89788afebf@doppler.thel33t.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sre@ring0.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Thu, Feb 27, 2014 at 08:19:06AM +0000, Leigh Brown wrote:
> Did that driver work on the N810 at that point?  If I look at the kernel
> tree at that point in time would all the components be there?  It would
> make it easier if I had a starting point as I don't have any documentation
> so reading the old source code is the only way I can figure out how things
> work(ed).

OpenWRT has patches to make the old blizzard driver work:

http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/omap24xx/patches-3.3;h=c0cece34bf0a5f37496015c8e76c7eae636efe06;hb=HEAD

See 310-n810-lcd.patch, and also you will need at least
312-no-hwmod-reset.patch, otherwise the HW won't respond at all.

There is no known kernel tree with "new" (now deleted) panel-n8x0 that
would work on N8x0.

So probably the easiest route would be to take the old blizzard driver,
forward port it to current kernel (the old omapfb is still supported)
together with OpenWRT patches. This would probably get a working display
with minor effort. Then start rewriting that code for the new framework
and DT etc.

A.
