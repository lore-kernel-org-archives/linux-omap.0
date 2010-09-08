From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] OMAP: McBSP: Fix static function warning
Date: Wed, 08 Sep 2010 12:14:59 +0100
Message-ID: <1283944499.3097.98.camel@odin>
References: <1283916223-23567-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1283916223-23567-1-git-send-email-manjugk@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Nishanth Menon <nm@ti.com>, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-09-08 at 08:53 +0530, G, Manjunath Kondaiah wrote:
> This patch fixes sparse warning due non declaration of static function
> 
> sound/soc/omap/omap-mcbsp.c:783:5: warning: symbol 'omap_mcbsp_st_info_volsw' was not declared. Should it be static?
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: alsa-devel@alsa-project.org
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> 
> ---
>  sound/soc/omap/omap-mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 86f2139..5768381 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -780,7 +780,7 @@ struct snd_soc_dai omap_mcbsp_dai[] = {
>  
>  EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
>  
> -int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
> +static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
>  			struct snd_ctl_elem_info *uinfo)
>  {
>  	struct soc_mixer_control *mc =

Applied.
Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
