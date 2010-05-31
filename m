From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
	constraints for streams
Date: Mon, 31 May 2010 14:57:22 +0300
Message-ID: <201005311457.22699.peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<1275293810-31984-6-git-send-email-peter.ujfalusi@nokia.com>
	<1275300021.3174.5.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1275300021.3174.5.camel@odin>
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
Cc: "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Monday 31 May 2010 13:00:21 ext Liam Girdwood wrote:

...

> > +static int hw_rule_bsize_by_channels(struct snd_pcm_hw_params *params,
> > +				    struct snd_pcm_hw_rule *rule)
> > +{
> > +	struct snd_interval *bs =3D hw_param_interval(params,
> > +					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
> > +	struct snd_interval *c =3D hw_param_interval(params,
> > +					SNDRV_PCM_HW_PARAM_CHANNELS);
> =

> Best to make these variable names more meaningful.

Sure, I can change that. I have picked these, since all code, which adds hw=
_rule =

(and the writing an ALSA driver manual) are using variables like this.
In Here I mean:
bs =3D=3D Buffer Size
c =3D=3D Channels

> =

> > +	struct omap_mcbsp_data *mcbsp_data =3D rule->private;
> > +	struct snd_interval frames;
> > +	int size;
> > +
> > +	snd_interval_any(&frames);
> > +	size =3D omap_mcbsp_get_fifo_size(mcbsp_data->bus_id);
> > +
> > +	frames.min =3D size / c->min;
> > +	frames.integer =3D 1;
> > +	return snd_interval_refine(bs, &frames);
> > +
> > +}
> > +
> > +static int hw_rule_psize_by_channels(struct snd_pcm_hw_params *params,
> > +				    struct snd_pcm_hw_rule *rule)
> > +{
> > +	struct snd_interval *ps =3D hw_param_interval(params,
> > +					SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
> > +	struct snd_interval *c =3D hw_param_interval(params,
> > +					SNDRV_PCM_HW_PARAM_CHANNELS);
> =

> ditto

Same here:
I mean:
ps =3D=3D Period Size
c =3D=3D Channels

> =

> Thanks
> =

> Liam

Never the less, I can change them, =


Thanks,
P=E9ter
