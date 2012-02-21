From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/3] MFD: twl6040: Conversion to i2c driver
Date: Tue, 21 Feb 2012 12:33:07 +0200
Message-ID: <4F4372E3.4050408@ti.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com> <20120220194736.GN5387@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:35839 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752751Ab2BUKdD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 05:33:03 -0500
In-Reply-To: <20120220194736.GN5387@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Hi Samuel,

On 02/20/2012 09:47 PM, Samuel Ortiz wrote:
> Hi Peter,
>=20
> On Fri, Feb 10, 2012 at 12:00:15PM +0200, Peter Ujfalusi wrote:
>> Hello,
>>
>> Changes since v2:
>> - soc/codec/Kconfig: make twl6040 depend on I2C
>> - Regulator related patches has been removed (to be sent as separate=
 series)
> I applied all 3 patches. Patch #2 did not apply cleanly, due to the f=
act that
> several struct twl4030_codec_data omap4panda.c references are not ups=
tream
> yet. This is my .rej:

The Panda audio support is going via sound tree. It is in linux-next
already for couple of weeks now. The reason you have this reject is tha=
t
you don't have the audio support for Panda series, and a such upstream
does not have it either :( It is for 3.4 also.

> --- arch/arm/mach-omap2/board-omap4panda.c
> +++ arch/arm/mach-omap2/board-omap4panda.c
> @@ -278,7 +279,7 @@
>  	return 0;
>  }
> =20
> -static struct twl4030_codec_data twl6040_codec =3D {
> +static struct twl6040_codec_data twl6040_codec =3D {
>  	/* single-step ramp for headset and handsfree */
>  	.hs_left_step	=3D 0x0f,
>  	.hs_right_step	=3D 0x0f,
> @@ -286,17 +287,14 @@
>  	.hf_right_step	=3D 0x1d,
>  };
> =20
> -static struct twl4030_audio_data twl6040_audio =3D {
> +static struct twl6040_platform_data twl6040_data =3D {
>  	.codec		=3D &twl6040_codec,
>  	.audpwron_gpio	=3D 127,
> -	.naudint_irq	=3D OMAP44XX_IRQ_SYS_2N,
>  	.irq_base	=3D TWL6040_CODEC_IRQ_BASE,
>  };
> =20
>  /* Panda board uses the common PMIC configuration */
> -static struct twl4030_platform_data omap4_panda_twldata =3D {
> -	.audio		=3D &twl6040_audio,
> -};
> +static struct twl4030_platform_data omap4_panda_twldata;
>=20
> I'm not sure hwo we could handle that properly. Either by letting Ton=
y
> carrying this patchset, or by sending me the panda patch that adds th=
ose
> structures. As you prefer.

If Liam would take this series that would be probably the way forward.
If he does not have objections.
Liam: I can create a branch for you to pull from as soon as all other
patch receives the needed acks...

Samuel: if Liam agrees is it possible for you to drop the twl6040
related patches from your for-next branch?

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
