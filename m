From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: Fix latency value
 calculation for pm_qos
Date: Sun, 18 Nov 2018 19:04:52 +0200
Message-ID: <d1e6e9df-3893-7c2d-acbb-05b59011a364@bitmer.com>
References: <20181114110623.30932-1-peter.ujfalusi@ti.com>
 <20181114110623.30932-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114110623.30932-2-peter.ujfalusi@ti.com>
Content-Language: en_US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, tony@atomide.com
Cc: kernel@pyra-handheld.com, hns@goldelico.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, matt@ranostay.consulting
List-Id: linux-omap@vger.kernel.org

On 11/14/18 1:06 PM, Peter Ujfalusi wrote:
> The latency number is in usec for the pm_qos. Correct the calculation to
> give us the time in usec
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/omap-mcbsp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index e0ef4774c710..a395598f1f20 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -999,9 +999,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  			pkt_size = channels;
>  		}
>  
> -		latency = ((((buffer_size - pkt_size) / channels) * 1000)
> -				 / (params->rate_num / params->rate_den));
> -
> +		latency = (buffer_size - pkt_size) / channels;
> +		latency = latency * USEC_PER_SEC /
> +			  (params->rate_num / params->rate_den);

Did I understand correctly this doesn't fix any audio issue but allows
CPU sleep longer or reach deeper sleep?

-- 
Jarkko
