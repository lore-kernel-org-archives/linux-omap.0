From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.29-rc2-omap1-git 0/7] regulator and MMC updates...
Date: Wed, 4 Feb 2009 11:27:26 -0800
Message-ID: <20090204192725.GN7215@atomide.com>
References: <200901200244.36238.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55078 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZBDT13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 14:27:29 -0500
Content-Disposition: inline
In-Reply-To: <200901200244.36238.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090120 03:01]:
> Several patches here:
> 
>  - New interface in regulator core ... in the regulator queue
>    (presumably for 2.6.30 merge)
> 
>  - twl4030 regulator updates to use that interface
> 
> Given that second part, I think the twl4030 regulator code can
> be submitted upstream.
> 
>  - Init updates for OMAP 3430 SDP ... regulators, MMC switches,
>    and a bit more.
> 
>  - Minor Overo init update:  set up VMMC1
> 
>  - HSMMC init update:  pass device back so regulator setup can
>    use it.  (Not as invasive as a cleaner fix would be...)
> 
>  - Beagle init update:  hook up the regulators used by MMC-1
>    (relies on that init update)
> 
>  - SDP init update:  hook up regulators used by MMC-1 and MMC-2
>    (also relies on that init update)
> 
> These go on top of patches I sent previously, to work around
> a lockdep issue in the hsmmc driver (that might go to mainline
> as a bugfix, assuming that driver goes to mainline for 2.6.29)
> and correct the mach-omap2/mmc-twl4030.c power switching.
> 
> Once that's merged, it'll be ready to start using the regulator
> calls to switch power for MMC on at least those platforms.

Pushing this series to l-o tree. Again, let me know what to add to the
upstream queues (and when).

Regards,

Tony
