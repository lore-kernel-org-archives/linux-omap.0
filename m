From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 1/2] mfd: omap-usb-host: Remove magic numbers for dev dma mask
Date: Wed, 15 Feb 2012 20:31:20 +0530
Message-ID: <CAAL8m4x0w+bRXxCAuUTP=nKg99kjy1xvxuyH0aJF68HsnOuKBw@mail.gmail.com>
References: <1329301414-31003-1-git-send-email-govindraj.raja@ti.com>
 <1329301414-31003-2-git-send-email-govindraj.raja@ti.com> <20120215111704.GA15346@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48407 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2BOPBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 10:01:42 -0500
In-Reply-To: <20120215111704.GA15346@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Wed, Feb 15, 2012 at 4:47 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Feb 15, 2012 at 03:53:33PM +0530, Govindraj.R wrote:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> Remove the hardcoded magic values for dma mask and use the dma
>> mask macros available.
>>
>> CC: Felipe Balbi <balbi@ti.com>
>> CC: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> =A0drivers/mfd/omap-usb-host.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 68ac2c5..3109b0a 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -170,7 +170,7 @@ struct usbhs_hcd_omap {
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> =A0const char usbhs_driver_name[] =3D USBHS_DRIVER_NAME;
>> -static u64 usbhs_dmamask =3D ~(u32)0;
>> +static u64 usbhs_dmamask =3D DMA_BIT_MASK(32);
>>
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> @@ -223,7 +223,7 @@ static struct platform_device *omap_usbhs_alloc_=
child(const char *name,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 child->dev.dma_mask =A0 =A0 =A0 =A0 =A0 =A0 =3D &usbhs_d=
mamask;
>> - =A0 =A0 child->dev.coherent_dma_mask =A0 =A0=3D 0xffffffff;
>> + =A0 =A0 child->dev.coherent_dma_mask =A0 =A0=3D DMA_BIT_MASK(32);
>
> while at that, you could use dma_set_coherent_mask();

Here [1] is the updated patch.

--
Thanks,
Govindraj.R


[1]:

=46rom c4523f02fe96b85245ada1047aa1273c56509e5c Mon Sep 17 00:00:00 200=
1
=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Wed, 15 Feb 2012 12:27:50 +0530
Subject: [PATCH 1/2] mfd: omap-usb-host: Remove magic numbers for dev d=
ma
 mask

Remove the hardcoded magic values for dma mask and use the dma
mask api/macro available.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/mfd/omap-usb-host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 68ac2c5..6800411 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -170,7 +170,7 @@ struct usbhs_hcd_omap {
 /*--------------------------------------------------------------------=
-----*/

 const char usbhs_driver_name[] =3D USBHS_DRIVER_NAME;
-static u64 usbhs_dmamask =3D ~(u32)0;
+static u64 usbhs_dmamask =3D DMA_BIT_MASK(32);

 /*--------------------------------------------------------------------=
-----*/

@@ -223,7 +223,7 @@ static struct platform_device
*omap_usbhs_alloc_child(const char *name,
 	}

 	child->dev.dma_mask		=3D &usbhs_dmamask;
-	child->dev.coherent_dma_mask	=3D 0xffffffff;
+	dma_set_coherent_mask(&child->dev, DMA_BIT_MASK(32));
 	child->dev.parent		=3D dev;

 	ret =3D platform_device_add(child);
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
