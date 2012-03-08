From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/3] ARM/ASoC: OMAP McBSP: Move remainig defines from
 arch to ASoC header
Date: Thu, 08 Mar 2012 11:29:36 +0200
Message-ID: <4F587C00.1090307@ti.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com> <1331198537-13469-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43961 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755252Ab2CHJ3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 04:29:41 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so344698lah.5
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 01:29:40 -0800 (PST)
In-Reply-To: <1331198537-13469-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jarkko,

On 03/08/2012 11:22 AM, Peter Ujfalusi wrote:
> Clock signal muxing, and functional clock related defines are only ne=
eded
> in ASoC drivers.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

I have added your ack to this patch by accident when I updated the
series. Sorry about that.
Please confirm if you are OK with this change.

Sorry again,
P=E9ter

> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |   12 ------------
>  sound/soc/omap/mcbsp.h                  |   12 ++++++++++++
>  2 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-=
omap/include/plat/mcbsp.h
> index 8eb9b0e..1881412 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -31,18 +31,6 @@
>  #define MCBSP_CONFIG_TYPE3	0x3
>  #define MCBSP_CONFIG_TYPE4	0x4
> =20
> -/* CLKR signal muxing options */
> -#define CLKR_SRC_CLKR		0
> -#define CLKR_SRC_CLKX		1
> -
> -/* FSR signal muxing options */
> -#define FSR_SRC_FSR		0
> -#define FSR_SRC_FSX		1
> -
> -/* McBSP functional clock sources */
> -#define MCBSP_CLKS_PRCM_SRC	0
> -#define MCBSP_CLKS_PAD_SRC	1
> -
>  /* Platform specific configuration */
>  struct omap_mcbsp_ops {
>  	void (*request)(unsigned int);
> diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
> index a5518d7..acc9470 100644
> --- a/sound/soc/omap/mcbsp.h
> +++ b/sound/soc/omap/mcbsp.h
> @@ -230,6 +230,18 @@ enum {
>  #define XRDYEN			BIT(10)
>  #define XEMPTYEOFEN		BIT(14)
> =20
> +/* CLKR signal muxing options */
> +#define CLKR_SRC_CLKR		0
> +#define CLKR_SRC_CLKX		1
> +
> +/* FSR signal muxing options */
> +#define FSR_SRC_FSR		0
> +#define FSR_SRC_FSX		1
> +
> +/* McBSP functional clock sources */
> +#define MCBSP_CLKS_PRCM_SRC	0
> +#define MCBSP_CLKS_PAD_SRC	1
> +
>  /* we don't do multichannel for now */
>  struct omap_mcbsp_reg_cfg {
>  	u16 spcr2;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
