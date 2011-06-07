From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 03/12] OMAP3: Move common pmic
 configuration to pmic-common
Date: Tue, 7 Jun 2011 17:45:35 +0300
Message-ID: <20110607144534.GA27477@atomide.com>
References: <1307456297-15010-1-git-send-email-peter.ujfalusi@ti.com>
	<1307456297-15010-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1307456297-15010-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110607 17:14]:
> Reduce the amount of duplicated code by moving the common
> configuration for twl4030/5030/tpsxx to the pmic-common file.
> Use the omap3_pmic_config function from board files to
> properly configure the PMIC with the common fields.
...

> --- a/arch/arm/mach-omap2/pmic-common.h
> +++ b/arch/arm/mach-omap2/pmic-common.h
> @@ -2,6 +2,9 @@
>  #define __OMAP_PMIC_COMMON__
>  
>  #define TWL_COMMON_PDATA_USB		(1 << 0)
> +#define TWL_COMMON_PDATA_BCI		(1 << 1)
> +#define TWL_COMMON_PDATA_MADC		(1 << 2)
> +#define TWL_COMMON_PDATA_CODEC		(1 << 3)

This is looking good, thanks for cleaning up the twl bloat in
board-*.c files :)

Maybe already define TWL_COMMON_PDATA_AUDIO here so you can
drop most of patch 7/12?

If you need both then you can temporarily have:

#define TWL_COMMON_PDATA_CODEC	TWL_COMMON_PDATA_AUDIO

Regards,

Tony
