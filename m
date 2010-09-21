From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Tue, 21 Sep 2010 21:56:22 +0530
Message-ID: <AANLkTin+canp9yrE-Jmv=n56dPFByZWU73uaRNBkruP6@mail.gmail.com>
References: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il> <1285084993-27683-4-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34243 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756369Ab0IUQ0t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:26:49 -0400
Received: by mail-ww0-f42.google.com with SMTP id 18so425104wwi.5
        for <linux-omap@vger.kernel.org>; Tue, 21 Sep 2010 09:26:42 -0700 (PDT)
In-Reply-To: <1285084993-27683-4-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 21, 2010 at 9:33 PM, Igor Grinberg <grinberg@compulab.co.il=
> wrote:
> add support for hsusb host ports 1, 2 and on-module usb hub.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> =A0arch/arm/mach-omap2/board-cm-t3517.c | =A0 50 ++++++++++++++++++++=
++++++++++++++

=2E..

> @@ -100,6 +102,47 @@ static void __init cm_t3517_init_rtc(void)
> =A0static inline void cm_t3517_init_rtc(void) {}
> =A0#endif
>
> +#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODU=
LE)

Hi Igor,


Do we really need to make these conditional on the driver being built?

The hardware is present on the board at all times, right?
It should be okay to execute this code independent of whether
the driver is built or not. The device registration can be unconditiona=
l
and if there is no driver present, we won't probe anyway.

(I see some similar logic in usb-ehci.c - probably a good idea to remov=
e
it as well).

- Anand

> +#define HSUSB1_RESET_GPIO =A0 =A0 =A0(146)
> +#define HSUSB2_RESET_GPIO =A0 =A0 =A0(147)
> +#define USB_HUB_RESET_GPIO =A0 =A0 (152)
> +
> +static struct ehci_hcd_omap_platform_data cm_t3517_ehci_pdata __init=
data =3D {
> + =A0 =A0 =A0 .port_mode[0] =3D EHCI_HCD_OMAP_MODE_PHY,
> + =A0 =A0 =A0 .port_mode[1] =3D EHCI_HCD_OMAP_MODE_PHY,
> + =A0 =A0 =A0 .port_mode[2] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
> +
> + =A0 =A0 =A0 .phy_reset =A0=3D true,
> + =A0 =A0 =A0 .reset_gpio_port[0] =A0=3D HSUSB1_RESET_GPIO,
> + =A0 =A0 =A0 .reset_gpio_port[1] =A0=3D HSUSB2_RESET_GPIO,
> + =A0 =A0 =A0 .reset_gpio_port[2] =A0=3D -EINVAL,
> +};
> +
> +static int cm_t3517_init_usbh(void)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D gpio_request(USB_HUB_RESET_GPIO, "usb hub rst")=
;
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("CM-T3517: usb hub rst gpio requ=
est failed: %d\n", err);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(USB_HUB_RESET_GPI=
O, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(USB_HUB_RESET_GPIO, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 usb_ehci_init(&cm_t3517_ehci_pdata);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +static inline int cm_t3517_init_usbh(void)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> +
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
