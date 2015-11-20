From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] extcon: palmas: add support for using VBUSDET output
Date: Fri, 20 Nov 2015 08:37:18 -0600
Message-ID: <87io4wenz5.fsf@saruman.tx.rr.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447351034-21150-1-git-send-email-balbi@ti.com>
 <564EB0A6.4060407@samsung.com> <564EB332.5090406@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9015423915013682658=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <564EB332.5090406@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============9015423915013682658==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Chanwoo,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> Hi Felipe,
>
> On 2015=EB=85=84 11=EC=9B=94 20=EC=9D=BC 14:33, Chanwoo Choi wrote:
>> Hi Felipe,
>>=20
>> Looks good to me. But I have one comment.
>>=20
>> On 2015=EB=85=84 11=EC=9B=94 13=EC=9D=BC 02:57, Felipe Balbi wrote:
>>> TPS659038 can remux its GPIO_1 as VBUSDET output,
>>> which can be tied to a SoC GPIO and used as a VBUS
>>> interrupt.
>>>
>>> Beagle X15 uses that, in fact, and without it, I
>>> could not get USB peripheral working with that
>>> board.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>  drivers/extcon/extcon-palmas.c | 22 ++++++++++++++++++++--
>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-pal=
mas.c
>>> index 93c30a885740..7985d092c069 100644
>>> --- a/drivers/extcon/extcon-palmas.c
>>> +++ b/drivers/extcon/extcon-palmas.c
>>> @@ -296,10 +296,28 @@ static int palmas_usb_probe(struct platform_devic=
e *pdev)
>>>  	}
>>>=20=20
>>>  	if (palmas_usb->enable_vbus_detection) {
>>> +		int irq =3D platform_get_irq(pdev, 0);
>>> +
>>> +		if (irq > 0) {
>>> +			/* remux GPIO_1 as VBUSDET */
>>> +			status =3D palmas_update_bits(palmas, PALMAS_PU_PD_OD_BASE,
>>> +					PALMAS_PRIMARY_SECONDARY_PAD1,
>>> +					PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_MASK,
>>> +					(1 << 3));
>>=20
>> PALMAS_PRIMARY_SECONDARY_PAD1_GPIO_1_SHIFT is appropriate instead of
>> using '3'.

good point :-)

>>> +			if (status < 0) {
>>> +				dev_err(&pdev->dev, "can't remux GPIO1\n");
>>> +				return status;
>>> +			}
>>> +
>>> +			palmas_usb->vbus_irq =3D irq;
>>> +		} else {
>>> +			irq =3D regmap_irq_get_virq(palmas->irq_data,
>>> +					PALMAS_VBUS_IRQ);
>>> +			palmas_usb->vbus_irq =3D irq;
>>> +		}
>>> +
>>>  		palmas_usb->vbus_otg_irq =3D regmap_irq_get_virq(palmas->irq_data,
>>>  						       PALMAS_VBUS_OTG_IRQ);
>>> -		palmas_usb->vbus_irq =3D regmap_irq_get_virq(palmas->irq_data,
>>> -							   PALMAS_VBUS_IRQ);
>>>  		status =3D devm_request_threaded_irq(palmas_usb->dev,
>>>  				palmas_usb->vbus_irq, NULL,
>>>  				palmas_vbus_irq_handler,
>>>
>>=20
>> Thanks,
>> Chanwoo Choi
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>=20
>
> If you are OK about following patch, I'll apply it on extcon branch.

that's perfect, thanks for fixing it :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTzAfAAoJEIaOsuA1yqRERicP/2kiu7Nr60PpAV5LO4pIRoiU
bfqCFjKJLceL+gcMJhF3ScclV8hT4Gk1Sv4yxg//zTgdSRgTAan90c++OXxFRDFB
MtjX0dbT30fd7qZEN62NmoiTFk0MdA4qwFnBAVFqq33q2JdgNSDBhhRS+PqFq1sb
u3r1MXHOWjAtPESgs57qG9s4vHGyTQtmLvB0EQbdnm1bKnKBEnF6J/N1B/Xi3KXZ
vjlzTDIS0SER5z+tT3hsDPPk9mJ1k2okFwQ1ns8TvZygHd5aAvrl2kkDV9TXXHVq
6BEBcZMyxwrqPzXFdA39Zrd5rDQxcsX5C9dXIcTuK6yBOMOJ7xWFqiPUKRLUIppM
+pg/p82eeugRtAZmv7wMaYE2KTRQ5o/tQlgzXQ6PtPWV/E8crejRC719aIQ3SUix
+xMtRrSAiSsOAaBQt47QGsd3COmMd5xlYQvTEz9yCiu8OGjsCfAQksEHnGU+uozM
ev10hhTGg/kD3PyIJyCcXqNkE7tYMrudl/wAu1ebBtk1rAGz4MGl+7eXjxsZbvTP
zoG34q0UuHmJRdCbNe8AtGSEXpaXPVTiGht4Pj5dfOQA3UC6XxiiULPUkwJcOPTU
UiNOUyCDS1MHVTN8S2PZblFxUbmDHwx+Wk9/n8AfL5cFd3LlL4J+LHjdMbhTIf4G
IBofdQXcSWGA28f5/n32
=XRFq
-----END PGP SIGNATURE-----
--=-=-=--


--===============9015423915013682658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9015423915013682658==--
