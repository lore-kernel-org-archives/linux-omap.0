From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] extcon: palmas: Add the support for VBUS
 detection by using GPIO
Date: Mon, 11 Jan 2016 05:49:25 +0000
Message-ID: <20160111054925.GG3331@x1>
References: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
 <1451436947-22163-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451436947-22163-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: tony@atomide.com, robh+dt@kernel.org, balbi@ti.com, rogerq@ti.com, kishon@ti.com, george.cherian@ti.com, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 30 Dec 2015, Chanwoo Choi wrote:

> From: Felipe Balbi <balbi@ti.com>
>=20
> This patch support for VBUS detection by using GPIO pin.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon-palmas.c | 50 ++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/palmas.h     |  3 +++

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 53 insertions(+)
>=20
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-p=
almas.c
> index 93c30a885740..885ee95a6a7b 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -216,11 +216,23 @@ static int palmas_usb_probe(struct platform_dev=
ice *pdev)
>  		return PTR_ERR(palmas_usb->id_gpiod);
>  	}
> =20
> +	palmas_usb->vbus_gpiod =3D devm_gpiod_get_optional(&pdev->dev, "vbu=
s",
> +							GPIOD_IN);
> +	if (IS_ERR(palmas_usb->vbus_gpiod)) {
> +		dev_err(&pdev->dev, "failed to get vbus gpio\n");
> +		return PTR_ERR(palmas_usb->vbus_gpiod);
> +	}
> +
>  	if (palmas_usb->enable_id_detection && palmas_usb->id_gpiod) {
>  		palmas_usb->enable_id_detection =3D false;
>  		palmas_usb->enable_gpio_id_detection =3D true;
>  	}
> =20
> +	if (palmas_usb->enable_vbus_detection && palmas_usb->vbus_gpiod) {
> +		palmas_usb->enable_vbus_detection =3D false;
> +		palmas_usb->enable_gpio_vbus_detection =3D true;
> +	}
> +
>  	if (palmas_usb->enable_gpio_id_detection) {
>  		u32 debounce;
> =20
> @@ -311,6 +323,40 @@ static int palmas_usb_probe(struct platform_devi=
ce *pdev)
>  					palmas_usb->vbus_irq, status);
>  			return status;
>  		}
> +	} else if (palmas_usb->enable_gpio_vbus_detection) {
> +		/* remux GPIO_1 as VBUSDET */
> +		status =3D palmas_update_bits(palmas,
> +			PALMAS_PU_PD_OD_BASE,
> +			PALMAS_PRIMARY_SECONDARY_PAD1,
> +			PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_MASK,
> +			(1 << PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_SHIFT));
> +		if (status < 0) {
> +			dev_err(&pdev->dev, "can't remux GPIO1\n");
> +			return status;
> +		}
> +
> +		palmas_usb->vbus_otg_irq =3D regmap_irq_get_virq(palmas->irq_data,
> +						       PALMAS_VBUS_OTG_IRQ);
> +		palmas_usb->gpio_vbus_irq =3D gpiod_to_irq(palmas_usb->vbus_gpiod)=
;
> +		if (palmas_usb->gpio_vbus_irq < 0) {
> +			dev_err(&pdev->dev, "failed to get vbus irq\n");
> +			return palmas_usb->gpio_vbus_irq;
> +		}
> +		status =3D devm_request_threaded_irq(&pdev->dev,
> +						palmas_usb->gpio_vbus_irq,
> +						NULL,
> +						palmas_vbus_irq_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_TRIGGER_RISING |
> +						IRQF_ONESHOT |
> +						IRQF_EARLY_RESUME,
> +						"palmas_usb_vbus",
> +						palmas_usb);
> +		if (status < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to request handler for vbus irq\n");
> +			return status;
> +		}
>  	}
> =20
>  	palmas_enable_irq(palmas_usb);
> @@ -337,6 +383,8 @@ static int palmas_usb_suspend(struct device *dev)
>  	if (device_may_wakeup(dev)) {
>  		if (palmas_usb->enable_vbus_detection)
>  			enable_irq_wake(palmas_usb->vbus_irq);
> +		if (palmas_usb->enable_gpio_vbus_detection)
> +			enable_irq_wake(palmas_usb->gpio_vbus_irq);
>  		if (palmas_usb->enable_id_detection)
>  			enable_irq_wake(palmas_usb->id_irq);
>  		if (palmas_usb->enable_gpio_id_detection)
> @@ -352,6 +400,8 @@ static int palmas_usb_resume(struct device *dev)
>  	if (device_may_wakeup(dev)) {
>  		if (palmas_usb->enable_vbus_detection)
>  			disable_irq_wake(palmas_usb->vbus_irq);
> +		if (palmas_usb->enable_gpio_vbus_detection)
> +			disable_irq_wake(palmas_usb->gpio_vbus_irq);
>  		if (palmas_usb->enable_id_detection)
>  			disable_irq_wake(palmas_usb->id_irq);
>  		if (palmas_usb->enable_gpio_id_detection)
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 13e1d96935ed..7b2526f7bc9b 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -553,7 +553,9 @@ struct palmas_usb {
>  	int vbus_irq;
> =20
>  	int gpio_id_irq;
> +	int gpio_vbus_irq;
>  	struct gpio_desc *id_gpiod;
> +	struct gpio_desc *vbus_gpiod;
>  	unsigned long sw_debounce_jiffies;
>  	struct delayed_work wq_detectid;
> =20
> @@ -562,6 +564,7 @@ struct palmas_usb {
>  	bool enable_vbus_detection;
>  	bool enable_id_detection;
>  	bool enable_gpio_id_detection;
> +	bool enable_gpio_vbus_detection;
>  };
> =20
>  #define comparator_to_palmas(x) container_of((x), struct palmas_usb,=
 comparator)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
