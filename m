From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] extcon: palmas: add support for using VBUSDET output
Date: Sat, 21 Nov 2015 01:34:39 +0900
Message-ID: <564F4B9F.7000100@gmail.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447351034-21150-1-git-send-email-balbi@ti.com>
 <564EB0A6.4060407@samsung.com> <564EB332.5090406@samsung.com>
 <87io4wenz5.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87io4wenz5.fsf@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 2015. 11. 20. =EC=98=A4=ED=9B=84 11:37, Felipe Balbi wrote:
>=20
> Hi Chanwoo,
>=20
> Chanwoo Choi <cw00.choi@samsung.com> writes:
>> Hi Felipe,
>>
>> On 2015=EB=85=84 11=EC=9B=94 20=EC=9D=BC 14:33, Chanwoo Choi wrote:
>>> Hi Felipe,
>>>
>>> Looks good to me. But I have one comment.
>>>
>>> On 2015=EB=85=84 11=EC=9B=94 13=EC=9D=BC 02:57, Felipe Balbi wrote:
>>>> TPS659038 can remux its GPIO_1 as VBUSDET output,
>>>> which can be tied to a SoC GPIO and used as a VBUS
>>>> interrupt.
>>>>
>>>> Beagle X15 uses that, in fact, and without it, I
>>>> could not get USB peripheral working with that
>>>> board.
>>>>
>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>> ---
>>>>  drivers/extcon/extcon-palmas.c | 22 ++++++++++++++++++++--
>>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extco=
n-palmas.c
>>>> index 93c30a885740..7985d092c069 100644
>>>> --- a/drivers/extcon/extcon-palmas.c
>>>> +++ b/drivers/extcon/extcon-palmas.c
>>>> @@ -296,10 +296,28 @@ static int palmas_usb_probe(struct platform_=
device *pdev)
>>>>  	}
>>>> =20
>>>>  	if (palmas_usb->enable_vbus_detection) {
>>>> +		int irq =3D platform_get_irq(pdev, 0);
>>>> +
>>>> +		if (irq > 0) {
>>>> +			/* remux GPIO_1 as VBUSDET */
>>>> +			status =3D palmas_update_bits(palmas, PALMAS_PU_PD_OD_BASE,
>>>> +					PALMAS_PRIMARY_SECONDARY_PAD1,
>>>> +					PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_MASK,
>>>> +					(1 << 3));
>>>
>>> PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_SHIFT is appropriate instead o=
f
>>> using '3'.
>=20
> good point :-)
>=20
>>>> +			if (status < 0) {
>>>> +				dev_err(&pdev->dev, "can't remux GPIO1\n");
>>>> +				return status;
>>>> +			}
>>>> +
>>>> +			palmas_usb->vbus_irq =3D irq;
>>>> +		} else {
>>>> +			irq =3D regmap_irq_get_virq(palmas->irq_data,
>>>> +					PALMAS_VBUS_IRQ);
>>>> +			palmas_usb->vbus_irq =3D irq;
>>>> +		}
>>>> +
>>>>  		palmas_usb->vbus_otg_irq =3D regmap_irq_get_virq(palmas->irq_da=
ta,
>>>>  						       PALMAS_VBUS_OTG_IRQ);
>>>> -		palmas_usb->vbus_irq =3D regmap_irq_get_virq(palmas->irq_data,
>>>> -							   PALMAS_VBUS_IRQ);
>>>>  		status =3D devm_request_threaded_irq(palmas_usb->dev,
>>>>  				palmas_usb->vbus_irq, NULL,
>>>>  				palmas_vbus_irq_handler,
>>>>
>>>
>>> Thanks,
>>> Chanwoo Choi
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>> If you are OK about following patch, I'll apply it on extcon branch.
>=20
> that's perfect, thanks for fixing it :-)
>=20

Before applying this patch, I think that there are more generic method?
So, I check the extcon-palmas.c driver again. There is similiar case fo=
r id detection.

In some case, id detection use whether 'enable_id_detection' with own i=
nterrupt
or 'enable_gpio_id_dectection' with specific h/w gpio like this case of=
 vbus.

In result, I implement the following patch for vbus gpio detection.
But, I'm not sure because I have not any H/W board for test.

If you possible, could you test it with following patch?

Thanks,
Chanwoo Choi

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-pal=
mas.c
index 93c30a8..885ee95 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -216,11 +216,23 @@ static int palmas_usb_probe(struct platform_devic=
e *pdev)
 		return PTR_ERR(palmas_usb->id_gpiod);
 	}
