From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH] ASoC: OMAP3EVM: Use the twl4030_setup_data for headset
 pop-removal
Date: Thu, 29 Oct 2009 13:30:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A5B3835@dbde02.ent.ti.com>
References: <1253689831-2996-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56486 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZJ2IAq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 04:00:46 -0400
In-Reply-To: <1253689831-2996-1-git-send-email-anuj.aggarwal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I rebased my both audio and l-o trees but could not find this patch
there. Is there a problem in this which I have to fix and re-submit?

Regards,
Anuj Aggarwal


> -----Original Message-----
> From: Aggarwal, Anuj
> Sent: Wednesday, September 23, 2009 12:41 PM
> To: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
> Cc: Aggarwal, Anuj
> Subject: [PATCH] ASoC: OMAP3EVM: Use the twl4030_setup_data for headset
> pop-removal
> 
> The pop-removal specific values are configured for TWL4030 codec
> for OMAP3EVM through this patch.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  sound/soc/omap/omap3evm.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
> index 9114c26..8deb59b 100644
> --- a/sound/soc/omap/omap3evm.c
> +++ b/sound/soc/omap/omap3evm.c
> @@ -93,10 +93,17 @@ static struct snd_soc_card snd_soc_omap3evm = {
>  	.num_links = 1,
>  };
> 
> +/* twl4030 setup */
> +static struct twl4030_setup_data twl4030_setup = {
> +	.ramp_delay_value = 4,
> +	.sysclk = 26000,
> +};
> +
>  /* Audio subsystem */
>  static struct snd_soc_device omap3evm_snd_devdata = {
>  	.card = &snd_soc_omap3evm,
>  	.codec_dev = &soc_codec_dev_twl4030,
> +	.codec_data = &twl4030_setup,
>  };
> 
>  static struct platform_device *omap3evm_snd_device;
> --
> 1.6.2.4

