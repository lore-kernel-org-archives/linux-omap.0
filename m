From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] extcon: palmas: add support for using VBUSDET output
Date: Fri, 20 Nov 2015 14:33:26 +0900
Message-ID: <564EB0A6.4060407@samsung.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447351034-21150-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447351034-21150-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

Looks good to me. But I have one comment.

On 2015=EB=85=84 11=EC=9B=94 13=EC=9D=BC 02:57, Felipe Balbi wrote:
> TPS659038 can remux its GPIO_1 as VBUSDET output,
> which can be tied to a SoC GPIO and used as a VBUS
> interrupt.
>=20
> Beagle X15 uses that, in fact, and without it, I
> could not get USB peripheral working with that
> board.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/extcon/extcon-palmas.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-p=
almas.c
> index 93c30a885740..7985d092c069 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -296,10 +296,28 @@ static int palmas_usb_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	if (palmas_usb->enable_vbus_detection) {
> +		int irq =3D platform_get_irq(pdev, 0);
> +
> +		if (irq > 0) {
> +			/* remux GPIO_1 as VBUSDET */
> +			status =3D palmas_update_bits(palmas, PALMAS_PU_PD_OD_BASE,
> +					PALMAS_PRIMARY_SECONDARY_PAD1,
> +					PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_MASK,
> +					(1 << 3));

PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_SHIFT is appropriate instead of us=
ing '3'.
Also, I don't recommend the over line 80. The everything else is good


> +			if (status < 0) {
> +				dev_err(&pdev->dev, "can't remux GPIO1\n");
> +				return status;
> +			}
> +
> +			palmas_usb->vbus_irq =3D irq;
> +		} else {
> +			irq =3D regmap_irq_get_virq(palmas->irq_data,
> +					PALMAS_VBUS_IRQ);
> +			palmas_usb->vbus_irq =3D irq;
> +		}
> +
>  		palmas_usb->vbus_otg_irq =3D regmap_irq_get_virq(palmas->irq_data,
>  						       PALMAS_VBUS_OTG_IRQ);
> -		palmas_usb->vbus_irq =3D regmap_irq_get_virq(palmas->irq_data,
> -							   PALMAS_VBUS_IRQ);
>  		status =3D devm_request_threaded_irq(palmas_usb->dev,
>  				palmas_usb->vbus_irq, NULL,
>  				palmas_vbus_irq_handler,
>=20

Thanks,
Chanwoo Choi
