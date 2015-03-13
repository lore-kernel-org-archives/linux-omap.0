From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH RFC (do not merge)] ASoC: davinci-mcasp:
 Set rule constraint if implicit bclk divider is used
Date: Fri, 13 Mar 2015 12:56:02 +0100
Message-ID: <5502D052.1030804@metafoo.de>
References: <1426246615-12772-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1426246615-12772-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/13/2015 12:36 PM, Jyri Sarha wrote:
[...]
> In theory this patch does exactly what it is supposed to. It only
> allows a sample-rate and sample-format combination if the rate can be
> produced with reasonable accuracy. Unfortunately the alsa-lib and
> alsa-tools are not able use this information too well. If the requested
> sample-rate and sample-format is not available the aplay/arecord
> fails, even if plughw is selected, with:
>
> pcm_params.c:170: snd1_pcm_hw_param_get_min: Assertion `!snd_interval_empty(i)' failed.
[...]
> +
> +	/*
> +	 * If we rely on implicit BCLK divider setting we should
> +	 * set constraints based on what we can provide.
> +	 */
> +	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq)
> +		return snd_pcm_hw_rule_add(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_RATE,
> +					   davinci_mcasp_hw_rule_rate,
> +					   mcasp,
> +					   SNDRV_PCM_HW_PARAM_FRAME_BITS,
> +					   SNDRV_PCM_HW_PARAM_CHANNELS, -1);
> +

For things to work correctly you also need reverse rules restricting 
CHANNELS and FRAME_BITS based on the RATE. This might fix the issue you are 
seeing with the ALSA tools.

- Lars
