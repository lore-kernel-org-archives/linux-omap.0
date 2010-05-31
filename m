From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
	constraints for streams
Date: Mon, 31 May 2010 11:41:12 +0300
Message-ID: <201005311141.12947.peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<1275293810-31984-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1275293810-31984-6-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Monday 31 May 2010 11:16:50 Ujfalusi Peter (Nokia-D/Tampere) wrote:
...

> @@ -185,33 +231,43 @@ static int omap_mcbsp_dai_startup(struct
> snd_pcm_substream *substream, if (!cpu_dai->active)
>  		err =3D omap_mcbsp_request(bus_id);
> =

> +	/*
> +	 * OMAP McBSP FIFO is word structured.
> +	 * McBSP2 has 1024 + 256 =3D 1280 word long buffer,
> +	 * McBSP1,3,4,5 has 128 word long buffer
> +	 * This means that the size of the FIFO depends on the sample format.
> +	 * For example on McBSP3:
> +	 * 16bit samples: size is 128 * 2 =3D 256 bytes
> +	 * 32bit samples: size is 128 * 4 =3D 512 bytes
> +	 * It is simpler to place constraint for buffer and period based on
> +	 * channels.
> +	 * McBSP3 as example again (16 or 32 bit samples):
> +	 * 1 channel (mono): size is 128 frames (128 words)
> +	 * 2 channels (stereo): size is 128 / 2 =3D 64 frames (2 * 64 words)
> +	 * 4 channels: size is 128 / 4 =3D 32 frames (4 * 32 words)
> +	 */
> +
> +	/*
> +	 * The first rule is for the buffer size, we should not allow smaller
> +	 * buffer than the FIFO size to avoid underruns
> +	 */
> +	snd_pcm_hw_rule_add(substream->runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +				    hw_rule_bsize_by_channels, mcbsp_data,
> +				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
> +

Obviously this hw_rule must be moved after checking the CPU type, since it =
is =

only valid for OMAP3 class of devices.
I'll fix this in the v2 series.
I have been testing this on OMAP3...

>  	if (cpu_is_omap343x()) {
>  		int dma_op_mode =3D omap_mcbsp_get_dma_op_mode(bus_id);
> -		int max_period;
> =

>  		/*
> -		 * McBSP2 in OMAP3 has 1024 * 32-bit internal audio buffer.
> -		 * Set constraint for minimum buffer size to the same than FIFO
> -		 * size in order to avoid underruns in playback startup because
> -		 * HW is keeping the DMA request active until FIFO is filled.
> +		 * In case os threshold mode, the rule will ensure, that the
> +		 * period size is not bigger than the maximum allowed threshold
> +		 * value.
>  		 */
> -		if (bus_id =3D=3D 1)
> -			snd_pcm_hw_constraint_minmax(substream->runtime,
> -					SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
> -					4096, UINT_MAX);
> -
> -		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> -			max_period =3D omap_mcbsp_get_max_tx_threshold(bus_id);
> -		else
> -			max_period =3D omap_mcbsp_get_max_rx_threshold(bus_id);
> -
> -		max_period++;
> -		max_period <<=3D 1;
> -
>  		if (dma_op_mode =3D=3D MCBSP_DMA_MODE_THRESHOLD)
> -			snd_pcm_hw_constraint_minmax(substream->runtime,
> -						SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
> -						32, max_period);
> +			snd_pcm_hw_rule_add(substream->runtime, 0,
> +					SNDRV_PCM_HW_PARAM_CHANNELS,
> +					hw_rule_psize_by_channels, substream,
> +					SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
>  	}
> =

>  	return err;

-- =

P=E9ter
