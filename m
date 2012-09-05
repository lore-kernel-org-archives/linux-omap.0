From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] Don't clobber access methods when !regmap
Date: Wed, 05 Sep 2012 18:36:57 +0200
Message-ID: <50477FA9.8060905@metafoo.de>
References: <1346939132-20187-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346939132-20187-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/06/2012 03:45 PM, Pantelis Antoniou wrote:
> A snd-soc driver that doesn't support regmap blow up horribly
> when you assume that regmap is available. Fix it by marking
> the driver as not supporting regmap & not clobbering the codec
> access methods.
> 
> This is immediately noticeable on the beagleboard where we crash,
> since we might have REGMAP enabled, but it doesn't mean that the
> omap driver uses it.
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>

But calling snd_soc_codec_set_cache_io sort of implies that you are using
regmap. If you are not using regmap your codec should not call
snd_soc_codec_set_cache_io.

- Lars

> 
> ---
>  sound/soc/soc-io.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
> index 29183ef..4e5b4ae 100644
> --- a/sound/soc/soc-io.c
> +++ b/sound/soc/soc-io.c
> @@ -117,9 +117,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
>  	int ret;
>  
>  	memset(&config, 0, sizeof(config));
> -	codec->write = hw_write;
> -	codec->read = hw_read;
> -	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
>  
>  	config.reg_bits = addr_bits;
>  	config.val_bits = data_bits;
> @@ -151,7 +148,9 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
>  			 * multiples */
>  			if (ret > 0)
>  				codec->val_bytes = ret;
> -		}
> +		} else
> +			codec->using_regmap = false;
> +
>  		break;
>  
>  	default:
> @@ -161,6 +160,13 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
>  	if (IS_ERR(codec->control_data))
>  		return PTR_ERR(codec->control_data);
>  
> +	/* only when using regmap; don't modify unconditionally */
> +	if (codec->using_regmap) {
> +		codec->write = hw_write;
> +		codec->read = hw_read;
> +		codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
