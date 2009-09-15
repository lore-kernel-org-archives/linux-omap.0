From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: TWL6030: Add twl6030 codec driver
Date: Tue, 15 Sep 2009 19:30:10 +0100
Message-ID: <20090915183009.GA4343@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E90432706@dlee04.ent.ti.com>
	<20090914172135.GA2481@rakim.wolfsonmicro.main>
	<67059DBF19D7214F9C66BB0EA91BA90E907FA65B@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E907FA65B@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 15, 2009 at 12:59:44PM -0500, Lopez Cruz, Misael wrote:
> Mark Brown wrote:
> > On Mon, Sep 14, 2009 at 12:00:25PM -0500, Lopez Cruz, Misael wrote:

> >> +/* propietary formats */
> >> +#define SND_SOC_DAIFMT_MCPDM           0x10 /* Texas Instruments
> >> McPDM */ 

> > This should really be split out into a separate patch.  Are you
> > absolutely positive that this is a proprietary interface that won't
> > interoperate with standard PDM?

> I think channel slot definition won't make it able to interoperate with
> other PDM interfaces. But I may be wrong.

I'd not expect full interoperability but I'd expect that at least the
basic PDM support would interoperate happily.  It wouldn't surprise me
if more than one manufacturer came up with the same extension for multi
channel PDM.

> >> +static void twl6030_power_up(struct snd_soc_codec *codec) +{
> >> +       struct snd_soc_device *socdev = codec->socdev;
> >> +       struct twl6030_setup_data *setup = socdev->codec_data; +
> >> +       setup->codec_enable(1);

> > That's interesting...?

> The codec is turned on/off through an external line (i.e. with a gpio).
> Then, codec enable is board-dependent.

Might it make more sense to specify a GPIO line instead, at least by
default?

> >> +static int twl6030_set_bias_level(struct snd_soc_codec *codec,
> >> +                               enum snd_soc_bias_level level) +{
> >> +       switch (level) {
> >> +       case SND_SOC_BIAS_ON:
> >> +               twl6030_power_up(codec);

> > Is there any reason not to just fold these functions into the bias
> > management?  It looks like the only caller and it'd save
> > jumping around the file to find stuff.

> For the moment, there is no reason. I thought it was more clear to have
> separate power_up/power_down functions, but I can merge them in bias
> management function.

It would be helpful since twl6030_power_up() will be called repeatedly
during normal operation as we move STANDBY <-> PREPARE <-> ON so needs
to be checked to ensure that it can safely be called repeatedly.

> >> +       /* power on device */
> >> +       twl6030_set_bias_level(codec, SND_SOC_BIAS_STANDBY); +
> >> +       twl6030_init_chip(codec);

> > Is the the right ordering?  I'd have expected to see the one time init
> > stuff done prior to bringing up the power for the first time.

> Yes, it's the right order. codec chip cannot be initialized if the codec
> is not already power-up, registers are not accesible before that.

OK.  Looking at this from another angle, shouldn't the chip init be
rolled into the bias level function to ensure that there aren't any
cases where it is omitted.

It's possible that the core may get facilities to allow more use of
SND_SOC_BIAS_OFF at runtime which would make this more important.
