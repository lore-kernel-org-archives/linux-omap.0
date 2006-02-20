From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 1/7
Date: Mon, 20 Feb 2006 14:11:15 -0800 (PST)
Message-ID: <20060220221115.23684.qmail@web32908.mail.mud.yahoo.com>
References: <9268368b0602200944g1d20823cl3b0c2d2cbe95ee29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602200944g1d20823cl3b0c2d2cbe95ee29@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Daniel, 

> @@ -0,0 +1,714 @@
> +/*
> + * sound/arm/omap-alsa.c
> + * 
> + * Alsa Driver for AIC23 codec on OSK5912 platform board

Now *not* just for AIC23. Time to update this line.

> + *
> + * History:
> + *
> + * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk.
> Creation of new 
> + *                                 file omap-aic23.c
> + * 
> + * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix
> as proposed by Ajaya Babu
> + *
> + * 2006-02-07   Daniel Petrini  - Codec specific function separated.
> File renamed to
> + *                                omap-alsa.c
> + * 2006-02-10	Mika Laitio	- Codec specific function pointers are set
> in the codec.
> + * 				  Default samplerate queried from the codec.
> + */

I am happy to see this big development and cleaned up driver interface,
but I think we can trim down this History as I believe GIT is being
really used for this purpose. Only thing we need to take care is give
better comment at patch submit time :)

> +MODULE_ALIAS("omap_alsa_mcbsp.1");

Do we really need to add "_mcbsp" in that string? It looks confusing
while reading. 

> +#define DMA_BUF_SIZE	1024 * 8
> +

Brackets around 1024 * 8 would be better.

> +static int audio_dma_request(struct audio_stream *s,
> +			     void (*callback) (void *))
> +{
> +	int err;
> +	ADEBUG();
> +
> +	err = omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);
> +	if (err < 0)
> +		printk(KERN_ERR "unable to grab audio dma 0x%x\n",
> +		       s->dma_dev);

s/unable/Unable will look good :)

