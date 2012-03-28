From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Wed, 28 Mar 2012 16:23:05 +0530
Message-ID: <CAMrsUdJjwAN4haHOkrGfrpb9HnbsMLyUE4a5aLnCPKC2JdUt_A@mail.gmail.com>
References: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il> <20120328085231.GD18156@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:45478 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758116Ab2C1Kx1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 06:53:27 -0400
Received: by mail-ob0-f171.google.com with SMTP id x4so1509411obh.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 03:53:26 -0700 (PDT)
In-Reply-To: <20120328085231.GD18156@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Igor Grinberg <grinberg@compulab.co.il>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Mar 28, 2012 at 2:22 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Mar 27, 2012 at 04:08:55PM +0200, Igor Grinberg wrote:
>> When PHY reset pin is connected to a GPIO on external GPIO chip
>> (e.g. I2C), we should not call the gpio_set_value() function, but
>> gpio_set_value_cansleep().
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>
> Acked-by: Felipe Balbi <balbi@ti.com>
>
> Keshava, please give us your tested-by. Patch looks fine to me.

Tried on beagle-xm where the smsc hub + smsc95xx ethernet controller
relies gpio nreset sequence for initialization.

Both hub + Ethernet controller get enumerated even after this patch.

Tested-by: Govindraj.R <govindraj.raja@ti.com>

>
>> ---
>> This patch depends on the patch from Keshava [1]:
>> ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
>>
>> [1] http://www.spinics.net/lists/linux-omap/msg66774.html
>>
>> =A0drivers/usb/host/ehci-omap.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-om=
ap.c
>> index 5c78f9e..26e9241 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
>> @@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform=
_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_port=
[0]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(pdata->rese=
t_gpio_port[0], 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep(pd=
ata->reset_gpio_port[0], 1);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(pdata->reset_gpio_port=
[1]))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(pdata->rese=
t_gpio_port[1], 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep(pd=
ata->reset_gpio_port[1], 1);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return 0;
>> --
>> 1.7.3.4
>>
>
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
