From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH][2.6.31-rc5] ARM: OMAP: McBSP: Fix ASoC on
	OMAP1510 by fixing API of omap_mcbsp_start/stop
Date: Fri, 7 Aug 2009 11:30:54 +0300
Message-ID: <200908071130.54337.peter.ujfalusi@nokia.com>
References: <1249628387-7372-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249628387-7372-1-git-send-email-jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday 07 August 2009 09:59:47 ext Jarkko Nikula wrote:
> Simultaneous audio playback and capture on OMAP1510 can cause that second
> stream is stalled if there is enough delay between startup of the audio
> streams.
>
> Current implementation of the omap_mcbsp_start is starting both transmitt=
er
> and receiver at the same time and it is called only for firstly started
> audio stream from the OMAP McBSP based ASoC DAI driver.
>
> Since DMA request lines on OMAP1510 are edge sensitive, the DMA request is
> missed if there is no DMA transfer set up at that time when the first word
> after McBSP startup is transmitted. The problem hasn't noted before since
> later OMAPs are using level sensitive DMA request lines.
>
> Fix the problem by changing API of omap_mcbsp_start and omap_mcbsp_stop by
> allowing to start and stop individually McBSP transmitter and receiver
> logics. Then call those functions individually for both audio playback
> and capture streams. This ensures that DMA transfer is setup before
> transmitter or receiver is started.

Looks nice, but I would have done it a bit differently...

>
> Thanks to Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> for detailed problem
> analysis and Peter Ujfalusi <peter.ujfalusi@nokia.com> for info about DMA
> request line behavior differences between the OMAP generations.
>
> Reported-and-tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    4 +-
>  arch/arm/plat-omap/mcbsp.c              |   50
> +++++++++++++++++++----------- sound/soc/omap/omap-mcbsp.c             |  =

