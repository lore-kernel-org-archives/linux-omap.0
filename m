From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c
 to be OMAP2+ only for now
Date: Mon, 8 Oct 2012 15:13:33 -0700
Message-ID: <20121008221333.GZ13011@atomide.com>
References: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42397 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752187Ab2JHWNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 18:13:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

* Paul Walmsley <paul@pwsan.com> [121007 18:48]:
> 
> Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> debug_card_init() function") results in the following new sparse[1]
> warning:
> 
> arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> 
> Normally this could be fixed by including the appropriate header file
> in plat-omap/debug-devices.c, but the header file now exists only in
> mach-omap2/, so this would require a "sideways include" and is thus
> impractical.  It turns out that only code in mach-omap2/ currently
> uses the debug-devices.c and debug-leds.c files, so move them there.
> In the long term, these devices should be created by DT, and the code
> should be moved into drivers/ somewhere.

Hmm are you sure that omap1 is not using debug-leds.c?
At least the initcall seems like it should run on omap1
if enabled.

The sideways include here is OK, it does not get exposed to
the drivers, it seems that plat-omap is still the right location
for at least debug-leds.c code.

> rename from arch/arm/plat-omap/debug-leds.c
> rename to arch/arm/mach-omap2/debug-leds.c
> index ea29bbe..c12350b 100644
> --- a/arch/arm/plat-omap/debug-leds.c
> +++ b/arch/arm/mach-omap2/debug-leds.c
> @@ -146,11 +146,8 @@ static struct platform_driver led_driver = {
>  
>  static int __init fpga_init(void)
>  {
> -	if (machine_is_omap_h4()
> -			|| machine_is_omap_h3()
> -			|| machine_is_omap_h2()
> -			|| machine_is_omap_perseus2()
> -			)
> +	if (machine_is_omap_h4() || machine_is_omap_h3() ||
> +	    machine_is_omap_h2() || machine_is_omap_perseus2())
>  		return platform_driver_register(&led_driver);
>  	return 0;
>  }

This looks like it should work fine for the boards using
the debug leds on omap1 too.

Regards,

Tony