=20
+	palmas_usb->vbus_gpiod =3D devm_gpiod_get_optional(&pdev->dev, "vbus"=
,
+							GPIOD_IN);
+	if (IS_ERR(palmas_usb->vbus_gpiod)) {
+		dev_err(&pdev->dev, "failed to get vbus gpio\n");
+		return PTR_ERR(palmas_usb->vbus_gpiod);
+	}
+
 	if (palmas_usb->enable_id_detection && palmas_usb->id_gpiod) {
 		palmas_usb->enable_id_detection =3D false;
 		palmas_usb->enable_gpio_id_detection =3D true;
 	}
=20
+	if (palmas_usb->enable_vbus_detection && palmas_usb->vbus_gpiod) {
+		palmas_usb->enable_vbus_detection =3D false;
+		palmas_usb->enable_gpio_vbus_detection =3D true;
+	}
+
 	if (palmas_usb->enable_gpio_id_detection) {
 		u32 debounce;
=20
@@ -311,6 +323,40 @@ static int palmas_usb_probe(struct platform_device=
 *pdev)
 					palmas_usb->vbus_irq, status);
 			return status;
 		}
+	} else if (palmas_usb->enable_gpio_vbus_detection) {
+		/* remux GPIO_1 as VBUSDET */
+		status =3D palmas_update_bits(palmas,
+			PALMAS_PU_PD_OD_BASE,
+			PALMAS_PRIMARY_SECONDARY_PAD1,
+			PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_MASK,
+			(1 << PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_SHIFT));
+		if (status < 0) {
+			dev_err(&pdev->dev, "can't remux GPIO1\n");
+			return status;
+		}
+
+		palmas_usb->vbus_otg_irq =3D regmap_irq_get_virq(palmas->irq_data,
+						       PALMAS_VBUS_OTG_IRQ);
+		palmas_usb->gpio_vbus_irq =3D gpiod_to_irq(palmas_usb->vbus_gpiod);
+		if (palmas_usb->gpio_vbus_irq < 0) {
+			dev_err(&pdev->dev, "failed to get vbus irq\n");
+			return palmas_usb->gpio_vbus_irq;
+		}
+		status =3D devm_request_threaded_irq(&pdev->dev,
+						palmas_usb->gpio_vbus_irq,
+						NULL,
+						palmas_vbus_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT |
+						IRQF_EARLY_RESUME,
+						"palmas_usb_vbus",
+						palmas_usb);
+		if (status < 0) {
+			dev_err(&pdev->dev,
+				"failed to request handler for vbus irq\n");
+			return status;
+		}
 	}
=20
 	palmas_enable_irq(palmas_usb);
@@ -337,6 +383,8 @@ static int palmas_usb_suspend(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		if (palmas_usb->enable_vbus_detection)
 			enable_irq_wake(palmas_usb->vbus_irq);
+		if (palmas_usb->enable_gpio_vbus_detection)
+			enable_irq_wake(palmas_usb->gpio_vbus_irq);
 		if (palmas_usb->enable_id_detection)
 			enable_irq_wake(palmas_usb->id_irq);
 		if (palmas_usb->enable_gpio_id_detection)
@@ -352,6 +400,8 @@ static int palmas_usb_resume(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		if (palmas_usb->enable_vbus_detection)
 			disable_irq_wake(palmas_usb->vbus_irq);
+		if (palmas_usb->enable_gpio_vbus_detection)
+			disable_irq_wake(palmas_usb->gpio_vbus_irq);
 		if (palmas_usb->enable_id_detection)
 			disable_irq_wake(palmas_usb->id_irq);
 		if (palmas_usb->enable_gpio_id_detection)
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 13e1d96..7b2526f 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -553,7 +553,9 @@ struct palmas_usb {
 	int vbus_irq;
=20
 	int gpio_id_irq;
+	int gpio_vbus_irq;
 	struct gpio_desc *id_gpiod;
+	struct gpio_desc *vbus_gpiod;
 	unsigned long sw_debounce_jiffies;
 	struct delayed_work wq_detectid;
=20
@@ -562,6 +564,7 @@ struct palmas_usb {
 	bool enable_vbus_detection;
 	bool enable_id_detection;
 	bool enable_gpio_id_detection;
+	bool enable_gpio_vbus_detection;
 };
=20
 #define comparator_to_palmas(x) container_of((x), struct palmas_usb, c=
omparator)
