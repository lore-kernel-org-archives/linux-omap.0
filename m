From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] ASoC: OMAP: Fix Gumstix Overo machine driver by using
	snd_soc_dai struct
Date: Fri, 12 Sep 2008 23:46:18 +0300
Message-ID: <20080912204618.GJ7132@frodo>
References: <5e088bd90809121342i1f7f360fk6ae6123cc54556b6@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53868 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164AbYILUq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 16:46:26 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809121342i1f7f360fk6ae6123cc54556b6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org

On Fri, Sep 12, 2008 at 01:42:42PM -0700, Steve Sakoman wrote:

should this be From: Jarkko ???

> Structs snd_soc_codec_dai and snd_soc_cpu_dai are obsolete and are merged to
> snd_soc_dai by the commit 8687eb8bded8c3c5842a85bd0c30e43fc5a3e0e0.
> 
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

-- 
balbi
