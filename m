From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage
 of regulator framework to control avdd_dac
Date: Thu, 8 Oct 2009 16:17:07 +0300
Message-ID: <20091008131707.GA9558@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com>
	<1255004227.30157.159.camel@eenurkka-desktop>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255004227.30157.159.camel@eenurkka-desktop>
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
Cc: ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 08, 2009 at 02:17:07PM +0200, Nurkkala Eero.An (EXT-Offcode/Oulu) wrote:
> On Thu, 2009-10-08 at 13:58 +0200, Valentin Eduardo (Nokia-D/Helsinki)
> wrote:
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > 
> > This patch adds initial usage of regulator framework to control avdd_dac
> > inside tlv320aic3x ASoC codec driver.
> > 
> > The  refcount to avdd_dac is increased / decreased
> > only during probe and remove. Here it is still needed to implement
> > proper enable/disable regulator depending on chip usage. Now if driver
> > can get regulator for avdd_dac, then it will just let it on on probe
> > and then leave it off on remove.
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  sound/soc/codecs/tlv320aic3x.c |   26 ++++++++++++++++++++++++++
> >  1 files changed, 26 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> > index 3395cf9..82e0a64 100644
> > --- a/sound/soc/codecs/tlv320aic3x.c
> > +++ b/sound/soc/codecs/tlv320aic3x.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/pm.h>
> >  #include <linux/i2c.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/platform_device.h>
> >  #include <sound/core.h>
> >  #include <sound/pcm.h>
> > @@ -56,6 +57,7 @@ struct aic3x_priv {
> >  	struct snd_soc_codec codec;
> >  	unsigned int sysclk;
> >  	int master;
> > +	struct regulator *regulator;
> >  };
> >  
> >  /*
> > @@ -1286,6 +1288,11 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
> >  	snd_soc_unregister_dai(&aic3x_dai);
> >  	snd_soc_unregister_codec(&aic3x->codec);
> >  
> > +	if (aic3x->regulator) {
> > +		regulator_disable(aic3x->regulator);
> > +		regulator_put(aic3x->regulator);
> > +	}
> > +
> >  	kfree(aic3x);
> >  	aic3x_codec = NULL;
> >  
> > @@ -1320,6 +1327,25 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
> >  	codec->control_data = i2c;
> >  	codec->hw_write = (hw_write_t) i2c_master_send;
> >  
> > +	aic3x->regulator = regulator_get(&i2c->dev, "avdd_dac");
> > +	if (IS_ERR(aic3x->regulator)) {
> > +		dev_warn(&i2c->dev, "No regulator to supply avdd_dac."
> > +					" Assuming always on.\n");
> > +		aic3x->regulator = NULL;
> > +	}
> > +
> > +	/*
> > +	 * REVISIT: Need to add proper code to put into sleep mode
> > +	 * avdd_dac regulator. For now, just leave it on.
> > +	 */
> 
> Will this ever be revisited =) ? If so, I think there's going to be a
> jungle in finding the right spots - you need to remember the bypass
> paths also (bias is not on necessarily). Also, this is regulator thing
> is highly platform dependent, not aic3x related really at all, so is
> this the correct place... Just a thought, dont take it too seriously ;) 


Heheh.. no I don't take it too seriously, don't worry :-)

Actually I've discussed about it with Peter. Initially I wrote it
inside rx51 machine driver. But then, we agreed it is actually a
thing which must be controlled by the driver. The same way it is done
for TPA for instance.

Of course,  the presence of that regulator must not be a blocker for
the driver. As you can see, if the regulator can not be queried, the driver
will assume that it is always on.

I must agree with you, but would rephrase as: the presence of this regulator
is board specific, but controlling when it must be enabled/disabled is a role
for the driver, in this case, tlv320aic3x.

What do you think ?

> 
> > +	if (aic3x->regulator) {
> > +		int err;
> > +
> > +		err = regulator_enable(aic3x->regulator);
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> >  	i2c_set_clientdata(i2c, aic3x);
> >  
> >  	return aic3x_register(codec);

-- 
Eduardo Valentin
