From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: DRA752: add detection of SoC information
Date: Tue, 20 May 2014 11:34:56 +0530
Message-ID: <537AF088.4000506@ti.com>
References: <1400513231-25092-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400513231-25092-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 19 May 2014 08:57 PM, Nishanth Menon wrote:
> Currently the files in /sys/devices/soc0/ show no information about
> DRA7. Few userspace programs do depend on this information to make SoC
> specific support. So update logic to detect the relevant information and
> provide to userspace.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> based on v3.15-rc5
> 
> Test log: http://slexy.org/view/s2FDZatq6f
> 
>  arch/arm/mach-omap2/id.c  |   37 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/io.c  |    1 +
>  arch/arm/mach-omap2/soc.h |    5 +++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 157412e..71bf216 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -628,6 +628,41 @@ void __init omap5xxx_check_revision(void)
>  	pr_info("%s %s\n", soc_name, soc_rev);
>  }
>  
> +void __init dra7xxx_check_revision(void)
> +{
> +	u32 idcode;
> +	u16 hawkeye;
> +	u8 rev;
> +
> +	idcode = read_tap_reg(OMAP_TAP_IDCODE);
> +	hawkeye = (idcode >> 12) & 0xffff;
> +	rev = (idcode >> 28) & 0xff;
> +	switch (hawkeye) {
> +	case 0xb990:
> +		switch (rev) {
> +		case 0:
> +			omap_revision = DRA752_REV_ES1_0;
> +			break;
> +		case 1:
> +		default:
> +			omap_revision = DRA752_REV_ES1_1;
> +		}
> +		break;

So we are back to checking revisions based on idcode register then?
This patch was posted almost a year back and was shot down by you
included saying we need to use dt compatibles for it.

https://www.mail-archive.com/linux-omap@vger.kernel.org/msg93136.html

> +
> +	default:
> +		/* Unknown default to latest silicon rev as default*/
> +		pr_warn("%s: unknown idcode=0x%08x (hawkeye=0x%08x,rev=0x%d)\n",
> +			__func__, idcode, hawkeye, rev);
> +		omap_revision = DRA752_REV_ES1_1;
> +	}
> +
> +	sprintf(soc_name, "DRA%03x", omap_rev() >> 16);
> +	sprintf(soc_rev, "ES%d.%d", (omap_rev() >> 12) & 0xf,
> +		(omap_rev() >> 8) & 0xf);
> +
> +	pr_info("%s %s\n", soc_name, soc_rev);
> +}
> +
>  /*
>   * Set up things for map_io and processor detection later on. Gets called
>   * pretty much first thing from board init. For multi-omap, this gets
> @@ -669,6 +704,8 @@ static const char * __init omap_get_family(void)
>  		return kasprintf(GFP_KERNEL, "OMAP5");
>  	else if (soc_is_am43xx())
>  		return kasprintf(GFP_KERNEL, "AM43xx");
> +	else if (soc_is_dra7xx())
> +		return kasprintf(GFP_KERNEL, "DRA7");
>  	else
>  		return kasprintf(GFP_KERNEL, "Unknown");
>  }
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index f14f9ac..4ec3b4a 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -693,6 +693,7 @@ void __init dra7xx_init_early(void)
>  	omap_prm_base_init();
>  	omap_cm_base_init();
>  	omap44xx_prm_init();
> +	dra7xxx_check_revision();
>  	dra7xx_powerdomains_init();
>  	dra7xx_clockdomains_init();
>  	dra7xx_hwmod_init();
> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
> index 30abcc8..de2a34c 100644
> --- a/arch/arm/mach-omap2/soc.h
> +++ b/arch/arm/mach-omap2/soc.h
> @@ -459,10 +459,15 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define OMAP5430_REV_ES2_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x20 << 8))
>  #define OMAP5432_REV_ES2_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x20 << 8))
>  
> +#define DRA7XX_CLASS		0x07000000
> +#define DRA752_REV_ES1_0	(DRA7XX_CLASS | (0x52 << 16) | (0x10 << 8))
> +#define DRA752_REV_ES1_1	(DRA7XX_CLASS | (0x52 << 16) | (0x11 << 8))
> +
>  void omap2xxx_check_revision(void);
>  void omap3xxx_check_revision(void);
>  void omap4xxx_check_revision(void);
>  void omap5xxx_check_revision(void);
> +void dra7xxx_check_revision(void);
>  void omap3xxx_check_features(void);
>  void ti81xx_check_features(void);
>  void am33xx_check_features(void);
> 
