From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/5] MFD: twl4030-codec: APLL_INFREQ
	handling in the MFD driver
Date: Tue, 3 Nov 2009 15:37:50 +0200
Message-ID: <200911031537.50430.peter.ujfalusi@nokia.com>
References: <1257165295-9352-1-git-send-email-peter.ujfalusi@nokia.com>
	<1257165295-9352-4-git-send-email-peter.ujfalusi@nokia.com>
	<20091102173035.GC8546@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091102173035.GC8546@rakim.wolfsonmicro.main>
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

On Monday 02 November 2009 19:30:35 ext Mark Brown wrote:
> On Mon, Nov 02, 2009 at 02:34:53PM +0200, Peter Ujfalusi wrote:
> > Move the APLL_CTL register configuration to the twl4030-codec
> > MFD driver.
> > Provide also a function for childs to query the audio_mclk
> > frequency.
> =

> This all looks good to me, some nitpicks below.
> =

> > +unsigned int twl4030_codec_get_mclk(void)
> > +{
> > +	struct twl4030_codec *codec =3D platform_get_drvdata(twl4030_codec_de=
v);
> > +
> > +	return codec->audio_mclk;
> > +}
> > +EXPORT_SYMBOL_GPL(twl4030_codec_get_mclk);
> =

> As I said in my followup to patch 5 this feels like it should have a
> parameter to specify the twl4030 though in practical systems it won't
> matter.

I agree that this does not look quite nice, but as you already mentioned, i=
t is =

highly unlikely that one system would have more than one twl series of PM c=
hip =

on board. Another reason is that we have other part of the twl, which needs =

resources from the codec part, but it is not loaded through the codec MFD, =
so =

providing the needed information is kind of tricky with that setup.

> =

> > +	if (!(pdata->audio_mclk =3D=3D 19200000 ||
> > +	      pdata->audio_mclk =3D=3D 26000000 ||
> > +	      pdata->audio_mclk =3D=3D 38400000)) {
> > +		dev_err(&pdev->dev, "Invalid audio_mclk\n");
> > +		return -EINVAL;
> > +	}
> =

> Might flow more naturally with a switch statement?

Yes, true. This looks weird, I'll change it.

> =


-- =

P=E9ter
