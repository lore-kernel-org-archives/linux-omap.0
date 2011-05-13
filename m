From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 3/5] arm: omap: usb: device name change for the clk names
 of usbhs
Date: Fri, 13 May 2011 12:04:24 +0530
Message-ID: <BANLkTin0hU95m5msSge_TYDPc774i4rGpQ@mail.gmail.com>
References: <1305122676-27236-1-git-send-email-keshava_mgowda@ti.com>
	<1305122676-27236-2-git-send-email-keshava_mgowda@ti.com>
	<1305122676-27236-3-git-send-email-keshava_mgowda@ti.com>
	<1305122676-27236-4-git-send-email-keshava_mgowda@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CE66B4A@dbde02.ent.ti.com>
	<4DCBC444.10506@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48733 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756298Ab1EMGe2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 02:34:28 -0400
In-Reply-To: <4DCBC444.10506@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "parthab@india.ti.com" <parthab@india.ti.com>

On Thu, May 12, 2011 at 4:58 PM, Igor Grinberg <grinberg@compulab.co.il=
> wrote:
>
>
> On 05/12/11 13:49, Premi, Sanjeev wrote:
>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>> Munegowda, Keshava
>>> Sent: Wednesday, May 11, 2011 7:35 PM
>>> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>>> Cc: Munegowda, Keshava; Balbi, Felipe; Gadiyar, Anand;
>>> parthab@india.ti.com
>>> Subject: [PATCH 3/5] arm: omap: usb: device name change for
>>> the clk names of usbhs
>> [snip]...[snip]
>>
>>> --- a/drivers/mfd/omap-usb-host.c
>>> +++ b/drivers/mfd/omap-usb-host.c
>>> @@ -27,7 +27,7 @@
>>> =A0#include <linux/gpio.h>
>>> =A0#include <plat/usb.h>
>>>
>>> -#define USBHS_DRIVER_NAME =A0 "usbhs-omap"
>>> +#define USBHS_DRIVER_NAME =A0 "usbhs_omap"
>>> =A0#define OMAP_EHCI_DEVICE =A0 =A0"ehci-omap"
>>> =A0#define OMAP_OHCI_DEVICE =A0 =A0"ohci-omap3"
>>
>> [sp] Shouldn't we be consistent in using minus/dash and
>> =A0 =A0 =A0underscore in the device names?
>
> Also, can't we avoid once again changing the clock names
> (at least for a while...)?
> Is that really necessary? Can't hwmod use current clock names?
> Because, Linus is sooo happy each time he sees that kind of changes..=
=2E.
>

This was actually earlier comment saying use _ as the convention for
hwmod and runtime pm.
only usbhs_omap uses the hwmod; the ehci and ohci drivers are children
of usbhsh and they get the
data from usbhs. Hence the older name of ehci and ochi drivers are
retained as it is.
  if it is really needed,  to change ehci and ohci driver names , then
i can make it as another patch.


>
> --
> Regards,
> Igor.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
