From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/7] OMAP3: powerdomain data: add voltage domains
Date: Tue, 22 Mar 2011 13:30:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103221324461.11798@utopia.booyaka.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-8-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55514 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab1CVTa7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 15:30:59 -0400
In-Reply-To: <1300493932-17362-8-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Kevin,

a couple of comments below..

On Fri, 18 Mar 2011, Kevin Hilman wrote:

> Add voltage domain name to indicate which voltagedomain each
> powerdomain is in.  A missing voltage domain name means that that
> powerdomain is not in one of the currently scalable voltage domains.

Before you add these, you might want to change the voltagedomain names for 
OMAP3.  I don't think it's correct to refer to the VDD1 voltagedomain as 
"mpu" since it includes both the MPU and IVA.  Probably best to use simply 
"vdd1" and "vdd2" since that is the historical usage.

also...

> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomains3xxx_data.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> index 9c9c113..bd01025 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -52,6 +52,7 @@ static struct powerdomain iva2_pwrdm = {
>  		[2] = PWRSTS_OFF_ON,
>  		[3] = PWRSTS_ON,
>  	},
> +	.voltdm           = { .name = "mpu" },
>  };
>  
>  static struct powerdomain mpu_3xxx_pwrdm = {
> @@ -68,6 +69,7 @@ static struct powerdomain mpu_3xxx_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRSTS_OFF_ON,
>  	},
> +	.voltdm           = { .name = "mpu" },
>  };
>  
>  /*
> @@ -98,6 +100,7 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
>  		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
>  		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
>  	},
> +	.voltdm           = { .name = "core" },
>  };
>  
>  static struct powerdomain core_3xxx_es3_1_pwrdm = {
> @@ -121,6 +124,7 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
>  		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
>  		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
>  	},
> +	.voltdm           = { .name = "core" },
>  };
>  
>  static struct powerdomain dss_pwrdm = {
> @@ -157,6 +161,7 @@ static struct powerdomain sgx_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRSTS_ON,  /* MEMONSTATE */
>  	},
> +	.voltdm           = { .name = "core" },
>  };
>  
>  static struct powerdomain cam_pwrdm = {
> @@ -172,6 +177,7 @@ static struct powerdomain cam_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRSTS_ON,  /* MEMONSTATE */
>  	},
> +	.voltdm           = { .name = "core" },
>  };
>  
>  static struct powerdomain per_pwrdm = {
> @@ -187,12 +193,14 @@ static struct powerdomain per_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRSTS_ON,  /* MEMONSTATE */
>  	},
> +	.voltdm           = { .name = "core" },
>  };
>  
>  static struct powerdomain emu_pwrdm = {
>  	.name		= "emu_pwrdm",
>  	.prcm_offs	= OMAP3430_EMU_MOD,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.voltdm           = { .name = "core" },
>  };
>  
>  static struct powerdomain neon_pwrdm = {
> @@ -201,6 +209,7 @@ static struct powerdomain neon_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_RET,
> +	.voltdm           = { .name = "core" },

This is in VDD1.

>  };
>  
>  static struct powerdomain usbhost_pwrdm = {
> @@ -223,6 +232,7 @@ static struct powerdomain usbhost_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRSTS_ON,  /* MEMONSTATE */
>  	},
> +	.voltdm           = { .name = "core" },
>  };
>  
>  static struct powerdomain dpll1_pwrdm = {

These DPLL powerdomains should have voltagedomains also.  DPLL1 is in 
VDD1, I believe.  I think the rest are in VDD2.


- Paul
