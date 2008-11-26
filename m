From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 13:40:28 +0200
Message-ID: <20081126134028.b3c6aa46.jarkko.nikula@nokia.com>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
	<20081126110854.GA6234@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20081126110854.GA6234@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 26 Nov 2008 11:08:55 +0000
"ext Mark Brown" <broonie@sirena.org.uk> wrote:

> > +#ifdef CONFIG_SND_OMAP_SOC_N810
> > +#include "../codecs/tlv320aic3x.h"
> > +#define CODEC_SYS_CLOCK		12000000
> > +#define CODEC_NAME		"TLV320AIC33"
> > +#define STREAM_NAME		"AIC33"
> > +#define CODEC_DEV		(&soc_codec_dev_aic3x)
> > +#define CODEC_DAI		(&aic3x_dai)
> > +#define CODEC_SETUP_DATA	(&&n810_aic33_setup)
> > +#define DAI_LINK_INIT		(n810_aic33_init)
> > +#define SOC_OPS_STARTUP		(n810_startup)
> > +#define SOC_OPS_SHUTDOWN	(n810_shutdown)
> 
> Please change this to use a platform data based approach rather than
> these ifdefs: it's not a good approach for readability and it prevents
> building multiple board drivers in one kernel which isn't good for
> distributions.  The s3c24xx_uda134x.c provides an example of how this
> can be done.  It may be more sensible to have a separate driver per
> codec.
> --
And as a first step, I recommend to start merging only those EVM & SDP
boards with Beagle since they seems to be most close to each other.

Even the Overo seems to be close also, it was discussed earlier to keep
it separated now since Steve was going to send some new features into
it.


Jarkko
