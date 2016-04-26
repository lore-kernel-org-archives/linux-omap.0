From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Initialize DMA
	configuration
Date: Tue, 26 Apr 2016 16:01:56 +0300
Message-ID: <20160426130156.GA15388@bitmer.com>
References: <1461600607-19582-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1461600607-19582-1-git-send-email-Linux.HWI@garmin.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>
Cc: alsa-devel@alsa-project.org, "J.D. Schroeder" <jay.schroeder@garmin.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, peter.ujfalusi@ti.com, Jim Lodes <jim.lodes@garmin.com>, broonie@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 25, 2016 at 11:10:07AM -0500, J.D. Schroeder wrote:
> From: Jim Lodes <jim.lodes@garmin.com>
> 
> Initialize the dma_slave_config for PCM DMA transfers,
> instead of leaving it uninitialized. Keeps previous data on
> the stack from giving us invalid values in uninitialized
> members of the config structure.
> 
> Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
> ---
>  sound/soc/omap/omap-pcm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 99381a2..a84f677 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -82,6 +82,8 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
>  	struct dma_chan *chan;
>  	int err = 0;
>  
> +	memset(&config, 0x00, sizeof(config));

Based on a894bd7fb539 ("ASoC: generic-dmaengine-pcm: Clear slave_config
memory")

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
