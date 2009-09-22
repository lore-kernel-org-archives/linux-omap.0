From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH v2] omap2: ehci: Make Overo compile again
Date: Tue, 22 Sep 2009 10:33:05 -0700
Message-ID: <5e088bd90909221033p7d3f7d81h2e6746f6af3635cc@mail.gmail.com>
References: <20090922150414.GA8975@lixom.net> <20090922161559.GA9767@lixom.net>
	 <20090922171527.GG14890@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:44958 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbZIVRdE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 13:33:04 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1281751qwd.37
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2009 10:33:08 -0700 (PDT)
In-Reply-To: <20090922171527.GG14890@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>

On Tue, Sep 22, 2009 at 10:15 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Olof Johansson <olof@lixom.net> [090922 09:00]:
>> Overo needs the same changes as the other platforms do for the ehci =
changes.
>>
>> Also, roll in the corresponding change from Steve Sakoman fixing the
>> port setup (removing the redundant GPIO setup and switching to port =
2).
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> Sakoman, does this look OK to you?

Yes, looks correct to me.

Acked-by: Steve Sakoman <steve@sakoman.com>


Steve


>> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2=
/board-overo.c
>> index 17f2318..75bdc09 100644
>> --- a/arch/arm/mach-omap2/board-overo.c
>> +++ b/arch/arm/mach-omap2/board-overo.c
>> @@ -384,6 +384,19 @@ static struct platform_device *overo_devices[] =
__initdata =3D {
>> =A0 =A0 =A0 &overo_lcd_device,
>> =A0};
>>
>> +static struct ehci_hcd_omap_platform_data ehci_pdata __initconst =3D=
 {
>> + =A0 =A0 .port_mode[0] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
>> + =A0 =A0 .port_mode[1] =3D EHCI_HCD_OMAP_MODE_PHY,
>> + =A0 =A0 .port_mode[2] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
>> +
>> + =A0 =A0 .chargepump =3D false,
>> + =A0 =A0 .phy_reset =A0=3D true,
>> + =A0 =A0 .reset_gpio_port[0] =A0=3D -EINVAL,
>> + =A0 =A0 .reset_gpio_port[1] =A0=3D OVERO_GPIO_USBH_NRESET,
>> + =A0 =A0 .reset_gpio_port[2] =A0=3D -EINVAL
>> +};
>> +
>> +
>> =A0static void __init overo_init(void)
>> =A0{
>> =A0 =A0 =A0 overo_i2c_init();
>> @@ -391,7 +404,7 @@ static void __init overo_init(void)
>> =A0 =A0 =A0 omap_serial_init();
>> =A0 =A0 =A0 overo_flash_init();
>> =A0 =A0 =A0 usb_musb_init();
>> - =A0 =A0 usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 183, -E=
INVAL);
>> + =A0 =A0 usb_ehci_init(&ehci_pdata);
>> =A0 =A0 =A0 overo_ads7846_init();
>> =A0 =A0 =A0 overo_init_smsc911x();
>>
>> @@ -434,14 +447,6 @@ static void __init overo_init(void)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "could not obtain gpio f=
or "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "OVERO_GPIO_USBH_CPEN\n");
>> -
>> - =A0 =A0 if ((gpio_request(OVERO_GPIO_USBH_NRESET,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "OVERO_GPIO_USBH_NRESE=
T") =3D=3D 0) &&
>> - =A0 =A0 =A0 =A0 (gpio_direction_output(OVERO_GPIO_USBH_NRESET, 1) =
=3D=3D 0))
>> - =A0 =A0 =A0 =A0 =A0 =A0 gpio_export(OVERO_GPIO_USBH_NRESET, 0);
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "could not obtain gpio for=
 "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "OVERO_GPIO_USBH_NRESET\n");
>> =A0}
>>
>> =A0static void __init overo_map_io(void)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
