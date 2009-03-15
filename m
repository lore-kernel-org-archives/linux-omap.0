From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/12] ARM: OMAP3: MUSB initialization for omap hw
Date: Sun, 15 Mar 2009 16:14:47 +0000
Message-ID: <20090315161446.GG10786@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211628.16425.55120.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59513 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbZCOQPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 12:15:04 -0400
Content-Disposition: inline
In-Reply-To: <20090310211628.16425.55120.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Ajay Kumar Gupta <ajay.gupta@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Tue, Mar 10, 2009 at 02:16:28PM -0700, Tony Lindgren wrote:
> Patch modified by Tony to build the module based on
> CONFIG_USB_MUSB_SOC.

I don't see this.

> +# Platform specific device init code
> +obj-$(CONFIG_USB_MUSB_SOC)		+= usb-musb.o

So, if this can be a module, the file itself doesn't export any symbols
and doesn't have any module_init or module_exit functions.  So, if this
gets built as a module, it isn't useful.

> +void __init usb_musb_init(void)
> +{
> +	if (cpu_is_omap243x()) {
> +		musb_resources[0].start = OMAP243X_HS_BASE;
> +		musb_plat.clock = "usbhs_ick";

kill kill kill.

> +	} else {
> +		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> +		musb_plat.clock = "hsotgusb_ick";

kill kill kill.

clkdev removes the need for this sort of crap.
