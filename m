From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/8] ARM: OMAP3: Initialize regulators for Beagle and
	Overo
Date: Thu, 28 May 2009 17:20:27 +0100
Message-ID: <20090528162027.GG20736@n2100.arm.linux.org.uk>
References: <20090525174517.19679.18805.stgit@localhost> <20090525174938.19679.51804.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59065 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbZE1QUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 12:20:50 -0400
Content-Disposition: inline
In-Reply-To: <20090525174938.19679.51804.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

On Mon, May 25, 2009 at 10:49:38AM -0700, Tony Lindgren wrote:
> @@ -130,6 +148,10 @@ static int beagle_twl_gpio_setup(struct device *dev,
>  	mmc[0].gpio_cd = gpio + 0;
>  	twl4030_mmc_init(mmc);
>  
> +	/* link regulators to MMC adapters */
> +	beagle_vmmc1_supply.dev = mmc[0].dev;
> +	beagle_vsim_supply.dev = mmc[0].dev;
> +

I really hate it when I see this kind of initialization after registration.
It feels totally wrong and fragile.

At one point, I had clkdev matching using struct device pointer as well,
but it was realised that was far too limiting - you couldn't declare
clock entries without first having all devices setup, and then you run
into problems with ordering.

It looks like the regulator stuff is suffering this same problem - it
wants to match by struct device pointer.  That's fine if all your
struct device's are statically allocated, but as soon as you start
having dynamic ones, it gets _much_ harder to cope with.
