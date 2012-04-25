From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 6/6] twl4030-usb: Don't report EVENT_ID when there is VBUS.
Date: Wed, 25 Apr 2012 14:44:54 +0300
Message-ID: <CANOLnOMYqnjopeyEcP3MfuGLinTzmdz9Shoc+cwYGQaDiAiZ-g@mail.gmail.com>
References: <20120425072931.20124.56635.stgit@notabene.brown>
	<20120425073311.20124.58619.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120425073311.20124.58619.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 25, 2012 at 10:33 AM, NeilBrown <neilb@suse.de> wrote:
> Some USB chargers tie the ID pin low via various resistors.
> So they can cause VBUS to be high and ID to be low.
>
> The 'A' end of an OTG cable never receives VBUS, it only ever generat=
es it.
>
> So if we see VBUS and are not generating it, this must be a charger,
> not the A end of an OTG cable, so in that case, ignore the fact that
> ID is low.
>
> This assumes that VBUS_PRES isn't asserted when the charge pump is
> providing VBUS. =C2=A0The document isn't clear on this and some exper=
iments
> suggest that it isn't.

Like already mentioned, this is not what I see on pandora. I don't
know, maybe it's due to some errata or different versions of TWL chip
act different, or perhaps even board design issue, but that's how it
is here.

If you look at git history, this has been changed back and forth
several times, like in commit def6f8b9. Perhaps some platform_data
could be added to handle this, I don't know..

>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>
> =C2=A0drivers/usb/otg/twl4030-usb.c | =C2=A0 19 ++++++++++---------
> =C2=A01 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-=
usb.c
> index bd8fe9b..990400f 100644
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -268,15 +268,16 @@ static enum usb_phy_events twl4030_usb_linkstat=
(struct twl4030_usb *twl)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0STS_HW_CONDITIONS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(twl->d=
ev, "USB link status err %d\n", status);
> - =C2=A0 =C2=A0 =C2=A0 else if (status & (BIT(7) | BIT(2))) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status & (BIT(=
7)))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0twl->vbus_supplied =3D true;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status & BIT(2=
))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 linkstat =3D USB_EVENT_ID;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 linkstat =3D USB_EVENT_VBUS;
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 else if (status & (BIT(7))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We have VBUS so=
 ignore ID_PRES - it is only meaningful
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* as an indi=
cator of an A plug when there is no
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* VBUS.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 twl->vbus_supplied=
 =3D true;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linkstat =3D USB_E=
VENT_VBUS;
> + =C2=A0 =C2=A0 =C2=A0 } else if (status & BIT(2))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linkstat =3D USB_E=
VENT_ID;
> + =C2=A0 =C2=A0 =C2=A0 else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0linkstat =3D U=
SB_EVENT_NONE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d=
; link %d\n",
>
>

--=20
Gra=C5=BEvydas
