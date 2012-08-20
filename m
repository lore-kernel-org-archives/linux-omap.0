From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 4/9] sound/soc/omap/am3517evm.c: fix error return code
Date: Mon, 20 Aug 2012 09:09:35 +0300
Message-ID: <5031D49F.7050301@bitmer.com>
References: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr> <1345359780-18647-10-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46131 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab2HTGJp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 02:09:45 -0400
In-Reply-To: <1345359780-18647-10-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

On 08/19/2012 10:03 AM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> It was forgotten to initialize ret to the result of calling
> snd_soc_dai_set_sysclk, unlike at the other calls in the same function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/soc/omap/am3517evm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
> index 009533a..df65f98 100644
> --- a/sound/soc/omap/am3517evm.c
> +++ b/sound/soc/omap/am3517evm.c
> @@ -59,7 +59,7 @@ static int am3517evm_hw_params(struct snd_pcm_substream *substream,
>  		return ret;
>  	}
>  
> -	snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
>  				SND_SOC_CLOCK_IN);
>  	if (ret < 0) {
>  		printk(KERN_ERR "can't set CPU system clock OMAP_MCBSP_FSR_SRC_FSX\n");
> 

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
