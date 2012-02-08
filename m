From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 21:47:25 -0800
Message-ID: <20120208054724.GC1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <87zkcugus0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16667 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab2BHFra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 00:47:30 -0500
Content-Disposition: inline
In-Reply-To: <87zkcugus0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Kevin Hilman <khilman@ti.com> [120207 13:38]:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> [...]
> 
> > Another problem oopses the kernel at boot in the voltage domain code,
> > which I suspect this has never been boot tested on OMAP34xx CPUs:
> >
> > omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
...
> > [<c03db824>] (omap_vp_init+0x0/0x15c) from [<c03db448>] (omap_voltage_late_init+
> > 0xc4/0xfc)
...
> 
> FWIW, this problem has been fixed for some time, and in my
> for_3.3/cleanup/pm branch (and included in Tony's cleanup branch) which
> was supposed to be merged for v3.3.

Yes sorry I guess I did not realize it was a fix. This was one of
the three branches that were left out of the last merge window
because it was getting too.

I assume you're talking about commit af9a2ed9667b49e7e125eac526d8f655183ce53e?

Regards,

Tony
