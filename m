From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ASoC: Fix the power update function for
	snd_soc_dapm_value_mux
Date: Fri, 16 Jan 2009 09:51:39 +0200
Message-ID: <20090116075138.GR4128@atomide.com>
References: <1232092086-30074-1-git-send-email-peter.ujfalusi@nokia.com> <1232092086-30074-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56377 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988AbZAPHvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:51:38 -0500
Content-Disposition: inline
In-Reply-To: <1232092086-30074-2-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [090116 09:49]:
> Modify the check for the mux type to also handle the
> snd_soc_dapm_value_mux type in a same way as the snd_soc_dapm_mux.

Thanks, pushed to l-o tree to wait for it to fall down from mainline.

Tony


> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/soc-dapm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 493a4e8..a2f1da8 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -720,7 +720,8 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
>  	struct snd_soc_dapm_path *path;
>  	int found = 0;
>  
> -	if (widget->id != snd_soc_dapm_mux)
> +	if (widget->id != snd_soc_dapm_mux &&
> +	    widget->id != snd_soc_dapm_value_mux)
>  		return -ENODEV;
>  
>  	if (!snd_soc_test_bits(widget->codec, e->reg, mask, val))
> -- 
> 1.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
