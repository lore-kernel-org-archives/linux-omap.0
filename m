From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix TDM slot rx/tx
	mask associations
Date: Mon, 9 Nov 2015 23:38:38 +0200
Message-ID: <5641125E.5030804@ti.com>
References: <1447093159-32294-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1447093159-32294-1-git-send-email-dannenberg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Reviewed-by: Jyri Sarha <jsarha@ti.com>

For what little there is to review.

I only had HW that worked with symmetric masks, so I did not hit this 
myself. Should have hacked something to codec end to be able to test 
asymetric masks at McASP end.

Thanks,
Jyri

On 11/09/15 20:19, Andreas Dannenberg wrote:
> Fixes the associations between the tx_mask and rx_mask and the associated
> playback / capture streams during setting of the TDM slot. With this
> patch in place it is now possible for example to only populate tx_mask
> (leaving rx_mask as 0) for output-only codecs to control the TDM slot(s)
> the McASP serial port uses for transmit. Before that, this scenario
> would incorrectly rely on the rx_mask for this.
>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>   sound/soc/davinci/davinci-mcasp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 4495a40..caa0beb 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -681,8 +681,8 @@ static int davinci_mcasp_set_tdm_slot(struct snd_soc_dai *dai,
>   	}
>
>   	mcasp->tdm_slots = slots;
> -	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = rx_mask;
> -	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = tx_mask;
> +	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
> +	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
>   	mcasp->slot_width = slot_width;
>
>   	return davinci_mcasp_set_ch_constraints(mcasp);
>