> +
> +/*
> + *  This function should calculate the current position of the dma
> in the
> + *  buffer. It will help alsa middle layer to continue update the
> buffer.
> + *  Its correctness is crucial for good functioning.
> + */
> +static u_int audio_get_dma_pos(struct audio_stream *s)
> +{
> +	snd_pcm_substream_t *substream = s->stream;
> +	snd_pcm_runtime_t *runtime = substream->runtime;
> +	unsigned int offset;
> +	unsigned long flags;
> +	dma_addr_t count;
> +	ADEBUG();
> +
> +	/* this must be called w/ interrupts locked as requested in dma.c
> */
> +	spin_lock_irqsave(&s->dma_lock, flags);
> +
> +	/* For the current period let's see where we are */
> +	count = omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
> +
> +	spin_unlock_irqrestore(&s->dma_lock, flags);
> +
> +	/* Now, the position related to the end of that period */
> +	offset = bytes_to_frames(runtime, s->offset) -
> bytes_to_frames(runtime, count);
> +
> +	if (offset >= runtime->buffer_size || offset < 0)
> +		offset = 0;

I am not sure but will this "unsigned int offset" will be ever become <
0 here ? 

> +
> +/* 
> + *  This is called when dma IRQ occurs at the end of each transmited
> block
> + */
> +void audio_dma_callback(void *data)
> +{
> +	struct audio_stream *s = data;
> +	ADEBUG();
> +
> +	/* 
> +	 * If we are getting a callback for an active stream then we inform
> +	 * the PCM middle layer we've finished a period
> +	 */
> +	if (s->active)
> +		snd_pcm_period_elapsed(s->stream);
> +
> +	spin_lock(&s->dma_lock);
> +	if (s->periods > 0) {
> +		s->periods--;
> +	}

{} not need around if.

> +
> +/* 
> + * Alsa section
> + * PCM settings and callbacks
> + */
> +
> +static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream,
> int cmd)

Extra empty line after function comments. Same review comment applies
to all other places in the file. You may like to remove that. 

> +
> +static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
> +{
> +	struct snd_card_omap_codec *chip =
> +	    snd_pcm_substream_chip(substream);
> +	snd_pcm_runtime_t *runtime = substream->runtime;
> +	int stream_id = substream->pstr->stream;
> +	int err;
> +	
> +	ADEBUG();
> +	chip->s[stream_id].stream = substream;
> +	alsa_codec_config->codec_clock_on();
> +	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
> +		runtime->hw = snd_omap_alsa_playback;
> +	}

{} not needed after if and else below.

> +	else {
> +		runtime->hw = snd_omap_alsa_capture;
> +	}
> +	if ((err = snd_pcm_hw_constraint_integer(runtime,
> +					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
> +		return err;
> +	}
> +	if ((err = snd_pcm_hw_constraint_list(runtime, 0,
> +					SNDRV_PCM_HW_PARAM_RATE,
> +					&hw_constraints_rates)) < 0) {
> +		return err;
> +	}

Ditto. Also adding one empty line between ifs will look better.

> +
> +	/* sets up initial buffer with continuous allocation */
> +	snd_pcm_lib_preallocate_pages_for_all(pcm,
> +					      SNDRV_DMA_TYPE_CONTINUOUS,
> +					      snd_dma_continuous_data
> +					      (GFP_KERNEL),
> +					      128 * 1024, 128 * 1024);

Brackets around GFP_KERNEL may not be needed.

> +
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
> +			&snd_card_omap_alsa_playback_ops);
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
> +			&snd_card_omap_alsa_capture_ops);
> +	pcm->private_data = omap_alsa;
> +	pcm->info_flags = 0;
> +	strcpy(pcm->name, "omap aic23 pcm");

aic23? 

> +
> +
> +#ifdef CONFIG_PM
> +
> +static int snd_omap_alsa_suspend(snd_card_t * card, pm_message_t
> state)

Empty line after CONFIG_PM may not be needed.

> +
> +#else
> +#define snd_omap_alsa_suspend	NULL
> +#define snd_omap_alsa_resume	NULL
> +#define omap_alsa_suspend	NULL
> +#define omap_alsa_resume	NULL
> +
> +#endif	/* CONFIG_PM */

May be snd_omap_alsa_suspend(x) do {} while(0) style would be better.

> +
> +/* 
> + */
> +void snd_omap_alsa_free(snd_card_t * card)
> +{
> +	struct snd_card_omap_codec *chip = card->private_data;
> +	ADEBUG();
> +	
> +	/*
> +	 * Turn off codec after it is done.
> +	 * Can't do it immediately, since it may still have
> +	 * buffered data.
> +	 */
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	schedule_timeout(2);

We have now API to combine this two functions. There one long name if I
remember.

> +	
> +	if (alsa_codec_config && alsa_codec_config->codec_configure_dev) {
> +		alsa_codec_config->codec_configure_dev();
> +	}

As mentioned earlier...{} not needed, also few more in code below.

> +
> +static int snd_omap_alsa_remove(struct platform_device *pdev)
> +{
> +	snd_card_t *card = platform_get_drvdata(pdev);
> +	struct snd_card_omap_codec *chip = card->private_data;
> +	
> +	snd_card_free(card);
> +
> +	alsa_codec = NULL;
> +	card->private_data = NULL;
> +	kfree(chip);
> +	
> +	platform_set_drvdata(pdev, NULL);
> +	
> +	return 0;
> +	
> +}

Extra empty lines after return 0.

> +
> +static struct platform_driver omap_alsa_driver = {
> +	.probe =	snd_omap_alsa_probe,
> +	.remove =	snd_omap_alsa_remove,
> +	.suspend =	omap_alsa_suspend, 
> +	.resume =	omap_alsa_resume, 

May be keeping consistent naming will be good for suspend and resume.

> +
> +/*
> + * Alsa card structure for aic23
> + */

aic23? 

> +
> +/*
> + * Defines codec specific functions pointers that can be used from
> the 
> + * common omap-alse base driver for all omap codecs. (tsc2101 and
> aic23)
> + */
> +void define_codec_functions(struct omap_alsa_codec_config
> *codec_config);
> +inline void aic23_configure(void);
> +void aic23_set_samplerate(long rate);
> +void aic23_clock_setup(void);
> +int aic23_clock_on(void);
> +int aic23_clock_off(void);
> +int aic23_get_default_samplerate(void);
> +
> +inline void tsc2101_configure(void);
> +void tsc2101_set_samplerate(long rate);
> +void tsc2101_clock_setup(void);
> +int tsc2101_clock_on(void);
> +int tsc2101_clock_off(void);
> +int tsc2101_get_default_samplerate(void);

I think above functions should not be mentioned in omap-alsa.h, as it
meant to be independant of any codec information. You may want to put
them in specific codec header files, anyway they are going to called
through function pointers I believe.


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
