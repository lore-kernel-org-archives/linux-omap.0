From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
 constraints for streams
Date: Tue, 1 Jun 2010 09:38:07 +0300
Message-ID: <20100601093807.f4a9ec27.jhnikula@gmail.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<1275293810-31984-6-git-send-email-peter.ujfalusi@nokia.com>
	<1275300021.3174.5.camel@odin>
	<201005311457.22699.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201005311457.22699.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, ext@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, 31 May 2010 14:57:22 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> On Monday 31 May 2010 13:00:21 ext Liam Girdwood wrote:
> 
> ...
> 
> > > +static int hw_rule_bsize_by_channels(struct snd_pcm_hw_params *params,
> > > +				    struct snd_pcm_hw_rule *rule)
> > > +{
> > > +	struct snd_interval *bs = hw_param_interval(params,
> > > +					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
> > > +	struct snd_interval *c = hw_param_interval(params,
> > > +					SNDRV_PCM_HW_PARAM_CHANNELS);
> > 
> > Best to make these variable names more meaningful.
> 
> Sure, I can change that. I have picked these, since all code, which adds hw_rule 
> (and the writing an ALSA driver manual) are using variables like this.
> In Here I mean:
> bs == Buffer Size
> c == Channels
> 
Change also function names. They should start with omap_mcbsp_.

hw_rule_bsize_by_channels
hw_rule_psize_by_channels
->
omap_mcbsp_(calc_max_bufsize, rule_max_buf, or something)
omap_mcbsp_(calc_max_periodsize)


-- 
Jarkko
