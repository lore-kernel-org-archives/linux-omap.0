From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Fscking OMAP
Date: Mon, 20 Apr 2015 18:14:21 +0100
Message-ID: <20150420171421.GY4027@n2100.arm.linux.org.uk>
References: <20150420154912.GW4027@n2100.arm.linux.org.uk>
 <20150420162515.GK18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42250 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbbDTROd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2015 13:14:33 -0400
Content-Disposition: inline
In-Reply-To: <20150420162515.GK18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

On Mon, Apr 20, 2015 at 09:25:16AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150420 08:50]:
> > Guys,
> > 
> > If you're going to introduce a dependency on some infrastructure which
> > you absolutely require for booting, then _please_ ensure that the
> > configuration system is updated such that pre-existing kernel
> > configurations continue to work.
> > 
> > Don't leave it such that the infrastructure ends up returning -ENOSYS,
> > which then filters down into your SoC specific code, and aborts the
> > initialisation of critical infrastructure, leaving you with a totally
> > silent boot failure.
> > 
> > In this case, it's the addition of syscon to OMAP internals,
> > specifically in omap_control_init().
> > 
> > This is explicitly targetted at OMAP people, who have wasted much of
> > my day today investigating why their platforms no longer boot in DT
> > mode.
> 
> Ouch, yeah missing dependencies are a pain to debug.
> 
> Looks like we get MFD_SYSCON selected with omap2plus_defconfig,
> but that's not always the case like you pointed out.
> 
> Does the patch below fix the issue for you?

Yes, that fixes it, thanks.

> 8< -----------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 20 Apr 2015 09:23:25 -0700
> Subject: [PATCH] ARM: OMAP2+: Fix booting with configs that don't have MFD_SYSCON
> 
> With the recent changes omaps have developed a dependency to MFD_SYSCON.
> This is used for system control module generic register area and some
> clocks.
> 
> We do have it selected in omap2plus_defconfig, but targeted config
> files may not have it selected. Let's make sure it's selected like
> few other ARM platforms are already doing.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -81,6 +81,7 @@ config ARCH_OMAP2PLUS
>  	select GENERIC_IRQ_CHIP
>  	select MACH_OMAP_GENERIC
>  	select MEMORY
> +	select MFD_SYSCON
>  	select OMAP_DM_TIMER
>  	select OMAP_GPMC
>  	select PINCTRL

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
