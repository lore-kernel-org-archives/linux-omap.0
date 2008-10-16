From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-omap-git+ 0/5] twl4030 GPIO updates
Date: Thu, 16 Oct 2008 14:26:36 -0700
Message-ID: <20081016212636.GW15820@atomide.com>
References: <200810131259.50460.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61024 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775AbYJPV0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 17:26:40 -0400
Content-Disposition: inline
In-Reply-To: <200810131259.50460.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081013 13:22]:
> Following this are several patches making the twl4030 GPIO code
> fit better into the GPIO framework, updating its only current
> user (hsmmc glue) and adding one more (Beagle).
> 
>  - gpio_request()/gpio_free() hook, now in MM for 2.6.28-rc merge
>  - use that mechanism for twl4040 GPIOs
>  - remove most twl-specific calls from mach-omap2/hsmmc.c glue
>  - support LEDA and LEDB as output-only GPIOs
>  - support those two LED signals on Beagle (one is a real LED!)
> 
> This goes on top of the preceding patches to update IRQ handling
> for the twl core.
> 
> Capsule summary:  the only remaining twl40-specific GPIO calls
> are to enable hardware debouncing, with potential upstream generic
> support soon; and disabled linkages of the MMC power supplies to
> those card detect lines (best suited IMO to platform_data, once
> it's tested).
> 
> Which makes twl4030-gpio nearly ready to go upstream.

Pushing all 6 today.

Tony
