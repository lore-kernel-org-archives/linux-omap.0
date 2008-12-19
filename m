From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: Re: [alsa-devel][PATCHv2 1/1] Fix a Oops bug in omap soc driver.
Date: Fri, 19 Dec 2008 16:22:54 +0200
Message-ID: <1229696574.26377.346.camel@groo.research.nokia.com>
References: <4edcd8463d981e4babef82167aa58131539c367f.1229601269.git.stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25445 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYLSOZS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 09:25:18 -0500
In-Reply-To: <4edcd8463d981e4babef82167aa58131539c367f.1229601269.git.stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Stanley.Miao" <stanley.miao@windriver.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi,

On Fri, 2008-12-19 at 22:08 +0800, ext Stanley.Miao wrote:
> There will be a Oops or frequent underrun messages when playing music with
> omap soc driver, this is because a data region is incorretly sized, other data
> region will be overwriten when writing to this data region.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  sound/soc/omap/omap-pcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index ce580a9..2adfbce 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -233,7 +233,7 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
>  	if (ret < 0)
>  		goto out;
>  
> -	prtd = kzalloc(sizeof(prtd), GFP_KERNEL);
> +	prtd = kzalloc(sizeof(struct omap_runtime_data), GFP_KERNEL);

maybe better:

prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);

[snip]

Br,
Carlos

