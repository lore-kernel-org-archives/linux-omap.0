From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 4/7] usb: otg: twl4030-usb: poll for ID disconnect
Date: Sun, 10 Mar 2013 16:49:38 +0200
Message-ID: <CANOLnOOfZrNz3VO10CfyS2jLYnc1-zJftRPWu5wtKE2Q+hXfBQ@mail.gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
	<1362877681-8102-5-git-send-email-notasas@gmail.com>
	<513C6878.2000309@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58100 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3CJOtj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Mar 2013 10:49:39 -0400
In-Reply-To: <513C6878.2000309@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>

On Sun, Mar 10, 2013 at 1:03 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> just one comment.
>
> On 10/03/13 02:07, Grazvydas Ignotas wrote:
>> On pandora, STS_USB interrupt doesn't arrive on USB host cable disco=
nnect
>> for some reason while VBUS is driven by twl itself, but STS_HW_CONDI=
TIONS
>> is updated correctly. It does work fine when PHY is powered down tho=
ugh.
>> To work around that we have to poll.
>>
>> TI PSP kernels have similar workarounds, so (many?) more boards are =
likely
>> affected.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>>  drivers/usb/otg/twl4030-usb.c |   37 ++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030=
-usb.c
>> index 90a19ff..2c1c27e 100644
>> --- a/drivers/usb/otg/twl4030-usb.c
>> +++ b/drivers/usb/otg/twl4030-usb.c
=2E..
>> @@ -513,6 +525,28 @@ static irqreturn_t twl4030_usb_irq(int irq, voi=
d *_twl)
>>       return IRQ_HANDLED;
>>  }
>>
>> +static void twl4030_id_workaround_work(struct work_struct *work)
>> +{
>> +     struct twl4030_usb *twl =3D container_of(work, struct twl4030_=
usb,
>> +             id_workaround_work.work);
>> +     enum omap_musb_vbus_id_status status_prev =3D twl->linkstat;
>> +     enum omap_musb_vbus_id_status status;
>> +
>> +     status =3D twl4030_usb_linkstat(twl);
>> +     if (status !=3D status_prev) {
>> +             dev_dbg(twl->dev, "handle missing status change: %d->%=
d\n",
>> +                     status_prev, status);
>> +             twl->linkstat =3D status_prev;
>> +             twl4030_usb_irq(0, twl);
>
> As I understand from the subject this happen in Pandora board and
> many boards can be affected.
> do you need any protection between the worker and the irq when
> the irq arrive as expected?

Hmm I guess i do, I'll add some locking in v2, which I'll send after
collecting more feedback.

>
> Michael
>


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
