From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv4 3/7] ASoC: TWL6030: Manual power-up/down sequences
Date: Wed, 24 Feb 2010 10:40:36 +0000
Message-ID: <1267008036.3274.141.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B15@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:39307 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526Ab0BXKkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 05:40:42 -0500
Received: by fxm19 with SMTP id 19so4868722fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 24 Feb 2010 02:40:41 -0800 (PST)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD1B15@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> TWL6030 codec device can be powered-up/down through a specific register
> writes sequence. These sequences can be used when no gpio line is
> provided for AUDPWRON.
> 
> When the codec is powered-up in this way, automatic power-down sequence
> (triggered by thermal shutdown) is not possible.
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> ---
>  sound/soc/codecs/twl6030.c |  112 ++++++++++++++++++++++++++++++++++++++-----
>  sound/soc/codecs/twl6030.h |   16 ++++++
>  2 files changed, 115 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
> index 8b52aa1..ec838b1 100644
> --- a/sound/soc/codecs/twl6030.c
> +++ b/sound/soc/codecs/twl6030.c
> @@ -244,6 +244,88 @@ static void twl6030_init_vdd_regs(struct snd_soc_codec *codec)
>  	}
>  }
>  
> +/* twl6030 codec manual power-up sequence */
> +static void twl6030_power_up(struct snd_soc_codec *codec)
> +{
> +	u8 ncpctl, ldoctl, lppllctl, accctl;
> +
> +	ncpctl = twl6030_read_reg_cache(codec, TWL6030_REG_NCPCTL);
> +	ldoctl = twl6030_read_reg_cache(codec, TWL6030_REG_LDOCTL);
> +	lppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
> +	accctl = twl6030_read_reg_cache(codec, TWL6030_REG_ACCCTL);
> +
> +	/* enable reference system */
> +	ldoctl |= TWL6030_REFENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	mdelay(10);
> +	/* enable internal oscillator */
> +	ldoctl |= TWL6030_OSCENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	udelay(10);
> +	/* enable high-side ldo */
> +	ldoctl |= TWL6030_HSLDOENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	udelay(244);
> +	/* enable negative charge pump */
> +	ncpctl |= TWL6030_NCPENA | TWL6030_NCPOPEN;
> +	twl6030_write(codec, TWL6030_REG_NCPCTL, ncpctl);
> +	udelay(488);
> +	/* enable low-side ldo */
> +	ldoctl |= TWL6030_LSLDOENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	udelay(244);
> +	/* enable low-power pll */
> +	lppllctl |= TWL6030_LPLLENA;
> +	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
> +	/* reset state machine */
> +	accctl |= TWL6030_RESETSPLIT;
> +	twl6030_write(codec, TWL6030_REG_ACCCTL, accctl);
> +	mdelay(5);
> +	accctl &= ~TWL6030_RESETSPLIT;
> +	twl6030_write(codec, TWL6030_REG_ACCCTL, accctl);
> +	/* disable internal oscillator */
> +	ldoctl &= ~TWL6030_OSCENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +}
> +
> +/* twl6030 codec manual power-down sequence */
> +static void twl6030_power_down(struct snd_soc_codec *codec)
> +{
> +	u8 ncpctl, ldoctl, lppllctl, accctl;
> +
> +	ncpctl = twl6030_read_reg_cache(codec, TWL6030_REG_NCPCTL);
> +	ldoctl = twl6030_read_reg_cache(codec, TWL6030_REG_LDOCTL);
> +	lppllctl = twl6030_read_reg_cache(codec, TWL6030_REG_LPPLLCTL);
> +	accctl = twl6030_read_reg_cache(codec, TWL6030_REG_ACCCTL);
> +
> +	/* enable internal oscillator */
> +	ldoctl |= TWL6030_OSCENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	udelay(10);
> +	/* disable low-power pll */
> +	lppllctl &= ~TWL6030_LPLLENA;
> +	twl6030_write(codec, TWL6030_REG_LPPLLCTL, lppllctl);
> +	/* disable low-side ldo */
> +	ldoctl &= ~TWL6030_LSLDOENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	udelay(244);
> +	/* disable negative charge pump */
> +	ncpctl &= ~(TWL6030_NCPENA | TWL6030_NCPOPEN);
> +	twl6030_write(codec, TWL6030_REG_NCPCTL, ncpctl);
> +	udelay(488);
> +	/* disable high-side ldo */
> +	ldoctl &= ~TWL6030_HSLDOENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	udelay(244);
> +	/* disable internal oscillator */
> +	ldoctl &= ~TWL6030_OSCENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	/* disable reference system */
> +	ldoctl &= ~TWL6030_REFENA;
> +	twl6030_write(codec, TWL6030_REG_LDOCTL, ldoctl);
> +	mdelay(10);
> +}
> +
>  /*


Some large mdelays here again.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

