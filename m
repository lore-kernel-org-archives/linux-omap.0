From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot
Date: Sun, 8 Dec 2013 08:40:29 -0800
Message-ID: <20131208164028.GA5830@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <20131206222725.GM26766@atomide.com>
 <20131208141342.GN30823@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61243 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754432Ab3LHQkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Dec 2013 11:40:31 -0500
Content-Disposition: inline
In-Reply-To: <20131208141342.GN30823@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [131208 06:15]:
> Hi,
> 
> On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > Nokia N900 DT boot breaks for me using 3.13-rc3. You can see the
> > > relevant kernel output below. Disabling the AES module in the
> > > omap3-n900.dts with status = "disabled" fixed the boot for me.
> > 
> > OK thanks for letting me know. How about the following patch to
> > fix it?
> > 
> > Aaro, does this work for you on n9(50)? I'd assume n9(50) needs a
> > similar patch too.
> 
> Yes, also N9/N950 crashes and your patch fixes that.

OK thanks, there's the updated version of this patch if you guys
care to ack, I'd like to commit it today.

Regards,

Tony
