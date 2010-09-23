From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 2/2] omap4: platform changes for CMA3000
Date: Thu, 23 Sep 2010 16:13:09 -0700
Message-ID: <20100923231308.GT4211@atomide.com>
References: <61206.10.24.255.18.1283926699.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61206.10.24.255.18.1283926699.squirrel@dbdmail.itg.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [100907 23:11]:
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
> + 	select INPUT_CMA3000_I2C
> 
>  config MACH_OMAP4_PANDA
>  	bool "OMAP4 Panda Board"

This does not apply, can you please refresh against the current
devel-boards branch in the linux-omap tree. I'm getting:

patching file arch/arm/mach-omap2/Kconfig
Hunk #1 FAILED at 255.
1 out of 1 hunk FAILED -- rejects in file arch/arm/mach-omap2/Kconfig
patching file arch/arm/mach-omap2/board-4430sdp.c
Hunk #2 FAILED at 46.
Hunk #3 succeeded at 441 (offset -46 lines).
Hunk #4 succeeded at 479 with fuzz 2 (offset -62 lines).
Hunk #5 succeeded at 518 (offset -80 lines).
1 out of 5 hunks FAILED -- rejects in file arch/arm/mach-omap2/board-4430sdp.c
Patch apply does not apply (enforce with -f)

Regards,

Tony
