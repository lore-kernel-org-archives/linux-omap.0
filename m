From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAPDSS: sharp-ls037v7dw01 DT support
Date: Fri, 16 May 2014 09:12:25 -0700
Message-ID: <20140516161224.GE22031@atomide.com>
References: <1400225402-18274-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11110 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbaEPQMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 12:12:30 -0400
Content-Disposition: inline
In-Reply-To: <1400225402-18274-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140516 00:31]:
> Hi,
> 
> These are slightly reworked versions of the patches Tony sent:
> 
> * Split the DT doc into separate patch
> * Handle errors from gpio functions
> * Remove QVGA support
> * Removed the change to arch/arm/mach-omap2/display.c. I'll add that to my
>   patch which moves the conversion code to omapdss. Note that if you test this
>   version, you need to add the panel name to the conversion list for now.
> * Set MO gpio GPIO_ACTIVE_HIGH in omap3-evm-common.dtsi
> * Set the GPIO default values the same way for DT and non-DT versions.
> 
> Tony, I removed the QVGA support as it was a new feature, not supported by the
> non-DT version. Also, I don't think it should be done as you had implemented
> it, but rather either have a flag in the DT data in case the pin is hardwired
> in the hardware, or let the user select the mode at runtime.

OK. Probably should have both options eventually.
 
> Also, I didn't quite understand the implementation. You had set initial values
> in the driver for MO and RESB differently than on the non-DT version. Was that
> on purpose?

I just configured things to what we had earlier for the legacy booting,
QVGA for ldp and VGA for omap3-evm.
 
> You said in a comment: "The LCD is sideways, so we want the VGA mode instead of
> QVGA mode.". Why is that? How does the resolution affect the orientation?

Yeah that's pretty confusing and probably written before I got the
image working properly. I probably initially thought the VGA mode also
switches the panel to 640x480, while it really sets it to 480x640.
 
> With my version, the panel (should) always be in VGA mode, like the non-DT
> version does.
> 
> Only compile tested, I don't have boards with the panel.

Works for me on omap3-evm and ldp after patching in the mode to your
panel compatible translation database system.

Regards,

Tony
