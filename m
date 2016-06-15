From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] extcon: palmas: Fix boot up state of VBUS when using GPIO
 detection
Date: Wed, 15 Jun 2016 16:54:18 +0900
Message-ID: <576109AA.8020601@samsung.com>
References: <CGME20160614140603epcas1p25c5893caf8e0f15d89fbc022d05f2a6f@epcas1p2.samsung.com>
 <1465913075-30166-1-git-send-email-rogerq@ti.com> <5760B604.10407@samsung.com>
 <5760FA16.5070008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5760FA16.5070008@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, myungjoo.ham@samsung.com
Cc: balbi@kernel.org, nm@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2016=EB=85=84 06=EC=9B=94 15=EC=9D=BC 15:47, Roger Quadros wrote:
> On 15/06/16 04:57, Chanwoo Choi wrote:
>> On 2016=EB=85=84 06=EC=9B=94 14=EC=9D=BC 23:04, Roger Quadros wrote:
>>> If USB cable is connected prior to boot, we don't get any interrupt=
s
>>> so we must manually check the VBUS state and report it during probe=
=2E
>>> If we don't do it then USB controller will never know that peripher=
al
>>> cable was connected till the user unplugs and replugs the cable.
>>>
>>> Fixes: b7aad8e2685b ("extcon: palmas: Add the support for VBUS dete=
ction by using GPIO")
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  drivers/extcon/extcon-palmas.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon=
-palmas.c
>>> index 8b3226d..caff46c 100644
>>> --- a/drivers/extcon/extcon-palmas.c
>>> +++ b/drivers/extcon/extcon-palmas.c
>>> @@ -360,6 +360,8 @@ static int palmas_usb_probe(struct platform_dev=
ice *pdev)
>>> =20
>>>  	palmas_enable_irq(palmas_usb);
>>>  	/* perform initial detection */
>>> +	if (palmas_usb->enable_gpio_vbus_detection)
>>> +		palmas_vbus_irq_handler(palmas_usb->gpio_vbus_irq, palmas_usb);
>>>  	palmas_gpio_id_detect(&palmas_usb->wq_detectid.work);
>>>  	device_set_wakeup_capable(&pdev->dev, true);
>>>  	return 0;
>>>
>>
>> Applied it.
>=20
> Thanks. But this is a bug fix and must go in v4.7-rc
> as well as stable v4.6+.

OK. I'll send the pull request for this patch.

>=20
> Can you please add
>=20
> Cc: stable@vger.kernel.org # v4.6+

If we should add the 'stable@verger.kernel.org',
this patch should be sent to mailing list.
So, I think that you better to send this patch including stable mailing=
 list.
And then, I'll send pull request which apply this patch to 4.7-rc.

Thanks,
Chanwoo Choi
