From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: OMAP: reconfigure DMA to resume audio
Date: Sat, 14 Nov 2009 10:36:28 +0200
Message-ID: <20091114103628.51476f3d.jhnikula@gmail.com>
References: <1258135323-20523-1-git-send-email-jwang@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:42446 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZKNIfa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Nov 2009 03:35:30 -0500
Received: by fxm21 with SMTP id 21so1240831fxm.21
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 00:35:35 -0800 (PST)
In-Reply-To: <1258135323-20523-1-git-send-email-jwang@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jane Wang <jwang@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, broonie@opensource.wolfsonmicro.com

Hi

On Fri, 13 Nov 2009 12:02:03 -0600
Jane Wang <jwang@ti.com> wrote:

> Reconfigure DMA transfer parameters to resume audio after system comming out of OFF state.
> 
> Signed-off-by: Jane Wang <jwang@ti.com>
> ---
>  sound/soc/omap/omap-pcm.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 6a829ee..5e04390 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -215,8 +215,13 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  
>  	spin_lock_irqsave(&prtd->lock, flags);
>  	switch (cmd) {
> -	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
> +		/* Reconfigure DMA transfer parameters
> +		 * in order to come back from OFF mode
> +		 */
> +		omap_pcm_prepare(substream);
> +		/* fall through */

Again looks simple workaround for the audio case for restoring the
DMA context but how about all other DMA clients if the low-level DMA
module expects that the clients must do the context restore?

I'm not the PM expert but I think only need for PM in omap-pcm.c or
omap-mcbsp.c would be to dealing with possible suspend/resume order not
to bring up the low-level module back alive.


-- 
Jarkko
