From: Arun Murthy <arunrmurthy.83@gmail.com>
Subject: Re: [PATCH v3] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Mon, 27 Sep 2010 16:00:35 +0530
Message-ID: <AANLkTik=M9S6iB9YitHevJ0e7X=jxsug6qLkYdGBqmoo@mail.gmail.com>
References: <1285529740-28232-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285529740-28232-1-git-send-email-notasas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Madhusudhan <madhu.cr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 27, 2010 at 1:05 AM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
>
> TWL4030/TPS65950 is a multi-function device with integrated charger,
> which allows charging from AC or USB. This driver enables the
> charger and provides several monitoring functions.
>
> Tested on OMAP3 Pandora board.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> This is v3 of BCI charger driver I first sent nearly a year ago [1].
> I've updated it to use the new OTG notifiers for VBUS notifications,
> however it still is not able to determine charge current to use.
> For that reason there is now a temporary module param to enable USB
> charging, until I can figure out how to get that info from the gadget
> stack (hopefully Felipe can help me here).
On detecting USB plug, the driver is suppose to detect the type of usb
device. Then if the device is a PC(standard host) the charging current
is to be obtained from the usb stack. Hence the driver will have to
wait until the usb stack or driver notifies the current that can be
drawn. The usb stack or driver gets to know the amount of current to
be drawn through the negotiations that happen between the host and
device.

> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, bci);
> +
> + =A0 =A0 =A0 bci->ac.name =3D "twl4030_ac";
> + =A0 =A0 =A0 bci->ac.type =3D POWER_SUPPLY_TYPE_MAINS;
> + =A0 =A0 =A0 bci->ac.properties =3D twl4030_charger_props;
> + =A0 =A0 =A0 bci->ac.num_properties =3D ARRAY_SIZE(twl4030_charger_p=
rops);
> + =A0 =A0 =A0 bci->ac.get_property =3D twl4030_bci_get_property;
> +
> + =A0 =A0 =A0 ret =3D power_supply_register(&pdev->dev, &bci->ac);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to register=
 ac: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_register_ac;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bci->usb.name =3D "twl4030_usb";
> + =A0 =A0 =A0 bci->usb.type =3D POWER_SUPPLY_TYPE_USB;
> + =A0 =A0 =A0 bci->usb.properties =3D twl4030_charger_props;
> + =A0 =A0 =A0 bci->usb.num_properties =3D ARRAY_SIZE(twl4030_charger_=
props);
> + =A0 =A0 =A0 bci->usb.get_property =3D twl4030_bci_get_property;
> +
> + =A0 =A0 =A0 ret =3D power_supply_register(&pdev->dev, &bci->usb);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to register=
 usb: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_register_usb;
> + =A0 =A0 =A0 }
Only AC and USB monitoring is achieved by registering with power supply=
 class.
How is battery monitored?
An instance of battery is to be registered with power supply class in
order to monitor battery.

Thanks and Regards,
Arun R Murthy
---------------------
