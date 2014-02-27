From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH RFC 2/5] ASoC: tlv320aic31xx: Add codec driver to Makefile
 and Kconfig
Date: Thu, 27 Feb 2014 16:11:24 +0200
Message-ID: <530F478C.20408@ti.com>
References: <cover.1393405575.git.jsarha@ti.com> <e5ddd051ac319649d50da0da804750c1c6619edb.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49321 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbaB0OLd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 09:11:33 -0500
In-Reply-To: <e5ddd051ac319649d50da0da804750c1c6619edb.1393405575.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, broonie@kernel.org
Cc: detheridge@ti.com

On 02/26/2014 11:14 AM, Jyri Sarha wrote:
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  sound/soc/codecs/Kconfig  |    4 ++++
>  sound/soc/codecs/Makefile |    2 ++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 983d087a..ead9dc5 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -74,6 +74,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_TLV320AIC23 if I2C
>  	select SND_SOC_TLV320AIC26 if SPI_MASTER
>  	select SND_SOC_TLV320AIC32X4 if I2C
> +	select SND_SOC_TLV320AIC31XX if I2C

You should keep this file ordered.

>  	select SND_SOC_TLV320AIC3X if I2C
>  	select SND_SOC_TPA6130A2 if I2C
>  	select SND_SOC_TLV320DAC33 if I2C
> @@ -364,6 +365,9 @@ config SND_SOC_TLV320AIC26
>  config SND_SOC_TLV320AIC32X4
>  	tristate
> =20
> +config SND_SOC_TLV320AIC31XX
> +        tristate
> +
>  config SND_SOC_TLV320AIC3X
>  	tristate
> =20
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index bc12676..23f8042 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -64,6 +64,7 @@ snd-soc-stac9766-objs :=3D stac9766.o
>  snd-soc-tas5086-objs :=3D tas5086.o
>  snd-soc-tlv320aic23-objs :=3D tlv320aic23.o
>  snd-soc-tlv320aic26-objs :=3D tlv320aic26.o
> +snd-soc-tlv320aic31xx-objs :=3D tlv320aic31xx.o

Same here.

>  snd-soc-tlv320aic3x-objs :=3D tlv320aic3x.o
>  snd-soc-tlv320aic32x4-objs :=3D tlv320aic32x4.o
>  snd-soc-tlv320dac33-objs :=3D tlv320dac33.o
> @@ -194,6 +195,7 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+=3D snd-soc-stac9=
766.o
>  obj-$(CONFIG_SND_SOC_TAS5086)	+=3D snd-soc-tas5086.o
>  obj-$(CONFIG_SND_SOC_TLV320AIC23)	+=3D snd-soc-tlv320aic23.o
>  obj-$(CONFIG_SND_SOC_TLV320AIC26)	+=3D snd-soc-tlv320aic26.o
> +obj-$(CONFIG_SND_SOC_TLV320AIC31XX)     +=3D snd-soc-tlv320aic31xx.o

and here

>  obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+=3D snd-soc-tlv320aic3x.o
>  obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     +=3D snd-soc-tlv320aic32x4.o
>  obj-$(CONFIG_SND_SOC_TLV320DAC33)	+=3D snd-soc-tlv320dac33.o
>=20

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
