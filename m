From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Thu, 31 Aug 2017 15:03:32 +0100
Message-ID: <20170831140332.GD23750@n2100.armlinux.org.uk>
References: <20170724212454.27574-1-d-gerlach@ti.com>
 <20170724212454.27574-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724212454.27574-3-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 24, 2017 at 04:24:54PM -0500, Dave Gerlach wrote:
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 608008229c7d..46a7a6c41db7 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -28,6 +28,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <linux/kbuild.h>
> +#include <linux/ti-emif-sram.h>
>  
>  /*
>   * Make sure that the compiler and target are compatible.
> @@ -183,5 +184,8 @@ int main(void)
>  #ifdef CONFIG_VDSO
>    DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
>  #endif
> +  BLANK();
> +  ti_emif_offsets();
> +
>    return 0; 
>  }

This doesn't make me happy - I've been thinking about this for some time,
and I think it's completely wrong for drivers to hook into asm-offsets.

Looking at the top-level Kbuild file, it looks like it would be easy
for emif to auto-generate its own offsets.h header - it looks like it's
a matter of using linux/kbuild.h to get the definitions, compiling to
assembly (using $(call if_changed_dep,cc_s_c)) and then converting the
assembly to the header file format ( using
$(call filechk,offsets,__ASM_OFFSETS_H__), replacing __ASM_OFFSETS_H__
with a more appropriate symbol.)

Could you please check whether this is possible, so we don't end up
needing to hook lots of driver-specific assembly offsets stuff into
the arch files?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
