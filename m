From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Tue, 30 Nov 2010 10:30:10 -0800
Message-ID: <20101130183010.GS17222@atomide.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
 <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39103 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab0K3SaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 13:30:13 -0500
Content-Disposition: inline
In-Reply-To: <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [101122 02:12]:
> Hi,
> 
> On Mon, Nov 22, 2010 at 02:22:40PM +0530, Ajay Kumar Gupta wrote:
> >Fixes compilation error as control.h APIs are not available to
> >drivers/usb/musb/am35x.c file. Earlier it was getting included
> >from <plat/control.h> but now moved to new location by another
> >pacth.
> >
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Tony ? Do you ack the usage of that header ?

NAK. Drivers should not mess with the control registers directly.

Instead, the following should be done in the platform init code:

$ grep -r omap_ctrl_read drivers/usb
drivers/usb/musb/am35x.c:       devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
drivers/usb/musb/am35x.c:       while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
drivers/usb/musb/am35x.c:       devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
drivers/usb/musb/am35x.c:               lvl_intr = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
drivers/usb/musb/am35x.c:       u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
drivers/usb/musb/am35x.c:       sw_reset = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
drivers/usb/musb/am35x.c:       lvl_intr = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);

You can pass a function pointer like board_set_power or simila
in platform_data.

Regards,

Tony
