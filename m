From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 6/8] DSPBRIDGE: Use dspbridge to initialize platform data
Date: Thu, 7 Jan 2010 20:29:24 -0600
Message-ID: <4B469884.1080209@ti.com>
References: <1262912450-30100-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43254 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab0AHC30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 21:29:26 -0500
In-Reply-To: <1262912450-30100-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Ramirez Luna, Omar had written, on 01/07/2010 07:00 PM, the following:
> Include dspbridge compilation whenever bridge driver is selected to
> be compiled, either as a module or part of the kernel. This will
> initialize platform data specific PM functions.
?? are you intending to state that dspbridge.c can now not be a module? 
can you elaborate more as to why?

> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index d1cf986..0881470 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -75,7 +75,9 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
>  # Debobs
>  obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
?? I dont find this in l-o master/2.6.32.. something I am missing?

>  
> -obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
> +ifneq ($(CONFIG_MPU_BRIDGE),)
> +obj-y					+= dspbridge.o
> +endif

>  
>  # Specific board support
>  obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o


-- 
Regards,
Nishanth Menon
