From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap: Check regulator enable for DAC
	on Pandora
Date: Sat, 2 Mar 2013 16:02:06 +0100
Message-ID: <5132146E.602@ti.com>
References: <1362210594-17633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362210594-17633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 03/02/2013 08:49 AM, Mark Brown wrote:
> This will probably never fail but it's better style.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/omap/omap3pandora.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
> index 805512f..953483e 100644
> --- a/sound/soc/omap/omap3pandora.c
> +++ b/sound/soc/omap/omap3pandora.c
> @@ -85,7 +85,11 @@ static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
>  	 * VCC power on/off and /PD pin high/low
>  	 */
>  	if (SND_SOC_DAPM_EVENT_ON(event)) {
> -		regulator_enable(omap3pandora_dac_reg);
> +		ret = regulator_enable(omap3pandora_dac_reg);
> +		if (ret != 0) {

The rest of this machine driver uses "if (ret < 0)" or "if (ret)". I would use:
 +		if (ret) {

> +			dev_err(w->dapm.dev, "Failed to power DAC: %d\n", ret);
> +			return ret;
> +		}
>  		mdelay(1);
>  		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 1);
>  	} else {
> 

Otherwise:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
