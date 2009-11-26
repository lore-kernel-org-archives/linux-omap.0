From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Omap mux changes for v2.6.33 merge window (Series
 short description)
Date: Thu, 26 Nov 2009 10:15:50 -0800
Message-ID: <20091126181550.GJ4348@atomide.com>
References: <20091126001646.1546.34352.stgit@localhost>
 <20091126002038.GH4348@atomide.com>
 <4B0E6479.50608@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52114 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZKZSPw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 13:15:52 -0500
Content-Disposition: inline
In-Reply-To: <4B0E6479.50608@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [091126 03:19]:
> Tony,
> 
> Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [091125 16:17]:
> >> Hi all,
> >>
> >> Here are some omap mux updates for review. These
> >> are intended for the v2.6.33 merge window.
> > 
> > Forgot to edit the subject :)
> > 
> > Also, these patches are available in the mux branch
> > of the linux-omap tree for easy testing.
> 
> After all the discussions we had, what would be preferable way to define the
> board mux configuration? The omap_board_mux array or a calls for
> omap_mux_init_signal?

You should be able to just boot with CONFIG_DEBUG_FS,
check how the pins are set, and adjust as needed via sysfs.
Then when happy with the settings, just do:

# cat /sys/kernel/debug/omap_mux/board                    
OMAP3_MUX(CAM_D0, OMAP_PIN_INPUT | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE4),
OMAP3_MUX(CAM_D10, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7), 
OMAP3_MUX(CAM_D11, OMAP_PIN_INPUT | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE4),
OMAP3_MUX(CAM_D1, OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE4),
OMAP3_MUX(CAM_D2, OMAP_PIN_INPUT | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE4), 
OMAP3_MUX(CAM_D3, OMAP_PIN_OUTPUT | OMAP_MUX_MODE4),
OMAP3_MUX(CAM_D4, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7),
OMAP3_MUX(CAM_D5, OMAP_PIN_OUTPUT | OMAP_MUX_MODE4),
OMAP3_MUX(CAM_D6, OMAP_PIN_INPUT | OMAP_MUX_MODE0),
OMAP3_MUX(CAM_D7, OMAP_PIN_INPUT | OMAP_MUX_MODE0),
OMAP3_MUX(CAM_D8, OMAP_PIN_INPUT | OMAP_MUX_MODE0),
OMAP3_MUX(CAM_D9, OMAP_PIN_INPUT | OMAP_MUX_MODE0),
...

And then use the output for the struct omap_board_mux board_mux[]
in your board-*.c files.

For the common device init functions and omap_hwmod, we probably
want to use the signal names. That allows more generic initialization
of the internal devices, but some pins for sure still need to
be muxed in a board specific way.

Regards,

Tony

