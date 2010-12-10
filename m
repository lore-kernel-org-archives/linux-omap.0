From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: Re: [PATCH 4/5 v4] OMAP2+: musb: HWMOD adaptation for musb.
Date: Fri, 10 Dec 2010 18:58:46 +0530
Message-ID: <AANLkTikNuzO+Yqg7qcPebrsvDWZ-jNR9R6ymrX_yeHbj@mail.gmail.com>
References: <1291985590-27126-1-git-send-email-hemahk@ti.com>
	<20101210130232.GL6027@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48468 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755952Ab0LJN2r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 08:28:47 -0500
In-Reply-To: <20101210130232.GL6027@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Dec 10, 2010 at 6:32 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Dec 10, 2010 at 06:23:10PM +0530, Hema HK wrote:
>>
>> @@ -212,8 +228,28 @@ void __init usb_musb_init(struct omap_mu
>> =A0 =A0 =A0 =A0musb_plat.mode =3D board_data->mode;
>> =A0 =A0 =A0 =A0musb_plat.extvbus =3D board_data->extvbus;
>>
>> - =A0 =A0 =A0 if (platform_device_register(&musb_device) < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register HS=
-USB (MUSB)
>> device\n");
>> + =A0 =A0 =A0 if (cpu_is_omap3517() || cpu_is_omap3505()) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (platform_device_register(&musb_dev=
ice) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unabl=
e to register HS-USB \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (MUSB) device\n");
>> + =A0 =A0 =A0 } else {
>
> you can amend these two branches to the previous one. move the
> platform_device_register() to the previous if (cpu_is_omap3517() ||
> cpu_is_omap3505()) check. similarly with the code below.

Yes... Can be done.

Regards,
Hema
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &musb_plat;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 od =3D omap_device_build(name, bus_id,=
 oh, pdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0sizeof(*pdata), omap_musb_latency,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ARRAY_SIZE(omap_musb_latency),
>> false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(od)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not buil=
d omap_device for %s %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, oh_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D &od->pdev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D &pdev->dev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_device(dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dma_mask =3D &musb_dmamask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->coherent_dma_mask =3D musb_dmamas=
k;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_device(dev);
>> + =A0 =A0 =A0 }
>> }
>>
>> #else
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
