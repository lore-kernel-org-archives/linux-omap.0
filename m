From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH RFC] MFD: OMAP: USB: Make the runtime functions depend on CONFIG_PM_RUNTIME
Date: Mon, 9 Jan 2012 17:00:45 +0530
Message-ID: <CAM=Q2csKSgvTrEyJn_nJRyphn-T0EkWwp3k5CKzL8TQMoDRZQw@mail.gmail.com>
References: <1325572979-6090-1-git-send-email-shubhrajyoti@ti.com>
	<874nwc8gts.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60695 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2AILar convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 06:30:47 -0500
In-Reply-To: <874nwc8gts.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 4, 2012 at 5:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> Currently the runtime functions are compiled regardless
>> of CONFIG_PM_RUNTIME flag. This patch intends to fix the same by
>> using SET_RUNTIME_PM_OPS.
>>
>> Cc : Keshava Munegowda <keshava_mgowda@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> applies on Tony's ehci branch.
>> Compile tested only.
>
> You also should compile test this with runtime PM disabled. =A0I beli=
eve
> the current patch will lead to 'function defined but not used' warnin=
gs.

Agree . thanks for pointing out.

>
> Kevin
>
>> =A0drivers/mfd/omap-usb-host.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 3f565ef..ef72ebe 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -887,8 +887,8 @@ static int __devexit usbhs_omap_remove(struct pl=
atform_device *pdev)
>> =A0}
>>
>> =A0static const struct dev_pm_ops usbhsomap_dev_pm_ops =3D {
>> - =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D usbhs_runtime_suspend,
>> - =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D usbhs_runtime_resume,
>> + =A0 =A0 SET_RUNTIME_PM_OPS(usbhs_runtime_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbhs_runt=
ime_resume, NULL)
>> =A0};
>>
>> =A0static struct platform_driver usbhs_omap_driver =3D {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
