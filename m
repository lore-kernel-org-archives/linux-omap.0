From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 07:53:22 -0800
Message-ID: <20081126155321.GI11997@atomide.com>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@sirena.org.uk
List-Id: linux-omap@vger.kernel.org

* Stanley.Miao <stanley.miao@windriver.com> [081126 02:42]:
> Add a shared omap SoC driver to avoid reduplicate code among omap soc drivers.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  sound/soc/omap/Kconfig        |   49 +++++++++++++
>  sound/soc/omap/Makefile       |   13 ++++
>  sound/soc/omap/omap-general.c |  155 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/omap/omap-general.h |   70 ++++++++++++++++++
>  4 files changed, 287 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/omap-general.c
>  create mode 100644 sound/soc/omap/omap-general.h
> 

<snip>

> --- /dev/null
> +++ b/sound/soc/omap/omap-general.h
> @@ -0,0 +1,70 @@
> +/*
> + * omap-general.h
> + *
> + * Copyright (C) 2008 Wind River Systems, Inc.
> + *
> + * Author: Stanley Miao <stanley.miao@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#ifdef CONFIG_SND_OMAP_SOC_N810
> +#include "../codecs/tlv320aic3x.h"
> +#define CODEC_SYS_CLOCK		12000000
> +#define CODEC_NAME		"TLV320AIC33"
> +#define STREAM_NAME		"AIC33"
> +#define CODEC_DEV		(&soc_codec_dev_aic3x)
> +#define CODEC_DAI		(&aic3x_dai)
> +#define CODEC_SETUP_DATA	(&&n810_aic33_setup)
> +#define DAI_LINK_INIT		(n810_aic33_init)
> +#define SOC_OPS_STARTUP		(n810_startup)
> +#define SOC_OPS_SHUTDOWN	(n810_shutdown)
> +#else
> +#include "../codecs/twl4030.h"
> +#define CODEC_SYS_CLOCK		26000000
> +#define CODEC_NAME		"TWL4030"
> +#define STREAM_NAME		"TWL4030"
> +#define CODEC_DEV		(&soc_codec_dev_twl4030)
> +#define CODEC_DAI		(&twl4030_dai)
> +#define CODEC_SETUP_DATA 	NULL
> +#define DAI_LINK_INIT		NULL
> +#define SOC_OPS_STARTUP		NULL
> +#define SOC_OPS_SHUTDOWN	NULL
> +#endif /* CONFIG_SND_OMAP_SOC_N810 */
> +
> +#ifdef CONFIG_SND_OMAP_SOC_N810
> +#define MACHINE_IS_OMAP_GENERAL (machine_is_nokia_n810() || machine_is_nokia_n810_wimax())
> +#elif defined(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE)
> +#define MACHINE_IS_OMAP_GENERAL machine_is_omap3_beagle()
> +#elif defined(CONFIG_SND_OMAP_SOC_OVERO)
> +#define MACHINE_IS_OMAP_GENERAL machine_is_overo()
> +#elif defined(CONFIG_SND_OMAP_SOC_3430SDP)
> +#define MACHINE_IS_OMAP_GENERAL machine_is_omap_3430sdp()
> +#elif defined(CONFIG_SND_OMAP_SOC_LDP)
> +#define MACHINE_IS_OMAP_GENERAL machine_is_omap_ldp()
> +#elif defined(CONFIG_SND_OMAP_SOC_OMAP2EVM)
> +#define MACHINE_IS_OMAP_GENERAL machine_is_omap2evm()
> +#elif defined(CONFIG_SND_OMAP_SOC_OMAP3EVM)
> +#define MACHINE_IS_OMAP_GENERAL machine_is_omapevm()
> +#endif

Please also remove these ifdef elsif stuff above to compile in support
for multiple boards. The best way to to do it is to pass the
necessary info in platform_data, so you should not need to use
machine_is_omapxxxx() or cpu_is_omapxxxx() in the actual driver code.

Regards,

Tony


> +#ifndef omap_board_soc_init
> +#define omap_board_soc_init(x) 0
> +#endif
> +#ifndef omap_board_soc_exit
> +#define omap_board_soc_exit
> +#endif
> +
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
