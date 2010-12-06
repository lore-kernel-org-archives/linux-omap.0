From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V4 2/2] omap4: platform changes for CMA3000
Date: Mon, 6 Dec 2010 11:39:13 -0800
Message-ID: <20101206193913.GP8345@atomide.com>
References: <37166.10.24.255.17.1291028266.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37166.10.24.255.17.1291028266.squirrel@dbdmail.itg.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [101129 02:48]:
> From 8082870cc704d901d98cf0d6af90e45860927ceb Mon Sep 17 00:00:00 2001
> From: Hemanth V <hemanthv@ti.com>
> Date: Thu, 26 Aug 2010 17:49:12 +0530
> Subject: [PATCH] Platform changes for CMA3000 Accelerometer driver
> 
> Update 4430 SDP board file with platform data for accelerometer driver
> and select the driver in kconfig
> 
> Signed-off-by: Hemanth V <hemanthv@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig         |    2 ++
>  arch/arm/mach-omap2/board-4430sdp.c |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index a928fd6..e87c049 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -255,6 +255,8 @@ config MACH_OMAP_4430SDP
>  	depends on ARCH_OMAP4
>  	select INPUT_TOUCHSCREEN
>  	select TOUCHSCREEN_SYNTM12XX
> +	select INPUT_MISC
> + 	select INPUT_CMA3000
> + 	select INPUT_CMA3000_I2C
> 

The better way is to patch omap2plus_defconfig so these get added
as modules.

Regards,

Tony