> 10 +++---
>  3 files changed, 39 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h
> b/arch/arm/plat-omap/include/mach/mcbsp.h index bb154ea..57249bb 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -387,8 +387,8 @@ void omap_mcbsp_register_board_cfg(struct
> omap_mcbsp_platform_data *config, void omap_mcbsp_config(unsigned int id,
> const struct omap_mcbsp_reg_cfg * config); int omap_mcbsp_request(unsigned
> int id);
>  void omap_mcbsp_free(unsigned int id);
> -void omap_mcbsp_start(unsigned int id);
> -void omap_mcbsp_stop(unsigned int id);
> +void omap_mcbsp_start(unsigned int id, int tx, int rx);
> +void omap_mcbsp_stop(unsigned int id, int tx, int rx);

void omap_mcbsp_start(unsigned int id, int dir);
void omap_mcbsp_stop(unsigned int id, int dir);

>  void omap_mcbsp_xmit_word(unsigned int id, u32 word);
>  u32 omap_mcbsp_recv_word(unsigned int id);
>
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index efa0e01..a3d2313 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -328,14 +328,15 @@ void omap_mcbsp_free(unsigned int id)
>  EXPORT_SYMBOL(omap_mcbsp_free);
>
>  /*
> - * Here we start the McBSP, by enabling the sample
> - * generator, both transmitter and receivers,
> - * and the frame sync.
> + * Here we start the McBSP, by enabling transmitter, receiver or both.
> + * If no transmitter or receiver is active prior calling, then sample-ra=
te
> + * generator and frame sync are started.

 * dir =3D=3D 0: tx
 * dir =3D=3D 1: rx

>   */
> -void omap_mcbsp_start(unsigned int id)
> +void omap_mcbsp_start(unsigned int id, int tx, int rx)

void omap_mcbsp_start(unsigned int id, int dir)

>  {
>  	struct omap_mcbsp *mcbsp;
>  	void __iomem *io_base;
> +	int idle;
>  	u16 w;

...

>  	/* Enable transmitter and receiver */
>  	w =3D OMAP_MCBSP_READ(io_base, SPCR2);
> -	OMAP_MCBSP_WRITE(io_base, SPCR2, w | 1);
> +	OMAP_MCBSP_WRITE(io_base, SPCR2, w | (tx & 1));
>
>  	w =3D OMAP_MCBSP_READ(io_base, SPCR1);
> -	OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
> +	OMAP_MCBSP_WRITE(io_base, SPCR1, w | (rx & 1));

	if (dir) {
		/* RX: Enable receiver */
	  	w =3D OMAP_MCBSP_READ(io_base, SPCR1);
		OMAP_MCBSP_WRITE(io_base, SPCR1, w | 1);
	} else {
		/* TX: Enable transmitter */
	  	w =3D OMAP_MCBSP_READ(io_base, SPCR2);
		OMAP_MCBSP_WRITE(io_base, SPCR2, w | 1);
	}

>  	udelay(100);

...

> -void omap_mcbsp_stop(unsigned int id)
> +void omap_mcbsp_stop(unsigned int id, int tx, int rx)

void omap_mcbsp_stop(unsigned int id, int dir)

>  {
>  	struct omap_mcbsp *mcbsp;
>  	void __iomem *io_base;
> +	int idle;
>  	u16 w;
>
>  	if (!omap_mcbsp_check_valid_id(id)) {
> @@ -386,15 +395,20 @@ void omap_mcbsp_stop(unsigned int id)
>
>  	/* Reset transmitter */
>  	w =3D OMAP_MCBSP_READ(io_base, SPCR2);
> -	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1));
> +	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(tx & 1));
>
>  	/* Reset receiver */
>  	w =3D OMAP_MCBSP_READ(io_base, SPCR1);
> -	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~(1));
> +	OMAP_MCBSP_WRITE(io_base, SPCR1, w & ~(rx & 1));

	if (dir) {
	  	/* RX: Reset receiver */
	  	w =3D OMAP_MCBSP_READ(io_base, SPCR1);
		OMAP_MCBSP_WRITE(io_base, SPCR1, w | ~(1));
	} else {
		/* TX: Reset transmitter */
	  	w =3D OMAP_MCBSP_READ(io_base, SPCR2);
		OMAP_MCBSP_WRITE(io_base, SPCR2, w | ~(1));
	}


> -	/* Reset the sample rate generator */
> -	w =3D OMAP_MCBSP_READ(io_base, SPCR2);
> -	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
> +	idle =3D !((OMAP_MCBSP_READ(io_base, SPCR2) |
> +		  OMAP_MCBSP_READ(io_base, SPCR1)) & 1);
> +
> +	if (idle) {
> +		/* Reset the sample rate generator */
> +		w =3D OMAP_MCBSP_READ(io_base, SPCR2);
> +		OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
> +	}
>  }
>  EXPORT_SYMBOL(omap_mcbsp_stop);
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index a5d46a7..6a837ff 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -183,21 +183,21 @@ static int omap_mcbsp_dai_trigger(struct
> snd_pcm_substream *substream, int cmd, struct snd_soc_pcm_runtime *rtd =
=3D
> substream->private_data;
>  	struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
>  	struct omap_mcbsp_data *mcbsp_data =3D to_mcbsp(cpu_dai->private_data);
> -	int err =3D 0;
> +	int err =3D 0, play =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAY=
BACK);

no need for this change.

>
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		if (!mcbsp_data->active++)
> -			omap_mcbsp_start(mcbsp_data->bus_id);
> +		mcbsp_data->active++;
> +		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);

		omap_mcbsp_start(mcbsp_data->bus_id, substream->stream);

>  		break;
>
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		if (!--mcbsp_data->active)
> -			omap_mcbsp_stop(mcbsp_data->bus_id);
> +		omap_mcbsp_stop(mcbsp_data->bus_id, play, !play);

		omap_mcbsp_stop(mcbsp_data->bus_id, substream->stream);


> +		mcbsp_data->active--;
>  		break;
>  	default:
>  		err =3D -EINVAL;

-- =

P=E9ter
