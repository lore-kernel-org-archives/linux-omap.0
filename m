From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/5] ARM: OMAP2+: pm33xx-core: Add platform code
 needed for PM
Date: Mon, 22 May 2017 07:56:54 -0700
Message-ID: <20170522145654.GQ10472@atomide.com>
References: <20170519200438.9502-1-d-gerlach@ti.com>
 <20170519200438.9502-4-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170519200438.9502-4-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Dave Gerlach <d-gerlach@ti.com> [170519 13:08]:
> In addition to this, to be able to share data structures between C and
> the sleep33xx and sleep43xx assembly code, we can automatically generate
> all of the C struct member offsets and sizes as macros by making use of
> the ARM asm-offsets file. In the same header that we define our data
> structures in we also define all the macros in an inline function and by
> adding a call to this in the asm_offsets file all macros are properly
> generated and available to the assembly code without cluttering up the
> asm-offsets file.
...
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

Russell, care to take a look at the above if you're OK with it or
if you prefer to do it some other way?

Also please see thread "[PATCH v2 0/2] memory: Introduce ti-emif-sram
driver" for similar changes.

Thanks,

Tony
