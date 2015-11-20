From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] extcon: palmas: add support for using VBUSDET output
Date: Sat, 21 Nov 2015 01:37:04 +0900
Message-ID: <CAGTfZH37-CB9VdRSyS+7wOB50KXB7U2KVAuGU9_nvBX=7Ro22g@mail.gmail.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
	<1447351034-21150-1-git-send-email-balbi@ti.com>
	<564EB0A6.4060407@samsung.com>
	<564EB332.5090406@samsung.com>
	<87io4wenz5.fsf@saruman.tx.rr.com>
	<CAGTfZH1LStzFc8O==n8trw232=nqyEmPhrXyE4bgM88oApPsWQ@mail.gmail.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGTfZH1LStzFc8O==n8trw232=nqyEmPhrXyE4bgM88oApPsWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, Nov 21, 2015 at 12:05 AM, Chanwoo Choi <cwchoi00@gmail.com> wro=
te:
> Hi Felipe,
>
> On Fri, Nov 20, 2015 at 11:37 PM, Felipe Balbi <balbi@ti.com> wrote:
>>
>> Hi Chanwoo,
>>
>> Chanwoo Choi <cw00.choi@samsung.com> writes:
>>> Hi Felipe,
>>>
>>> On 2015=EB=85=84 11=EC=9B=94 20=EC=9D=BC 14:33, Chanwoo Choi wrote:
>>>> Hi Felipe,
>>>>
>>>> Looks good to me. But I have one comment.
>>>>
>>>> On 2015=EB=85=84 11=EC=9B=94 13=EC=9D=BC 02:57, Felipe Balbi wrote=
:
>>>>> TPS659038 can remux its GPIO_1 as VBUSDET output,
>>>>> which can be tied to a SoC GPIO and used as a VBUS
>>>>> interrupt.
>>>>>
>>>>> Beagle X15 uses that, in fact, and without it, I
>>>>> could not get USB peripheral working with that
>>>>> board.
>>>>>
>>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>>> ---
>>>>>  drivers/extcon/extcon-palmas.c | 22 ++++++++++++++++++++--
>>>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extc=
on-palmas.c
>>>>> index 93c30a885740..7985d092c069 100644
>>>>> --- a/drivers/extcon/extcon-palmas.c
>>>>> +++ b/drivers/extcon/extcon-palmas.c
>>>>> @@ -296,10 +296,28 @@ static int palmas_usb_probe(struct platform=
_device *pdev)
>>>>>     }
>>>>>
>>>>>     if (palmas_usb->enable_vbus_detection) {
>>>>> +           int irq =3D platform_get_irq(pdev, 0);
>>>>> +
>>>>> +           if (irq > 0) {
>>>>> +                   /* remux GPIO_1 as VBUSDET */
>>>>> +                   status =3D palmas_update_bits(palmas, PALMAS_=
PU_PD_OD_BASE,
>>>>> +                                   PALMAS_PRIMARY_SECONDARY_PAD1=
,
>>>>> +                                   PALMAS_PRIMARY_SECONDARY_PAD1=
_GPIO_1_MASK,
>>>>> +                                   (1 << 3));
>>>>
>>>> PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_SHIFT is appropriate instead =
of
>>>> using '3'.
>>
>> good point :-)
>>
>>>>> +                   if (status < 0) {
>>>>> +                           dev_err(&pdev->dev, "can't remux GPIO=
1\n");
>>>>> +                           return status;
>>>>> +                   }
>>>>> +
>>>>> +                   palmas_usb->vbus_irq =3D irq;
>>>>> +           } else {
>>>>> +                   irq =3D regmap_irq_get_virq(palmas->irq_data,
>>>>> +                                   PALMAS_VBUS_IRQ);
>>>>> +                   palmas_usb->vbus_irq =3D irq;
>>>>> +           }
>>>>> +
>>>>>             palmas_usb->vbus_otg_irq =3D regmap_irq_get_virq(palm=
as->irq_data,
>>>>>                                                    PALMAS_VBUS_OT=
G_IRQ);
>>>>> -           palmas_usb->vbus_irq =3D regmap_irq_get_virq(palmas->=
irq_data,
>>>>> -                                                      PALMAS_VBU=
S_IRQ);
>>>>>             status =3D devm_request_threaded_irq(palmas_usb->dev,
>>>>>                             palmas_usb->vbus_irq, NULL,
>>>>>                             palmas_vbus_irq_handler,
>>>>>
>>>>
>>>> Thanks,
>>>> Chanwoo Choi
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ke=
rnel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>
>>> If you are OK about following patch, I'll apply it on extcon branch=
=2E
>>
>> that's perfect, thanks for fixing it :-)
>
> Applied it.

Please ignore this reply about applies because I need to discuss about =
it.

Thanks,
Chanwoo Choi
