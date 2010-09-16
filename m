From: Tony Lindgren <tony@atomide.com>
Subject: Re: LCD on Zoom2 dev board with DSS
Date: Thu, 16 Sep 2010 13:42:57 -0700
Message-ID: <20100916204256.GN29610@atomide.com>
References: <1284381807.1801.38.camel@A05BPC17>
 <1284641813.1798.589.camel@A05BPC17>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59048 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab0IPUnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 16:43:01 -0400
Content-Disposition: inline
In-Reply-To: <1284641813.1798.589.camel@A05BPC17>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yanick Saugy <yanick.saugy@heig-vd.ch>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Yanick Saugy <yanick.saugy@heig-vd.ch> [100916 05:48]:
> Hi,
> 
> I solved my problem. It appeared the PIN which controls LCD's reset
> signal (VGA_nRESET/h_GPIO_96) was not configured as a GPIO, and the
> driver tries to use it as GPIO, so the logical value was 0. We had to
> modify the OMAP MUX, and select this PIN (CAM_XCLKA) as an output GPIO
> (OMAP_MUX_MODE4).
> 
> Be aware of changing this PIN will probably disable the camera, because
> it was previously configured as a clock.
> 
> There is the patch for the LCD (diff -Naur):
> 
> --- a/arch/arm/mach-omap2/board-zoom2.c	2010-09-15 15:27:05.148399721
> +0200
> +++ b/arch/arm/mach-omap2/board-zoom2.c	2010-09-15 14:46:09.792900019
> +0200
> @@ -71,6 +71,7 @@
>  
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
> +	OMAP3_MUX(CAM_XCLKA, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #else

Please repost with proper Signed-off-by. You might want to also
Cc Tomi Valkeinen.

Regards,

Tony

