From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
	constraints for streams
Date: Tue, 1 Jun 2010 09:47:09 +0300
Message-ID: <201006010947.09640.peter.ujfalusi@nokia.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005311457.22699.peter.ujfalusi@nokia.com>
	<20100601093807.f4a9ec27.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100601093807.f4a9ec27.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 June 2010 09:38:07 ext Jarkko Nikula wrote:
> On Mon, 31 May 2010 14:57:22 +0300
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > On Monday 31 May 2010 13:00:21 ext Liam Girdwood wrote:
> > =

> > ...
> > =

> > > > +static int hw_rule_bsize_by_channels(struct snd_pcm_hw_params
> > > > *params, +				    struct snd_pcm_hw_rule *rule)
> > > > +{
> > > > +	struct snd_interval *bs =3D hw_param_interval(params,
> > > > +					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
> > > > +	struct snd_interval *c =3D hw_param_interval(params,
> > > > +					SNDRV_PCM_HW_PARAM_CHANNELS);
> > > =

> > > Best to make these variable names more meaningful.
> > =

> > Sure, I can change that. I have picked these, since all code, which adds
> > hw_rule (and the writing an ALSA driver manual) are using variables like
> > this. In Here I mean:
> > bs =3D=3D Buffer Size
> > c =3D=3D Channels
> =

> Change also function names. They should start with omap_mcbsp_.
> =

> hw_rule_bsize_by_channels
> hw_rule_psize_by_channels
> ->
> omap_mcbsp_(calc_max_bufsize, rule_max_buf, or something)
> omap_mcbsp_(calc_max_periodsize)

Oh yes, they should start with omap_mcbsp_
I'll change them too.

I like the following naming:
omap_mcbsp_hwrule_min_buffersize()
omap_mcbsp_hwrule_max_periodsize()

Also, I think there is no point to limit the lower period size in threshold=
 mode =

to 32, so I will remove that as well I think.

I'll wait couple of hours for comments, and resend the series.

Thanks,
P=E9ter
