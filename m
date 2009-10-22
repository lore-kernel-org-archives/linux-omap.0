From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend] OMAP1: AMS_DELTA: Fix DSP public peripherals
	support
Date: Thu, 22 Oct 2009 11:06:59 -0700
Message-ID: <20091022180659.GP16230@atomide.com>
References: <200910220222.55900.jkrzyszt@tis.icnet.pl> <200910221421.33875.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59855 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbZJVSHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 14:07:04 -0400
Content-Disposition: inline
In-Reply-To: <200910221421.33875.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091022 05:22]:
> DSP public peripherals used to work on OMAP1510 based (or all OMAP1 class?)
> machines as long as old dspgateway code were present in the l-o tree. For
> several months it is no longer included, breaking support for McBSP1 based
> audio on Amstrad Delta, for example.
> 
> This patch, derived from the old dspgateway code, corrects the problem for the
> board by simply taking the DSP out of reset state, I guess. That way, things
> should not break when a new dsp code is added to the tree, and the change can
> be reverted then.
> 
> If there are any reports on McBSP1 or other DSP public peripherals not working
> for other OMAP1 machines (I've not heard of any for now), I can prepare a more
> general patch providing an extra include file with a helper function defined.

Seems like a good fix. Of course it would be nice to also idle the DSP for
some power savings, but maybe we can add something for that this coming merge
window.

Regards,

Tony
 
> Created and tested against linux-2.6.32-rc5
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> ---
> Thursday 22 October 2009 02:22:53 Janusz Krzysztofik wrote:
> > --- linux-2.6.32-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig	2009-10-22 
> > 00:55:49.000000000 +0200
> > +++ linux-2.6.32-rc5/arch/arm/mach-omap1/board-ams-delta.c	2009-10-22 
> > 01:46:39.000000000 +0200
> 
> Tony,
> The above lines has been mangled by my mailer, that's why I resend for your
> convenience.
> 
> --- linux-2.6.32-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig	2009-10-22 00:55:49.000000000 +0200
> +++ linux-2.6.32-rc5/arch/arm/mach-omap1/board-ams-delta.c	2009-10-22 01:46:39.000000000 +0200
> @@ -235,6 +235,8 @@ static void __init ams_delta_init(void)
>  
>  	omap_usb_init(&ams_delta_usb_config);
>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
> +
> +	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
>  }
>  
>  static struct plat_serial8250_port ams_delta_modem_ports[] = {
