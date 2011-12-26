From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 4/4] ASoC: OMAP: ams-delta: drop
	.set_bias_level callback
Date: Mon, 26 Dec 2011 13:30:22 +0100
Message-ID: <201112261330.22783.jkrzyszt@tis.icnet.pl>
References: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
	<1324681944-19067-5-git-send-email-jkrzyszt@tis.icnet.pl>
	<20111226110348.GB8722@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20111226110348.GB8722@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Monday 26 of December 2011 at 12:03:49, Mark Brown wrote:
> On Sat, Dec 24, 2011 at 12:12:24AM +0100, Janusz Krzysztofik wrote:
> 
> > +struct regulator_consumer_data {
> > +	struct mutex lock;
> > +	struct regulator *regulator;
> > +	bool enabled;
> > +};
> > +
> > +static int regulator_toggle(struct regulator_consumer_data *consumer,
> > +		bool enable)
> > +{
> > +	int err = 0;
> > +
> > +	if (!consumer->regulator)
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&consumer->lock);
> > +	if (IS_ERR(consumer->regulator)) {
> > +		err = PTR_ERR(consumer->regulator);
> > +	} else if (enable) {
> > +		if (!consumer->enabled) {
> > +			err = regulator_enable(consumer->regulator);
> > +			consumer->enabled = true;
> > +		}
> > +	} else {
> > +		if (consumer->enabled) {
> > +			err = regulator_disable(consumer->regulator);
> > +			consumer->enabled = false;
> > +		}
> > +	}
> > +	mutex_unlock(&consumer->lock);
> > +
> > +	return err;
> > +}
> > +
> 
> Why's this code not been dropped and what is it for?

It is, and will be, used by another regulator consumer, the modem. The 
device is controlled by the generic serial8250 driver, extended with a 
custom .pm hook which enables/disables the regulator. The above code, 
temporarily shared with the ASoC device before updated, is now just 
moved down the board file where the modem related bits are located (see 
patch 3/4).

Any hints like that for the codec driver?

Thanks,
Janusz
