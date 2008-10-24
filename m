From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [patch 2.6.27-omap-git 0/4] start phasing out legacy GPIO calls
Date: Fri, 24 Oct 2008 09:51:03 +0300
Message-ID: <20081024095103.45791f94.jarkko.nikula@nokia.com>
References: <200810222350.54467.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60555 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYJXGvw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 02:51:52 -0400
In-Reply-To: <200810222350.54467.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Wed, 22 Oct 2008 23:50:54 -0700
"ext David Brownell" <david-b@pacbell.net> wrote:

> Following this are four patches matching $SUBJECT:
> 
>  - remove omap_set_gpio_dataout() and omap_get_gpio_datain()
> 	... same call syntax, different name, minor code shrink
>  - use gpio_direction_input()
> 	... minor call syntax change, otherwise not interesting
>  - use gpio_direction_output(), remove omap_set_gpio_direction()
> 	... different call syntax and initialization model
>  - use gpio_to_irq()
> 	... at least, outside of static initializers
> 
> The third patch might conceivably make trouble; see the patch
> comments.  Ditto the fourth, but IMO that's less likely.
> 
> I did test builds for OMAP1, OMAP2420, OMAP2430, and OMAP3430,
> and tried to make sure all the files affected by this patch
> got rebuilt.  The build breakage was mostly related to McBSP
> and iomem pointers; nothing affected by these patches.
> 
> Two remaining OMAP GPIO calls can be removed a bit later:
> 
> 	int omap_request_gpio(int gpio);
> 	void omap_free_gpio(int gpio);
> 
> Once that's done, I think it'll be time to move the GPIO
> code into mach-omap1/mach-omap2 ... the OMAP2/OMAP3 stuff
> in particular should become a LOT simpler.
> 
Hi David

Did you know what? I was doing something like similar conversion patches
just few days ago but didn't find yet time to finalize them and fix
arch/arm/plat-omap/gpio.c for omap_[request | free]_gpio :-)

My set was basically doing all gpiolib conversions in one patch and the
set was grouped so that one patch for all OMAP1 boards (all of them are
in mainline), separate patches for couple OMAP2 boards and some random
patches for different drivers.

I can add omap_request_gpio/omap_free_gpio conversion patch on top of
yours but probably that will go somewhere next week. Useful conversion
due label argument in gpio_request :-)


Jarkko
