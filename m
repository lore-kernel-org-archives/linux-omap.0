From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5] omap: Allow testing for omap type with omap_has_feature
Date: Thu, 8 Jul 2010 10:03:45 -0500
Message-ID: <4C35E8D1.6030504@ti.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com> <20100708093804.16352.82935.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60441 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755567Ab0GHPDr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 11:03:47 -0400
In-Reply-To: <20100708093804.16352.82935.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 07/08/2010 04:38 AM, the following:
> Allow testing for omap type with omap_has_feature. This
> can be used to leave out cpu_is_omapxxxx checks.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/include/plat/cpu.h |   38 ++++++++++++++++++++++++++-------
>  1 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 96eac4d..c117c3c 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -437,14 +437,36 @@ int omap_chip_is(struct omap_chip_id oci);
>  void omap2_check_revision(void);
>  
>  /*
> - * Runtime detection of OMAP3 features
> + * Runtime detection of OMAP features
>   */
> -#define OMAP3_HAS_L2CACHE		BIT(0)
> -#define OMAP3_HAS_IVA			BIT(1)
> -#define OMAP3_HAS_SGX			BIT(2)
> -#define OMAP3_HAS_NEON			BIT(3)
> -#define OMAP3_HAS_ISP			BIT(4)
> -#define OMAP3_HAS_192MHZ_CLK		BIT(5)
> -#define OMAP3_HAS_IO_WAKEUP		BIT(6)
> +#define OMAP_FEAT_CLASS_OMAP1		BIT(24)
> +#define OMAP_FEAT_CLASS_OMAP2		BIT(25)
> +#define OMAP_FEAT_CLASS_OMAP3		BIT(26)
> +#define OMAP_FEAT_CLASS_OMAP4		BIT(27)
> +
> +#define OMAP_HAS_L2CACHE		BIT(0)
> +#define OMAP_HAS_IVA			BIT(1)
> +#define OMAP_HAS_SGX			BIT(2)
> +#define OMAP_HAS_NEON			BIT(3)
> +#define OMAP_HAS_ISP			BIT(4)
> +#define OMAP_HAS_192MHZ_CLK		BIT(5)
> +#define OMAP_HAS_IO_WAKEUP		BIT(6)
> +
> +#define OMAP2_HAS_IVA			OMAP_FEAT_CLASS_OMAP2 | OMAP_HAS_IVA
> +#define OMAP2_HAS_SGX			OMAP_FEAT_CLASS_OMAP2 | OMAP_HAS_SGX
> +
> +#define OMAP3_HAS_L2CACHE		OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_L2CACHE
> +#define OMAP3_HAS_IVA			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_IVA
> +#define OMAP3_HAS_SGX			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_SGX
> +#define OMAP3_HAS_NEON			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_NEON
> +#define OMAP3_HAS_ISP			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_ISP
> +#define OMAP3_HAS_192MHZ_CLK		OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_192MHZ_CLK
> +#define OMAP3_HAS_IO_WAKEUP		OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_IOWAKEUP
> +
> +#define OMAP4_HAS_L2CACHE		OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_L2CACHE
> +#define OMAP4_HAS_IVA			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_IVA
> +#define OMAP4_HAS_SGX			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_SGX
> +#define OMAP4_HAS_NEON			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_NEON
> +#define OMAP4_HAS_ISP			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_ISP
>  
>  #endif
> 
here is my contention:
there will be two ways to use this:
omap_has_feature(OMAP_HAS_SGX) and omap_has_feature(OMAP3_HAS_SGX)

OMAP_HAS_SGX should return true or false no matter what omap silicon it is.

OMAP3_HAS_SGX usage is meant for what? it is a mixture of cpu_is_omap3() 
and omap_has_feature(OMAP_HAS_SGX) - tries to do two things in one shot. 
which defeats why we are trying to introduce a generic omap_has_feature 
in the first place.
a) confusing as there seems to be two standards
b) redundant information use cpu_is_omapxyz() if needed.

IMHO:
+#define OMAP_HAS_L2CACHE		BIT(0)
+#define OMAP_HAS_IVA			BIT(1)
+#define OMAP_HAS_SGX			BIT(2)
+#define OMAP_HAS_NEON			BIT(3)
+#define OMAP_HAS_ISP			BIT(4)
+#define OMAP3_HAS_192MHZ_CLK		BIT(5)
+#define OMAP_HAS_IO_WAKEUP		BIT(6)
and later if needed
+#define OMAP4_SOME_NEW_OMAP4ONLY_FEATURE BIT(7)

where OMAP3_HAS is indicative that this is a OMAP3 *only* feature and 
should be used to differentiate between various omap3 silicon.

Benefits:
a) distinction b/w omap generic and omap family specific features
b) you get to define 32 features instead of reserving 24-32 for OMAP 
classes.

-- 
Regards,
Nishanth Menon
