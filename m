From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Update EAC codec port mode in
	board-n800-audio.c
Date: Thu, 26 Apr 2007 18:08:24 +0000
Message-ID: <20070426180823.GE9764@atomide.com>
References: <20070404141313.c4eab06d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070404141313.c4eab06d.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [070404 11:14]:
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/mach-omap2/board-n800-audio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-omap2/board-n800-audio.c
> index fa6ab86..f44aeb4 100644
> --- a/arch/arm/mach-omap2/board-n800-audio.c
> +++ b/arch/arm/mach-omap2/board-n800-audio.c
> @@ -127,7 +127,7 @@ static int n800_audio_register_controls(void *pdata, struct snd_card *card)
>  
>  static struct eac_codec n800_eac_codec = {
>  	.mclk_src = EAC_MCLK_EXT_2x12288000,
> -	.codec_mode = EAC_CODEC_I2S,
> +	.codec_mode = EAC_CODEC_I2S_MASTER,
>  	.codec_conf.i2s.polarity_changed_mode = 0,
>  	.codec_conf.i2s.sync_delay_enable = 0,
>  	.default_rate = 48000,
> -- 

Pushing today.

Tony
