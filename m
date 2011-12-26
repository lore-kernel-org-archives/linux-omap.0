From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 2/4] ASoC: cx20442: add bias control over a
	platform provided regulator
Date: Mon, 26 Dec 2011 13:18:13 +0100
Message-ID: <201112261318.14549.jkrzyszt@tis.icnet.pl>
References: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
	<1324681944-19067-3-git-send-email-jkrzyszt@tis.icnet.pl>
	<20111226110201.GA8722@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20111226110201.GA8722@opensource.wolfsonmicro.com>
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
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 26 of December 2011 at 12:02:01, Mark Brown wrote:
> On Sat, Dec 24, 2011 at 12:12:22AM +0100, Janusz Krzysztofik wrote:
> 
> > +	case SND_SOC_BIAS_ON:
> > +	case SND_SOC_BIAS_PREPARE:
> > +		if (IS_ERR(cx20442->por.regulator)) {
> > +			err = PTR_ERR(cx20442->por.regulator);
> > +		} else if (!cx20442->por.enabled) {
> > +			err = regulator_enable(cx20442->por.regulator);
> > +			if (!err)
> > +				cx20442->por.enabled = true;
> > +		}
> > +		break;
> > +	case SND_SOC_BIAS_STANDBY:
> > +	case SND_SOC_BIAS_OFF:
> > +		if (IS_ERR(cx20442->por.regulator)) {
> > +			err = PTR_ERR(cx20442->por.regulator);
> > +		} else if (cx20442->por.enabled) {
> > +			err = regulator_disable(cx20442->por.regulator);
> > +			if (!err)
> > +				cx20442->por.enabled = false;
> > +		}
> > +	}
> > +	mutex_unlock(&cx20442->por.lock);
> 
> You can avoid the mutex and simplify the code by relying on the fact
> that the only possible transitions are:
> 
>    OFF <-> STANDBY <-> PREPARE <-> ON
> 
> which would look a lot more natural - you shouldn't need to remember if
> the regulator is enabled, you should just turn it on in the STANDBY to
> PREPARE transition and turn it off in the ON to PREPARE or PREPARE to
> STANDBY transitions.

OK, will do, thanks for the hint.
Janusz
