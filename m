From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 30 Oct 2014 01:11:54 +0200
Message-ID: <20141029231154.GB23366@drone.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com>
 <5450EEE7.8070801@ti.com>
 <20141029185957.GA3723@earth.universe>
 <20141029193915.GB2542@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:49213 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934AbaJ2XMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 19:12:03 -0400
Content-Disposition: inline
In-Reply-To: <20141029193915.GB2542@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@ring0.de>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Oct 29, 2014 at 12:39:16PM -0700, Tony Lindgren wrote:
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 27 Oct 2014 13:05:54 -0700
> Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
> 
> We're moving omaps to use device tree based booting and already have
> omap2, omap4, omap5, am335x and am437x booting in device tree only
> mode.
> 
> Only omap3 still has legacy booting still around and we really want
> to make that device tree only. So let's add a warning about deprecated
> legacy booting so we get people to upgrade their boards to use device
> tree based booting and find out about any remaining issues.
> 
> Note that for most boards we already have the .dts file and those can
> be booted with without changing the bootloader using the appended
> DTB mode.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -917,6 +917,10 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
>  static int __init omap_device_late_init(void)
>  {
>  	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
> +
> +	WARN(!of_have_populated_dt(),
> +		"legacy booting deprecated, please update to boot with .dts\n");
> +
>  	return 0;
>  }
>  omap_late_initcall_sync(omap_device_late_init);
