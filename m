From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: OMAP: ams-delta: drop
	.set_bias_level callback
Date: Mon, 26 Dec 2011 11:03:49 +0000
Message-ID: <20111226110348.GB8722@opensource.wolfsonmicro.com>
References: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
	<1324681944-19067-5-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1324681944-19067-5-git-send-email-jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 24, 2011 at 12:12:24AM +0100, Janusz Krzysztofik wrote:

> +struct regulator_consumer_data {
> +	struct mutex lock;
> +	struct regulator *regulator;
> +	bool enabled;
> +};
> +
> +static int regulator_toggle(struct regulator_consumer_data *consumer,
> +		bool enable)
> +{
> +	int err = 0;
> +
> +	if (!consumer->regulator)
> +		return -ENODEV;
> +
> +	mutex_lock(&consumer->lock);
> +	if (IS_ERR(consumer->regulator)) {
> +		err = PTR_ERR(consumer->regulator);
> +	} else if (enable) {
> +		if (!consumer->enabled) {
> +			err = regulator_enable(consumer->regulator);
> +			consumer->enabled = true;
> +		}
> +	} else {
> +		if (consumer->enabled) {
> +			err = regulator_disable(consumer->regulator);
> +			consumer->enabled = false;
> +		}
> +	}
> +	mutex_unlock(&consumer->lock);
> +
> +	return err;
> +}
> +

Why's this code not been dropped and what is it for?
