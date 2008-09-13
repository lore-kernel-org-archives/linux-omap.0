From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: OMAP: Fix Gumstix Overo machine driver by using
	snd_soc_dai struct (rev 2)
Date: Fri, 12 Sep 2008 17:00:17 -0700
Message-ID: <20080913000017.GN10675@atomide.com>
References: <5e088bd90809121352h561618d0r3dbe46ecb8f7dcdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59190 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240AbYIMAA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 20:00:26 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809121352h561618d0r3dbe46ecb8f7dcdf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org

* Steve Sakoman <sakoman@gmail.com> [080912 14:04]:
> From: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> Structs snd_soc_codec_dai and snd_soc_cpu_dai are obsolete and are merged to
> snd_soc_dai by the commit 8687eb8bded8c3c5842a85bd0c30e43fc5a3e0e0.
> 

Pushing today to l-o tree.

Tony

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Acked-by: Steve Sakoman <steve@sakoman.com>
> ---
>  sound/soc/omap/overo.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
> index 542ff6b..1a086ce 100644
> --- a/sound/soc/omap/overo.c
> +++ b/sound/soc/omap/overo.c
> @@ -39,8 +39,8 @@ static int overo_hw_params(struct snd_pcm_substream
> *substream,
>  	struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
> -	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>  	int ret;
> 
>  	/* Set codec DAI configuration */
> -- 
> 1.5.6.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
