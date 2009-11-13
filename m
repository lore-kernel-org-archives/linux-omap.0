From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure fix
Date: Fri, 13 Nov 2009 17:49:18 +0000
Message-ID: <171D41FE-0C40-4921-97FF-B8DE2D360C9A@opensource.wolfsonmicro.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com> (sfid-20091113_173850_761073_9598FCAB)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52014 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756413AbZKMRtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 12:49:17 -0500
In-Reply-To: <1258133987-20488-1-git-send-email-jwang@ti.com> (sfid-20091113_173850_761073_9598FCAB)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, Jane Wang <jwang@ti.com>

On 13 Nov 2009, at 17:39, Jane Wang <jwang@ti.com> wrote:

> McBSP fucntional clock is not disabled when suspend is triggerd which
> prevents PER domain entering target low-power state. To fix the  
> problem:
>
> 1. Disable/enable McBSP functional clock for suspend/resume.
>
> 2. In addition, reconfigure McBSP, this is needed when systerm comes  
> out of OFF state.
>

There is no need to resend your patches this iften - please allow at  
least a week or so for review. You only need to repost if addressing  
comments or it looks like the patch got missed.

> Signed-off-by: Jane Wang <jwang@ti.com>
> ---
> arch/arm/plat-omap/include/mach/mcbsp.h |    2 ++
> arch/arm/plat-omap/mcbsp.c              |   27 ++++++++++++++++++++++ 
> +++++
> sound/soc/omap/omap-mcbsp.c             |   14 ++++++++++++--
> 3 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat- 
> omap/include/mach/mcbsp.h
> index e0d6eca..94e1c66 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -440,6 +440,8 @@ static inline int omap_mcbsp_get_dma_op_mode 
> (unsigned int id) { return 0; }
> #endif
> int omap_mcbsp_request(unsigned int id);
> void omap_mcbsp_free(unsigned int id);
> +void omap_mcbsp_disable_fclk(unsigned int id);
> +void omap_mcbsp_enable_fclk(unsigned int id);
> void omap_mcbsp_start(unsigned int id, int tx, int rx);
> void omap_mcbsp_stop(unsigned int id, int tx, int rx);
> void omap_mcbsp_xmit_word(unsigned int id, u32 word);
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index e664b91..bfe3c61 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -459,6 +459,33 @@ int omap_mcbsp_request(unsigned int id)
> }
> EXPORT_SYMBOL(omap_mcbsp_request);
>
> +void omap_mcbsp_disable_fclk(unsigned int id)
> +{
> +    struct omap_mcbsp *mcbsp;
> +
> +    if (!omap_mcbsp_check_valid_id(id)) {
> +        printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +        return;
> +    }
> +    mcbsp = id_to_mcbsp_ptr(id);
> +    clk_disable(mcbsp->fclk);
> +}
> +EXPORT_SYMBOL(omap_mcbsp_disable_fclk);
> +
> +
> +void omap_mcbsp_enable_fclk(unsigned int id)
> +{
> +    struct omap_mcbsp *mcbsp;
> +
> +    if (!omap_mcbsp_check_valid_id(id)) {
> +        printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +        return;
> +    }
> +    mcbsp = id_to_mcbsp_ptr(id);
> +    clk_enable(mcbsp->fclk);
> +}
> +EXPORT_SYMBOL(omap_mcbsp_enable_fclk);
> +
> void omap_mcbsp_free(unsigned int id)
> {
>    struct omap_mcbsp *mcbsp;
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 45be942..e56b5ff 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -229,18 +229,28 @@ static int omap_mcbsp_dai_trigger(struct  
> snd_pcm_substream *substream, int cmd,
>
>    switch (cmd) {
>    case SNDRV_PCM_TRIGGER_START:
> -    case SNDRV_PCM_TRIGGER_RESUME:
>    case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>        mcbsp_data->active++;
>        omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
>        break;
> +    case SNDRV_PCM_TRIGGER_RESUME:
> +        mcbsp_data->active++;
> +        omap_mcbsp_enable_fclk(mcbsp_data->bus_id);
> +        omap_mcbsp_config(mcbsp_data->bus_id,
> +                    &mcbsp_data->regs);
> +        omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
> +        break;
>
>    case SNDRV_PCM_TRIGGER_STOP:
> -    case SNDRV_PCM_TRIGGER_SUSPEND:
>    case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>        omap_mcbsp_stop(mcbsp_data->bus_id, play, !play);
>        mcbsp_data->active--;
>        break;
> +    case SNDRV_PCM_TRIGGER_SUSPEND:
> +        omap_mcbsp_stop(mcbsp_data->bus_id, play, !play);
> +        omap_mcbsp_disable_fclk(mcbsp_data->bus_id);
> +        mcbsp_data->active--;
> +        break;
>    default:
>        err = -EINVAL;
>    }
> -- 
> 1.5.4.3
>
