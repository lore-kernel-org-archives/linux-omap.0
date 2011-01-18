From: Tony Lindgren <tony@atomide.com>
Subject: Re: State of LDP3430 platform
Date: Mon, 17 Jan 2011 17:25:42 -0800
Message-ID: <20110118012541.GN4957@atomide.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20101206181913.GH8345@atomide.com>
 <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
 <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
 <20110115233744.GA18159@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:32033 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1ARBZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 20:25:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

Hi,

* Paul Walmsley <paul@pwsan.com> [110115 20:31]:
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
> @@ -244,6 +244,13 @@ static void __init omap_timer_init(void)
>  
>  	omap_init_mpu_timer(rate);
>  	omap_init_clocksource(rate);
> +	/*
> +	 * XXX Since this file seems to deal mostly with the MPU timer,
> +	 * this doesn't seem like the correct place for the sync timer
> +	 * clocksource init.
> +	 */
> +	if (!cpu_is_omap7xx() && !cpu_is_omap15xx())
> +		omap_init_clocksource_32k();
>  }
>  
>  struct sys_timer omap_timer = {

To me it looks like the omap_init_clocksource_32k() call should be
in arch/arm/mach-omap1/timer32k.c instead.

Regards,

Tony
