From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: OMAP: reconfigure DMA to resume
	audio
Date: Fri, 13 Nov 2009 13:50:42 +0000
Message-ID: <20091113135042.GE21516@rakim.wolfsonmicro.main>
References: <1258056918-19769-1-git-send-email-jwang@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1258056918-19769-1-git-send-email-jwang@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jane Wang <jwang@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 12, 2009 at 02:15:18PM -0600, Jane Wang wrote:
> Reconfigure DMA transfer parameters to resume audio after system comming out of OFF state.

> Signed-off-by: Jane Wang <jwang@ti.com>

This looks OK to me but I'd like an ack from the OMAP folks.  Adding
Jarkko as well as he's the maintainer for OMAP audio.

> ---
>  sound/soc/omap/omap-pcm.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 6a829ee..5e04390 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -215,8 +215,13 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  
>  	spin_lock_irqsave(&prtd->lock, flags);
>  	switch (cmd) {
> -	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
> +		/* Reconfigure DMA transfer parameters
> +		 * in order to come back from OFF mode
> +		 */
> +		omap_pcm_prepare(substream);
> +		/* fall through */
> +	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		prtd->period_index = 0;
>  		/* Configure McBSP internal buffer usage */
> -- 
> 1.5.4.3
> 
