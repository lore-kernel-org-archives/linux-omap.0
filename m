From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] audio:am3517evm support for AIC23
Date: Tue, 1 Mar 2011 20:37:22 +0200
Message-ID: <20110301203722.3ba044e5.jhnikula@gmail.com>
References: <1298994218-30610-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298994218-30610-1-git-send-email-abhilash.kv@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi

On Tue,  1 Mar 2011 21:13:38 +0530
Abhilash K V <abhilash.kv@ti.com> wrote:

> This patch aims to fix the registration of the AIC23-based audio
> module on the AM3517-EVM, with the following two changes:
> 
> 1. The i2c_board_info entry supporting aic23 codec was added into
>    the i2c2 bus.
> 2. The i2c client device name (".2-001a" in this case, including
>    the separator period) was appended to the codec_name member of
>    am3517evm_dai to resolve the names mismatch happening in
>    soc_bind_dai_link().
> 
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |    3 +++
>  sound/soc/omap/am3517evm.c            |    2 +-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
First, your patch does the correct things.

I investigated a bit and it looks like the sound/soc/omap/am3517evm.c
never worked in mainline since the patch below adding codec to
board-am3517evm.c wasn't applied by reason or another.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg18470.html

This means that you should split this patch into two and they can be
sent as independent patches. am3517evm.c change via alsa-devel
and board-am3517evm.c via linux-omap & linux-arm-kernel. Some comments
below.

> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index ad71cbf..8da8d20 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -358,6 +358,9 @@ static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
>  };
>  static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
>  	{
> +		I2C_BOARD_INFO("tlv320aic23", 0x1A),
> +	},
> +	{

This is ok and don't need anything else as the rest pieces from
original missing patch are added by another patches.

> --- a/sound/soc/omap/am3517evm.c
> +++ b/sound/soc/omap/am3517evm.c
> @@ -139,7 +139,7 @@ static struct snd_soc_dai_link am3517evm_dai = {
>  	.cpu_dai_name ="omap-mcbsp-dai.0",
>  	.codec_dai_name = "tlv320aic23-hifi",
>  	.platform_name = "omap-pcm-audio",
> -	.codec_name = "tlv320aic23-codec",
> +	.codec_name = "tlv320aic23-codec.2-001a",
>  	.init = am3517evm_aic23_init,
>  	.ops = &am3517evm_ops,
>  };

Subject for this part could be something like
"ASoC: AM3517: Update codec name after multi-component update".

Remember to cc ASoC maintainers Mark Brown and Liam Girdwood.

You could add my acks to splitted patches.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
