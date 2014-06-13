From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/36] ARM: OMAP2+: gpmc: Allow drivers to reconfigure
 GPMC settings & timings
Date: Fri, 13 Jun 2014 00:25:50 -0700
Message-ID: <20140613072550.GM17845@atomide.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
 <1402477001-31132-15-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402477001-31132-15-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, kyungmin.park@samsung.com, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140611 01:58]:
> Some devices (e.g. TUSB6010, omap-onenand) need to reconfigure the GPMC
> timings in order to operate with different peripheral clock frequencies.
> Introduce omap_gpmc_retime() to allow them to do that. The driver
> needs to pass the chips select number, GPMC settings and Device timings to
> omap_gpmc_retime().
> 
> NOTE: Device tree and board code must still pass the most conservative
> timings to GPMC so that the device can be probed by the respective driver.
> e.g. Onenand must operate in asynchronous mode at bootup. The device driver
> can then request for more optimal timings via omap_gpmc_retime().

Hmm but many of the devices are Linux generic like sms91x and 8250 so it's
not nice to start stuffing omap bus specific data there.

I wonder if we should just keep device specific gpmc-smc91x.c etc
in drivers/memory?

Regards,

Tony
