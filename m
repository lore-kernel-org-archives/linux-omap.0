From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 08:57:27 +0300
Message-ID: <200905270857.28125.peter.ujfalusi@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A1BEBE3.8010306@tis.icnet.pl>
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
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 May 2009 16:17:23 ext Janusz Krzysztofik wrote:
> Hi,
>
> I am trying to add sound support for ams-delta omap machine, yet without
> much success.
>
> Three years ago, Mark Underwood created an omap-alsa compatible driver
> that basically worked[1]. It was derieved from similiar driver for aic23
> codec found on omap osk machine. It looks like Mark has never managed to
> finish his work. It's not clear for me if he has found that getting a
> working fullduplex sound is technically impossible on a voice modem
> codec, shared among modem and cpu, controlable only from modem side
> afaik, but I have decided to give it a try.
>
> Since Mark's initial work, omap-alsa framework has been depreciated in
> favour of soc-omap. API changes are so significant that Mark's code is
> rather not useable directly any more. However, I am trying to use it as
> a starting point, by comparing it against it's prototype osk/aic23 code.
>
> Following Mark, I am trying to derieve the new ams-delta sound driver
> from current asoc driver for omap osk9512. For codec part, I decided to
> base my work on much more simple ad73311 rather that tlv320aic23.
>
> Comparing Mark's code agaist it's osk/aic23 prototype, I can see the
> folowing significant changes:
> 1. rate tables/bitmaps found in hw_constraint_rates,
> snd_omap_alsa_playback and snd_omap_alsa_capture structures limited to
> 8kHz, 2. hardware related code found in codec_configure_dev(),
> codec_clock_on() and codec_clock_off() callback functions replaced with
> ams-delta hardware specific code that switches the codec DAI pins from
> modem chip to mcbsp cpu interface and back,
> 3. codec_set_samplerate() and all mixer related functions replaced with
> stubs.
> 4. the following McBSP register settings changes:
>
> -	.xcr2 =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
> -	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
> +	.xcr2 =3D XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
>
> -	.srgr1 =3D FWID(DEFAULT_BITPERSAMPLE - 1),
> +	.srgr1 =3D CLKGDV(0),
>
> -	.srgr2 =3D GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
> +       .srgr2 =3D GSYNC,
>
> -	.pcr0 =3D CLKXP | CLKRP,  /* mcbsp: slave */

Since I don't have the original osk/aic23 thing, this does not mean to much=
...
Just a bit confusing. The configuration suggest slave McBSP with NB_IF =

polarity, dual phase format, 16 bit words, 16*2 long frames, the FS pulse i=
s =

probably a pulse... Suggesting kind of DSP mode, but with not so correct =

configuration, which happens to be working.

>
> I have found points 1. to 3. rather trivial to implement in new
> framework. Regarding point 4., it looks like detailed register settings
> are now done inside omap-mcbsp.c, based on machine specified format, so
> I have to find out what format should be specified for ams-delta. Please
> correct me if I am missing something.

Yes, that is correct. What you need for the point 4:
Interface format of the cx20442 codec (I2S, DSP_A, DSP_B, etc)
Clock polarities.
Does the codec provides the clocks (bit, frame sync) - codec master or slave

When you know these the soc/omap/arms-delta.c can configure the CPU dai wit=
h:
snd_soc_dai_set_fmt(cpu_dai, ...


>
> There was one more modification in Mark's code, addressing dma chaining
> problem on omap15xx hardware, but as far as I could see, the problem was
> already solved in the asoc omap framework.
>
> Initially, I based my work on ompenembedded provided linux-omap.git
> revision 90e758af52ba803cba233fabee81176d99589f09. The results were
> rather poor - total system hangup after first device access, with no
> single message. So I have switched to linux-2.6.30-rc5 and now I can
> safely access the device, however it does not work as expected. aplay
> and arecord wait forever, cat to/from /dev/dsp breaks with hardware
> error messgae.
> DMA interrput counters stay at 0.

This means that the McBSP module is not transmitting/receiving any data.
Which suggests that the clocking is not working in your setup. Check the sl=
ave =

master mode for the codec.
Also worth checking the PIN configuration for the McBSP1 module, just in ca=
se =

it is correct.

> However, codec
> switching that I do from machine->ops->startup/shutdown seems working,
> as modem stops producing any sounds while the alsa device is in use and
> gets back thereafter.
>
> First of all, I'd like to make sure if my problem is related to my code
> only. As I am new in these areas, I would like to ask you if the omap
> asoc framework is stable enough to relay on.

I believe that it is stable enough.

> If yes, could you please
> look at my dirty code (attached) an give me some hints? I can provide
> you with more information if necessary.

Given that it is still early morning, I could not find anything that would =

prevent it to be somehow working...

>
> Regards,
> Janusz

-- =

P=E9ter
