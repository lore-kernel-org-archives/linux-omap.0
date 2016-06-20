From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/5] ASoC: tpa6130a2: Add DAPM support
Date: Mon, 20 Jun 2016 21:44:21 +0200
Message-ID: <57684795.8050705@metafoo.de>
References: <20160618104038.GB31665@earth>
 <cover.1466441036.git.helen.koike@collabora.co.uk>
 <bbddafe634bde1d12288862e02622d15c9b7c25c.1466441036.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <bbddafe634bde1d12288862e02622d15c9b7c25c.1466441036.git.helen.koike@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Helen Koike <helen.koike@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, k.kozlowski@samsung.com, lgirdwood@gmail.com, peter.ujfalusi@ti.com, broonie@kernel.org, cphealy@gmail.com, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

> +	/* before widget power up */
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		/* Turn on the chip */
> +		tpa6130a2_power(data, true);
> +		/* Sync the registers */
> +		ret = regcache_sync(data->regmap);
> +		if (ret < 0) {
> +			dev_err(c->dev, "Failed to initialize chip\n");
> +			tpa6130a2_power(data, false);
> +			return ret;
> +		}
> +	/* after widget power down */
> +	} else
> +		tpa6130a2_power(data, false);

checkpatch.pl should complain about this. Kernel code style is if one branch
has branches the other has to have it as well.
