From: Tony Lindgren <tony@atomide.com>
Subject: Re: Query on new mux usage
Date: Tue, 29 Dec 2009 10:23:38 -0800
Message-ID: <20091229182338.GY3512@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E1C30C1E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58138 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbZL2SXl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 13:23:41 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E1C30C1E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [091229 05:41]:
> Hi,
>  
> I am trying to define the mux settings for keypad on the omap3evm.
> I had a few queries on the same.
>  
> 1) Is it enough to me this change:
>  
>  static struct omap_board_mux board_mux[] __initdata = {
> +
> +       /* SYS_NIRQ */
> +       OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
> +						OMAP_PIN_OFF_INPUT_PULLUP),
> +
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },

This will do the trick for board specific things. If you want, you can
dump the whole mux table set by the bootloader via debugfs if you cat
/sys/kernel/debug/omap_mux. Then you can check and edit the table as
needed.
 
> 2) Or should I follow with this (in the evm init code):
>  
> +	omap_mux_init_signal("af26", OMAP_PIN_INPUT_PULLUP |
> +						OMAP_PIN_OFF_INPUT_PULLUP);

This can be used too if you prefer. The mux_init_gpio and mux_init_signal
functions are mostly intended for platform init functions for common
hardware, like MMC, USB etc. For board specific pins, I'd go with
#1 abobve.

> 3) OR is this a better(or worse)
> 
>  static struct omap_board_mux board_mux[] __initdata = {
> +
> +       /* SYS_NIRQ */
> +       OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0),
> +
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
> 
> ..and later
>  
> +	omap_mux_init_signal("af26", OMAP_PIN_INPUT_PULLUP |
> +						OMAP_PIN_OFF_INPUT_PULLUP);
> 

Then you're doing it twice, which is not needed.

Eventually we should have common init functions using hwmod for all
the omap internal devices and do the muxing there too. But some
board specific muxing will always be still needed.

Regards,

Tony
