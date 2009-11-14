From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure fix
Date: Sat, 14 Nov 2009 10:20:24 +0200
Message-ID: <20091114102024.b5c302bb.jhnikula@gmail.com>
References: <1258133987-20488-1-git-send-email-jwang@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33654 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbZKNIT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Nov 2009 03:19:26 -0500
Received: by bwz27 with SMTP id 27so4195932bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 00:19:31 -0800 (PST)
In-Reply-To: <1258133987-20488-1-git-send-email-jwang@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jane Wang <jwang@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, broonie@opensource.wolfsonmicro.com

Hi

On Fri, 13 Nov 2009 11:39:47 -0600
Jane Wang <jwang@ti.com> wrote:

> McBSP fucntional clock is not disabled when suspend is triggerd which
> prevents PER domain entering target low-power state. To fix the problem:
> 
> 1. Disable/enable McBSP functional clock for suspend/resume.
> 
> 2. In addition, reconfigure McBSP, this is needed when systerm comes out of OFF state.
> 
...
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -440,6 +440,8 @@ static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
>  #endif
>  int omap_mcbsp_request(unsigned int id);
>  void omap_mcbsp_free(unsigned int id);
> +void omap_mcbsp_disable_fclk(unsigned int id);
> +void omap_mcbsp_enable_fclk(unsigned int id);
...
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -229,18 +229,28 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>  
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
> -	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		mcbsp_data->active++;
>  		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
>  		break;
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		mcbsp_data->active++;
> +		omap_mcbsp_enable_fclk(mcbsp_data->bus_id);
> +		omap_mcbsp_config(mcbsp_data->bus_id,
> +					&mcbsp_data->regs);
> +		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
> +		break;
>  
For me this looks more like a simple workaround for the audio case than
comprehensive implementation to McBSP OFF mode context save/restore. My
thoughts:

1. McBSP clock management partially moved out of low-level driver
2. McBSP client must do the context restore

I do know that arch/arm/plat-omap/mcbsp.c enables the clocks in
omap_mcbsp_request, I don't know do some API or feature there really
require clocks (or McBSP itself) to be active just after the request
time but I would look that path instead (even it is more complicated).

If no API or feature would require active McBSP block before the
omap_mcbsp_start call, then the clock management could be done inside
the omap_mcbsp_start/-stop functions.

Also context save/restore operations belongs more to PM callbacks
of .../plat-omap/mcbsp.c. Or probably that can be done also dynamically
inside the omap_mcbsp_start/-stop for keeping the whole McBSP shutdown
whenever it is idle.

I think it's worth to look McBSP register cache concept [1] from Janusz
Krzysztofik would it help all of this context save/restore operations.


-- 
Jarkko

1. http://www.spinics.net/lists/linux-omap/msg16720.html
