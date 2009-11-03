From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/5] ASoC: TWL4030: Do not modify the
	APLL_CTL register
Date: Tue, 3 Nov 2009 16:05:34 +0200
Message-ID: <200911031605.34378.peter.ujfalusi@nokia.com>
References: <1257165295-9352-1-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-6-git-send-email-peter.ujfalusi@nokia.com>
	<20091102172720.GA8546@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091102172720.GA8546@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Monday 02 November 2009 19:27:20 ext Mark Brown wrote:
> On Mon, Nov 02, 2009 at 02:34:55PM +0200, Peter Ujfalusi wrote:
> > APLL_CTL register is configured by the twl4030-codec MFD
> > driver.
> > Remove code, which makes changes in the APLL_CTL register,
> > and replace those with checks against the configured
> > audio_mclk configuration done in the MFD driver.
> =

> This all looks mostly OK.  It might be nice to combine this patch with
> the change to the MFD driver, simply because when the previous patch
> said "move" but didn't remove anything from the CODEC driver it seemed a
> bit surprising.  The MFD part of this is queued in ASoC ATM so it
> shouldn't cause cross tree issues.

I just wanted to keep patches for different subsystems separate, but I can =

either merge those two, or change the commit message in patch 3, that it wi=
ll be =

not misleading. =


> =

> > -	twl4030_write(codec, TWL4030_REG_APLL_CTL, apll_ctrl);
> > +	if ((freq / 1000) !=3D twl4030->sysclk) {
> > +		dev_err(codec->dev,
> > +			"Mismatch in APLL infrequency %u (configred: %u)\n",
> > +			freq, twl4030->sysclk * 1000);
> =

> Typos in the log message here (and similarly for the other DAI).

Will fix those.

> =

> > -	if (infreq !=3D TWL4030_APLL_INFREQ_26000KHZ) {
> > +	if (twl4030->sysclk !=3D 26000) {
> >  		printk(KERN_ERR "TWL4030 voice startup: "
> >  			"MCLK is not 26MHz, call set_sysclk() on init\n");
> >  		return -EINVAL;
> =

> Is that advice still appropriate if things are specified via the
> codec device now?

Correct, it is not correct.

> =

> > @@ -2233,6 +2215,7 @@ static int __devinit twl4030_codec_probe(struct
> > platform_device *pdev) twl4030_codec =3D codec;
> >
> >  	/* Set the defaults, and power up the codec */
> > +	twl4030->sysclk =3D twl4030_codec_get_mclk() / 1000;
> >  	twl4030_init_chip(codec);
> >  	codec->bias_level =3D SND_SOC_BIAS_OFF;
> >  	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> =

> twl4030_codec_get_mclk() feels like it ought to take a parameter saying
> which twl4030, though the chances of having multiple twl4030s in one
> system are remote so it's not a real issue.

We have discussed this, but, yes the chances of having more than one twl in=
 a =

system is unlikely.



-- =

P=E9ter
