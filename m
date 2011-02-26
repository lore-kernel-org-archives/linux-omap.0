From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/1] twl4030_charger: Make the driver atomic notifier safe
Date: Sat, 26 Feb 2011 19:53:03 +0200
Message-ID: <AANLkTin81FMA-hA5C_1m0XTDkAozceLXdDbqhvqhqt31@mail.gmail.com>
References: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
	<1298634996-25722-2-git-send-email-heikki.krogerus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58272 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab1BZRxE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Feb 2011 12:53:04 -0500
Received: by mail-vx0-f174.google.com with SMTP id 39so2202894vxi.19
        for <linux-omap@vger.kernel.org>; Sat, 26 Feb 2011 09:53:04 -0800 (PST)
In-Reply-To: <1298634996-25722-2-git-send-email-heikki.krogerus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@nokia.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, cbouatmailru@gmail.com

On Fri, Feb 25, 2011 at 1:56 PM, Heikki Krogerus
<heikki.krogerus@nokia.com> wrote:
> This queues work from the otg notification where the
> i2c operations can be safely made. Needed for atomic otg
> notifiers.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@nokia.com>
> Cc: Grazvydas Ignotas <notasas@gmail.com>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>

seems to work fine.
Tested-by: Grazvydas Ignotas <notasas@gmail.com>

> ---
> =A0drivers/power/twl4030_charger.c | =A0 25 +++++++++++++++++++------
> =A01 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_=
charger.c
> index ff1f423..92c16e1 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -71,8 +71,11 @@ struct twl4030_bci {
> =A0 =A0 =A0 =A0struct power_supply =A0 =A0 usb;
> =A0 =A0 =A0 =A0struct otg_transceiver =A0*transceiver;
> =A0 =A0 =A0 =A0struct notifier_block =A0 otg_nb;
> + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_chg;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_bci;
> +
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 event;
> =A0};
>
> =A0/*
> @@ -258,14 +261,11 @@ static irqreturn_t twl4030_bci_interrupt(int ir=
q, void *arg)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> -static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned l=
ong val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *pr=
iv)
> +static void twl4030_bci_usb_work(struct work_struct *data)
> =A0{
> - =A0 =A0 =A0 struct twl4030_bci *bci =3D container_of(nb, struct twl=
4030_bci, otg_nb);
> + =A0 =A0 =A0 struct twl4030_bci *bci =3D container_of(data, struct t=
wl4030_bci, work);
>
> - =A0 =A0 =A0 dev_dbg(bci->dev, "OTG notify %lu\n", val);
> -
> - =A0 =A0 =A0 switch (val) {
> + =A0 =A0 =A0 switch (bci->event) {
> =A0 =A0 =A0 =A0case USB_EVENT_VBUS:
> =A0 =A0 =A0 =A0case USB_EVENT_CHARGER:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4030_charger_enable_usb(bci, true);
> @@ -274,6 +274,17 @@ static int twl4030_bci_usb_ncb(struct notifier_b=
lock *nb, unsigned long val,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4030_charger_enable_usb(bci, false)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> +}
> +
> +static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned l=
ong val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *pr=
iv)
> +{
> + =A0 =A0 =A0 struct twl4030_bci *bci =3D container_of(nb, struct twl=
4030_bci, otg_nb);
> +
> + =A0 =A0 =A0 dev_dbg(bci->dev, "OTG notify %lu\n", val);
> +
> + =A0 =A0 =A0 bci->event =3D val;
> + =A0 =A0 =A0 schedule_work(&bci->work);
>
> =A0 =A0 =A0 =A0return NOTIFY_OK;
> =A0}
> @@ -466,6 +477,8 @@ static int __init twl4030_bci_probe(struct platfo=
rm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail_bci_irq;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 INIT_WORK(&bci->work, twl4030_bci_usb_work);
> +
> =A0 =A0 =A0 =A0bci->transceiver =3D otg_get_transceiver();
> =A0 =A0 =A0 =A0if (bci->transceiver !=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bci->otg_nb.notifier_call =3D twl4030_=
bci_usb_ncb;
> --
> 1.7.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
