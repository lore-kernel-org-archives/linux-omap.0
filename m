From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v3 5/5] ASoC: omap-mcbsp: Place correct
	constraints for streams
Date: Tue, 1 Jun 2010 15:19:23 +0300
Message-ID: <201006011519.23249.peter.ujfalusi@nokia.com>
References: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
	<1275391104-26387-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1275391104-26387-6-git-send-email-peter.ujfalusi@nokia.com>
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

Hi,

On Tuesday 01 June 2010 14:18:24 Ujfalusi Peter (Nokia-D/Tampere) wrote:

...

> +static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params
> *params, +				    struct snd_pcm_hw_rule *rule)
> +{
> +	struct snd_interval *buffer_size =3D hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
> +	struct snd_interval *channels =3D hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_CHANNELS);
> +	struct omap_mcbsp_data *mcbsp_data =3D rule->private;
> +	struct snd_interval frames;
> +	int size;
> +
> +	snd_interval_any(&frames);
> +	size =3D omap_mcbsp_get_fifo_size(mcbsp_data->bus_id);
> +
> +	frames.min =3D size / channels->min;
> +	frames.integer =3D 1;
> +	return snd_interval_refine(buffer_size, &frames);
> +
> +}

Just noticed this extra line after the return...
Should I resend?

-- =

P=E9ter
