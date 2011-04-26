From: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] omap:usb: fixing ehci phy gpio values for omap3
Date: Tue, 26 Apr 2011 08:40:45 -0500
Message-ID: <BANLkTi=fQCRAST1DvJEAnznNnySCv55Yag@mail.gmail.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com> <1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303395763-8702-2-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 21, 2011 at 09:22, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org=
> wrote:
>
> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>
> The gpio of EHCI phy should be 0 instead of 1;
> This fixes the hub enumeration issue in beagle xm board.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Dumb q1: Has this been tested on PandaBoard?
Dumb q2: is'nt it better to introduce polarity e.g.
pdata->ehci_data->reset_gpio_polarity etc? this will allow board files
to describe polarity of pin information to driver which can then be
Phy and any board specific mods(e.g. inverter on the line) independent
completely..

Regards,
Nishanth Menon

> ---
> =A0drivers/mfd/omap-usb-host.c | =A0 =A08 ++++----
> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index b3bb3ac..a12202e 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -718,14 +718,14 @@ static int usbhs_enable(struct device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_request(pdata->eh=
ci_data->reset_gpio_port[0],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0"USB1 PHY reset");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_direction_output
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[0], 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[0], 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[1])) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_request(pdata->eh=
ci_data->reset_gpio_port[1],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0"USB2 PHY reset");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_direction_output
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[1], 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[1], 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Hold the PHY in RESET for enough ti=
me till DIR is high */
> @@ -905,11 +905,11 @@ static int usbhs_enable(struct device *dev)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[0]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_set_value
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[0], 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[0], 1);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->ehci_data->re=
set_gpio_port[1]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_set_value
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[1], 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-=
>ehci_data->reset_gpio_port[1], 1);
> =A0 =A0 =A0 =A0}
>
> =A0end_count:
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
