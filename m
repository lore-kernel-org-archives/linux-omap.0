From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2+: pm33xx-core: Add platform code needed
 for PM
Date: Tue, 4 Apr 2017 09:19:19 -0700
Message-ID: <20170404161919.GU10760@atomide.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
 <20170329015801.22240-7-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170329015801.22240-7-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Russell,

* Dave Gerlach <d-gerlach@ti.com> [170328 19:01]:
> Most of the PM code needed for am335x and am437x can be moved into a
> module under drivers but some core code must remain in mach-omap2 at the
> moment. This includes some internal clockdomain APIs and low-level ARM
> APIs which are also not exported for use by modules.
> 
> Implement a few functions that handle these low-level platform
> operations can be passed to the pm33xx module through the use of
> platform data.
> 
> In addition to this, to be able to share data structures between C and
> the sleep33xx and sleep43xx assembly code, we can automatically generate
> all of the C struct member offsets and sizes as macros by making use of
> the ARM asm-offsets file. In the same header that we define our data
> structures in we also define all the macros in an inline function and by
> adding a call to this in the asm_offsets file all macros are properly
> generated and available to the assembly code without cluttering up the
> asm-offsets file.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/kernel/asm-offsets.c        |   2 +
>  arch/arm/mach-omap2/Kconfig          |   1 +
>  arch/arm/mach-omap2/Makefile         |   4 +
>  arch/arm/mach-omap2/pm.h             |   5 +
>  arch/arm/mach-omap2/pm33xx-core.c    | 181 +++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/pm33xx.h |  69 +++++++++++++
>  6 files changed, 262 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
>  create mode 100644 include/linux/platform_data/pm33xx.h
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index d728b5660e36..62253e7bfac4 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -28,6 +28,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <linux/kbuild.h>
> +#include <linux/platform_data/pm33xx.h>
>  #include <linux/ti-emif-sram.h>
>  
>  /*
> @@ -187,6 +188,7 @@ int main(void)
>  #if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
>    BLANK();
>    ti_emif_offsets();
> +  amx3_pm_asm_offsets();
>  #endif
>  
>    return 0; 

Here too can you please check this is OK with you.

Regards,

Tony
