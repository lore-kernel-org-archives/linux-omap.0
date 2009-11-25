From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: AM3517: Fix AIC23 suspend/resume hang
Date: Wed, 25 Nov 2009 13:33:40 +0000
Message-ID: <20091125133340.GB3737@sirena.org.uk>
References: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1259154631-15251-1-git-send-email-anuj.aggarwal@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 25, 2009 at 06:40:31PM +0530, Anuj Aggarwal wrote:

> System hang is observed While trying to do suspend. It was because
> of an infinite loop in the AIC23 resume path which was trying to
> restore AIC23 register values from the register cache.

This doesn't appear to tie in with the actual patch - where's the
infinite loop?  The register cache restore loop has a constant bound and
I can't see anything that would make it spin infinitely.

> This patch fixes the problem by correcting the resume path and
> properly activating/deactivating the digital interface while
> doing the suspend / off transitions.

What do you mean by "properly activating/deactivating the digital
interface"?

>  	case SND_SOC_BIAS_STANDBY:
> -		/* everything off except vref/vmid, */
> -		tlv320aic23_write(codec, TLV320AIC23_PWR, reg | 0x0040);
> +		/* Activate the digital interface */
> +		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x1);
>  		break;
>  	case SND_SOC_BIAS_OFF:
> -		/* everything off, dac mute, inactive */
> +		/* Deactivate the digital interface */
>  		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
> -		tlv320aic23_write(codec, TLV320AIC23_PWR, 0xffff);
>  		break;

This looks wrong - the driver is now no longer managing bias levels at
all.

> -	u16 reg;
> -
> -	/* Sync reg_cache with the hardware */
> -	for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
> -		u16 val = tlv320aic23_read_reg_cache(codec, reg);
> -		tlv320aic23_write(codec, reg, val);
> -	}

This also looks wrong, the register cache restore has been completely
removed so if the power to the device is cut during suspend then the
device will go back to register defaults and no longer function
correctly after resume.
