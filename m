From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v2] ARM: omap2: twl-common update
Date: Wed, 27 Mar 2013 11:38:23 -0700
Message-ID: <20130327183822.GC10155@atomide.com>
References: <5146E895.50709@ti.com>
 <20130319182336.GE16413@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50739 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab3C0Si0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 14:38:26 -0400
Content-Disposition: inline
In-Reply-To: <20130319182336.GE16413@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@list.infradead.org

* Tony Lindgren <tony@atomide.com> [130319 11:28]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [130318 03:16]:
> > Hi Tony,
> > 
> > I have rebased the branch on 3.9-rc3 tag.
> > Is it still possible to send this for 3.9?
> 
> Let's see if we can still get this in. It's getting a bit late
> for v3.9, so I'll apply this into a separate branch from other fixes
> omap-for-v3.9-rc3/fix-twl-reboot branch just in case it's considered
> too intrusive for the -rc.

Sorry just noticed that this one adds:

Section mismatch in reference from the variable omap3_power_pdata to the (unknown reference) .init.data:(unknown)
The variable omap3_power_pdata references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Is it safe to make it __initdata, or should also other power_pdata
have their __initdata flags removed if used by the drivers?

Regards,

Tony
