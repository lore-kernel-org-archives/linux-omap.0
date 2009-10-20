From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: TWL4030: Driver registration via
	twl4030_codec MFD
Date: Tue, 20 Oct 2009 14:30:49 +0300
Message-ID: <200910201430.49223.peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-5-git-send-email-peter.ujfalusi@nokia.com>
	<20091020102540.GB28592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091020102540.GB28592@opensource.wolfsonmicro.com>
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
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 October 2009 13:25:40 ext Mark Brown wrote:
> On Mon, Oct 19, 2009 at 03:42:20PM +0300, Peter Ujfalusi wrote:
> > TWL4030 codec is now using the device registration via
> > tlw4030_codec MFD device.
> =

> This looks pretty good but obviously depends on the MFD changes.

Thanks, yes it all depends on the MFD changes.

> The major thing that jumps out at me is the removal of the register
> definitions from the ASoC headers - it might be nice to have that done
> as part of the MFD patch, or as a separate patch.

The reason why I have done it like this is that with one patch I only touch=
 one =

subsystem at the time:
1. MFD changes only
2. OMAP related changes
3. soc codec driver change

In patch 1, the register definitions had to be added, so that the twl4030_c=
odec =

driver knows the registers (and there could be the vibra driver placed =

separately from the soc codec driver).
In patch 3, where I modify the soc codec driver to use the new method, than=
 I =

remove the definitions and use the existing header file, introduced by the =
first =

patch.
All in all, after each patch the kernel can be builds, boots and works as =

before.

> =

> You've also got the bias being brought up when the ASoC system comes up
> rather than when the driver comes up.  To be honest it doesn't really
> make any difference either way, it's just slightly different to other
> drivers.

I was thinking that if you built the kernel with SND_SOC_ALL_CODECS on OMAP =

platform for some reason and you don't actually use the twl4030 as audio de=
vice =

-> no machine driver, which would use it, than the codec part would be off.
But yes, probably I can move the povering up to the probe function.

> What is useful with things like twl4030 which take a little
> while to come up is if you can do the bias bringup out of line from
> device probe, avoiding blocking system startup on CODEC bringup.  That's
> definitely a separate patch, I'm just mentioning it for interest here.

I'm sure there will be another round for this series, so I can make this ch=
ange =

at the same time within the patch, since this anyway changes the way how th=
e =

driver is loaded/probed.

> =

> There's also a couple of debug prints (like in the remove function) and

I'll get rid of them.
But at least this time I did not had those unneeded casts, which I usually =
have =

;)

> =

> > +MODULE_ALIAS("platform:twl4030_codec:audio");
> =

> Is that second colon right given...

I'm not sure about it at all either. I did not found any other 'nested MFD' =

drivers around, so this is just a guess
Should it be:

 +MODULE_ALIAS("platform:twl4030_codec_audio");


> =

> > +	.driver		=3D {
> > +		.name	=3D "twl4030_codec_audio",
> > +		.owner	=3D THIS_MODULE,
> =

> this.
> =


-- =

P=E9ter
