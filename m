From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 01/13] ARM: OMAP5: id: Add cpu id for ES versions
Date: Thu, 10 May 2012 14:18:30 +0300
Message-ID: <4FABA406.1080608@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56016 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498Ab2EJLSp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 07:18:45 -0400
In-Reply-To: <1336029982-31898-2-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com

Hi,
\
On 05/03/2012 10:26 AM, R Sricharan wrote:
> Adding the OMAP5 ES1.0, 2.0 and OMAP5432 cpu revision
> detection support.
> 
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/control.h         |    4 +++
>  arch/arm/mach-omap2/id.c              |   47 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/cpu.h |   23 ++++++++++++++-
>  3 files changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index a406fd0..9daac6f 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -246,6 +246,10 @@
>  /* TI81XX CONTROL_DEVCONF register offsets */
>  #define TI81XX_CONTROL_DEVICE_ID	(TI81XX_CONTROL_DEVCONF + 0x000)
>  
> +/* OMAP54XX CONTROL STATUS register */
> +#define OMAP5XXX_CONTROL_STATUS                0x134
> +#define OMAP5_DEVICETYPE_MASK          (0x7 << 6)
> +
>  /*
>   * REVISIT: This list of registers is not comprehensive - there are more
>   * that should be added.
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 0e79b7b..d2ec323 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -50,6 +50,11 @@ int omap_type(void)
>  		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
>  	} else if (cpu_is_omap44xx()) {
>  		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
> +	} else if (cpu_is_omap54xx()) {
> +		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
> +		val &= OMAP5_DEVICETYPE_MASK;
> +		val >>= 6;
> +		goto out;
>  	} else {
>  		pr_err("Cannot detect omap type!\n");
>  		goto out;
> @@ -500,6 +505,48 @@ void __init omap4xxx_check_revision(void)
>  		((omap_rev() >> 12) & 0xf), ((omap_rev() >> 8) & 0xf));
>  }
>  
> +void __init omap5xxx_check_revision(void)
> +{
> +	u32 idcode;
> +	u16 hawkeye;
> +	u8 rev;
> +
> +	idcode = read_tap_reg(OMAP_TAP_IDCODE);
> +	hawkeye = (idcode >> 12) & 0xffff;
> +	rev = (idcode >> 28) & 0xff;
> +	switch (hawkeye) {
> +	case 0xb942:
> +		switch (rev) {
> +		case 0:
> +			omap_revision = OMAP5430_REV_ES1_0;
> +			break;
> +		case 1:
> +			omap_revision = OMAP5430_REV_ES2_0;
> +			break;
> +		default:
> +			omap_revision = OMAP5430_REV_ES1_0;

Default should always be the latest version supported. i.e. in this case
it should be OMAP5430_REV_ES2_0


> +		}
> +		break;
> +
> +	case 0xb998:
> +		switch (rev) {
> +		case 0:
> +			omap_revision = OMAP5432_REV_ES1_0;
> +			break;
> +		default:
> +			omap_revision = OMAP5432_REV_ES1_0;
> +		}
> +		break;
> +
> +	default:
> +		/* Unknown default to latest silicon rev as default*/
> +		omap_revision = OMAP5430_REV_ES2_0;
> +	}
> +
> +	pr_info("OMAP%04x ES%d.0\n",
> +			omap_rev() >> 16, ((omap_rev() >> 12) & 0xf));
> +}
> +

regards,
-roger
