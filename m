From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: cx20442: add bias control over a
 platform provided regulator
Date: Mon, 26 Dec 2011 11:02:01 +0000
Message-ID: <20111226110201.GA8722@opensource.wolfsonmicro.com>
References: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
	<1324681944-19067-3-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1324681944-19067-3-git-send-email-jkrzyszt@tis.icnet.pl>
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

On Sat, Dec 24, 2011 at 12:12:22AM +0100, Janusz Krzysztofik wrote:

> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +		if (IS_ERR(cx20442->por.regulator)) {
> +			err = PTR_ERR(cx20442->por.regulator);
> +		} else if (!cx20442->por.enabled) {
> +			err = regulator_enable(cx20442->por.regulator);
> +			if (!err)
> +				cx20442->por.enabled = true;
> +		}
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +	case SND_SOC_BIAS_OFF:
> +		if (IS_ERR(cx20442->por.regulator)) {
> +			err = PTR_ERR(cx20442->por.regulator);
> +		} else if (cx20442->por.enabled) {
> +			err = regulator_disable(cx20442->por.regulator);
> +			if (!err)
> +				cx20442->por.enabled = false;
> +		}
> +	}
> +	mutex_unlock(&cx20442->por.lock);

You can avoid the mutex and simplify the code by relying on the fact
that the only possible transitions are:

   OFF <-> STANDBY <-> PREPARE <-> ON

which would look a lot more natural - you shouldn't need to remember if
the regulator is enabled, you should just turn it on in the STANDBY to
PREPARE transition and turn it off in the ON to PREPARE or PREPARE to
STANDBY transitions.
