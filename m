From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sun, 8 Dec 2013 19:59:05 +0200
Message-ID: <20131208175905.GO30823@blackmetal.musicnaut.iki.fi>
References: <20131206213613.GA19648@earth.universe>
 <20131206222725.GM26766@atomide.com>
 <20131208141342.GN30823@blackmetal.musicnaut.iki.fi>
 <20131208164028.GA5830@atomide.com>
 <20131208171006.GA7178@earth.universe>
 <20131208174350.GC5830@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49676 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab3LHR7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Dec 2013 12:59:12 -0500
Content-Disposition: inline
In-Reply-To: <20131208174350.GC5830@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Sun, Dec 08, 2013 at 09:43:51AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [131208 09:11]:
> > On Sun, Dec 08, 2013 at 08:40:29AM -0800, Tony Lindgren wrote:
> > > * Aaro Koskinen <aaro.koskinen@iki.fi> [131208 06:15]:
> > > > Hi,
> > > > 
> > > > On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren wrote:
> > > > > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > > > > Nokia N900 DT boot breaks for me using 3.13-rc3. You can see the
> > > > > > relevant kernel output below. Disabling the AES module in the
> > > > > > omap3-n900.dts with status = "disabled" fixed the boot for me.
> > > > > 
> > > > > OK thanks for letting me know. How about the following patch to
> > > > > fix it?
> > > > > 
> > > > > Aaro, does this work for you on n9(50)? I'd assume n9(50) needs a
> > > > > similar patch too.
> > > > 
> > > > Yes, also N9/N950 crashes and your patch fixes that.
> > > 
> > > OK thanks, there's the updated version of this patch if you guys
> > > care to ack, I'd like to commit it today.
> > 
> > Where is the updated version? I couldn't find it in this thread.
> 
> It's Message-ID: <20131207003824.GO26766@atomide.com> in this thread,
> the version that disables aes, sham and timer12 like we currently do
> in the hwmod code for legacy booting:
> 
> http://www.spinics.net/lists/linux-omap/msg101045.html

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
