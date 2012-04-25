From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/6] twl4030_charger: allow charging whenever VBUS is present.
Date: Wed, 25 Apr 2012 14:33:25 +0300
Message-ID: <CANOLnOO2kkyPUrRJiF-EX6NddG746gWvJ_fZrZPr0TC6DkbH9g@mail.gmail.com>
References: <20120425072931.20124.56635.stgit@notabene.brown>
	<20120425073310.20124.15112.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120425073310.20124.15112.stgit-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 25, 2012 at 10:33 AM, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> wrote:
> We currently refuse to charge if the USB ID pin is grounded, even
> though VBUS might be present.
> However some chargers do pull the ID pin low through a resistor which
> might be as low as 47Kohm (openmoko charger).
>
> The documentation is unclear but some experimental evidence suggests
> that when the charge pump provides VBUS that doesn't get reflected in
> HW_CONDITIONS, so we should be safe to ignore the ID pin.

On pandora I see the opposite, STS_VBUS is set regardless of who
drives it, so this will break pandora..

>
> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> ---
>
> =C2=A0drivers/power/twl4030_charger.c | =C2=A0 =C2=A06 +-----
> =C2=A01 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_=
charger.c
> index 0511610..684662a 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -155,11 +155,7 @@ static int twl4030_bci_have_vbus(struct twl4030_=
bci *bci)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(bci->dev, "check_vbus: HW_CONDITIO=
NS %02x\n", hwsts);
>
> - =C2=A0 =C2=A0 =C2=A0 /* in case we also have STS_USB_ID, VBUS is dr=
iven by TWL itself */
> - =C2=A0 =C2=A0 =C2=A0 if ((hwsts & TWL4030_STS_VBUS) && !(hwsts & TW=
L4030_STS_USB_ID))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> -
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 return (hwsts & TWL4030_STS_VBUS);
> =C2=A0}
>
> =C2=A0/*
>
>


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
