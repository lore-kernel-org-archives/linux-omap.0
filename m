From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v3] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Mon, 27 Sep 2010 12:57:50 +0300
Message-ID: <AANLkTik8v4B_Y44oJBbkFOtJDMhS5zFbgqysj0xKEu-7@mail.gmail.com>
References: <1285529740-28232-1-git-send-email-notasas@gmail.com>
	<20100927061840.GA22913@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100927061840.GA22913@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
List-Id: linux-omap@vger.kernel.org

hello,

On Mon, Sep 27, 2010 at 9:18 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Sun, Sep 26, 2010 at 02:35:40PM -0500, Grazvydas Ignotas wrote:
>>
>> TWL4030/TPS65950 is a multi-function device with integrated charger,
>> which allows charging from AC or USB. This driver enables the
>> charger and provides several monitoring functions.
>>
>> Tested on OMAP3 Pandora board.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>> This is v3 of BCI charger driver I first sent nearly a year ago [1].
>> I've updated it to use the new OTG notifiers for VBUS notifications,
>> however it still is not able to determine charge current to use.
>> For that reason there is now a temporary module param to enable USB
>> charging, until I can figure out how to get that info from the gadge=
t
>> stack (hopefully Felipe can help me here).
>
> You need to send USB_EVENT_ENUMERATED from usb_gadget_vbus_draw(), bu=
t
> wait until the UDC class is finished, then we will have a common
> location to do those stuff.

ok, I hope I can get CCed or notified in some way as I might miss that.

<snip>

>> +
>> + =A0 =A0 =A0 ret =3D request_threaded_irq(bci->irq_bci, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_bci_interrupt, 0, pdev->name, =
bci);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not request=
 irq %d, status
>> %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bci->irq_bci, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_bci_irq;
>> + =A0 =A0 =A0 }
>
> you should register the power_supply before enabling the IRQ lines,
> otherwise you might call power_supply_changed() to a non-existent
> power_supply.

good catch, will do.

<snip>

>> +
>> +#ifdef CONFIG_USB_OTG_UTILS
>> + =A0 =A0 =A0 bci->transceiver =3D otg_get_transceiver();
>> +#endif
>
> this driver should actually depend on that. It won't work without acc=
ess
> to the transceiver anyway.

Well it can still do AC charging fine without OTG stuff.

> Or you add something like:
>
> #ifdef CONFIG_USB_OTG_UTILS
> extern struct otg_transceiver *otg_get_transceiver(void);
> extern void otg_put_transceiver(struct otg_transceiver *);
> #else
> static inline struct otg_transceiver *otg_get_transceiver(void)
> { return NULL; }
> static inline void otg_put_transceiver(struct otg_transceiver *x)
> { }
> #endif

I much prefer that, will send a patch.

>
> to the otg.h and avoid having to use that ifdef here and on any other
> driver. (should be a separate patch though).
>
>> +static struct platform_driver twl4030_bci_driver =3D {
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D twl4030_bci_probe,
>
> drivers should not reference __init sections anymore. If you make thi=
s
> statically linked to the kernel, you'll get section mismatches. It's
> better to make probe __init remove it from here and call
> platform_driver_probe() from module_init();

Tried that and did not get any section mismatches, but will switch
anyway to better match trends.

>
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(twl4030_bci_re=
move),
>> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "twl4030_bci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 },
>> +};
>
> --
> balbi
>
