From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v9] board-omap3-beagle: add DSS2 support
Date: Thu, 6 May 2010 11:53:19 +0200
Message-ID: <4C3B4B84-D66F-457A-8002-9A77B74DC13D@dominion.thruhere.net>
References: <1271924622-21043-1-git-send-email-koen@dominion.thruhere.net> <0BA15D46-D494-4402-9EC8-574AD5D7BAE8@dominion.thruhere.net> <l2l94a0d4531005020858l1a79e4f3hf632a7fab4e4ff33@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:34705 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757012Ab0EFJxh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 05:53:37 -0400
Received: by ewy20 with SMTP id 20so1613415ewy.1
        for <linux-omap@vger.kernel.org>; Thu, 06 May 2010 02:53:34 -0700 (PDT)
In-Reply-To: <l2l94a0d4531005020858l1a79e4f3hf632a7fab4e4ff33@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>


Op 2 mei 2010, om 17:58 heeft Felipe Contreras het volgende geschreven:
> 
> I also have these changes in one of my trees backported from Tomi
> Valkeinen's tree. I'm attaching the diff; some of these are cosmetic,
> but I think the gpio changes make sense, although I don't know if
> omap_mux_init_gpio is really needed.
> 
> I think the current proposed patch should go in already, I don't know
> what we are waiting for.
> 
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> 
> +#if 0
> +	/* is this really needed? */
> +	omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_PIN_INPUT);
> +#endif
> 	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
> 
> -	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> -	gpio_request(170, "DVI_nPD");
> -	/* REVISIT leave DVI powered down until it's needed ... */
> -	gpio_direction_output(170, true);
> -

I have a similar change queued since the new beagle xM moves DVI reset to gpio129, but I'm holding off on sending beagle patches here till the hardware design is finalized.

regards,

Koen