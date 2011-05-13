From: "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/5] arm: omap: usb: device name change for the clk
 names of usbhs
Date: Fri, 13 May 2011 14:35:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CF130EB@dbde02.ent.ti.com>
References: <1305122676-27236-1-git-send-email-keshava_mgowda@ti.com>
	<1305122676-27236-2-git-send-email-keshava_mgowda@ti.com>
	<1305122676-27236-3-git-send-email-keshava_mgowda@ti.com>
	<1305122676-27236-4-git-send-email-keshava_mgowda@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CE66B4A@dbde02.ent.ti.com>
	<4DCBC444.10506@compulab.co.il>
 <BANLkTin0hU95m5msSge_TYDPc774i4rGpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTin0hU95m5msSge_TYDPc774i4rGpQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org" <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Munegowda, Keshava=20
> Sent: Friday, May 13, 2011 12:04 PM
> To: Igor Grinberg
> Cc: Premi, Sanjeev; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=20
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Balbi, Felipe; Gadiyar, Anand;=20
> parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
> Subject: Re: [PATCH 3/5] arm: omap: usb: device name change=20
> for the clk names of usbhs
>=20
> On Thu, May 12, 2011 at 4:58 PM, Igor Grinberg=20
> <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> wrote:
> >
> >
> > On 05/12/11 13:49, Premi, Sanjeev wrote:
> >
> >>> -----Original Message-----
> >>> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>> [mailto:linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of
> >>> Munegowda, Keshava
> >>> Sent: Wednesday, May 11, 2011 7:35 PM
> >>> To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>> Cc: Munegowda, Keshava; Balbi, Felipe; Gadiyar, Anand;
> >>> parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
> >>> Subject: [PATCH 3/5] arm: omap: usb: device name change for
> >>> the clk names of usbhs
> >> [snip]...[snip]
> >>
> >>> --- a/drivers/mfd/omap-usb-host.c
> >>> +++ b/drivers/mfd/omap-usb-host.c
> >>> @@ -27,7 +27,7 @@
> >>> =A0#include <linux/gpio.h>
> >>> =A0#include <plat/usb.h>
> >>>
> >>> -#define USBHS_DRIVER_NAME =A0 "usbhs-omap"
> >>> +#define USBHS_DRIVER_NAME =A0 "usbhs_omap"
> >>> =A0#define OMAP_EHCI_DEVICE =A0 =A0"ehci-omap"
> >>> =A0#define OMAP_OHCI_DEVICE =A0 =A0"ohci-omap3"
> >>
> >> [sp] Shouldn't we be consistent in using minus/dash and
> >> =A0 =A0 =A0underscore in the device names?
> >
> > Also, can't we avoid once again changing the clock names
> > (at least for a while...)?
> > Is that really necessary? Can't hwmod use current clock names?
> > Because, Linus is sooo happy each time he sees that kind of=20
> changes....
> >
>=20
> This was actually earlier comment saying use _ as the convention for
> hwmod and runtime pm.
> only usbhs_omap uses the hwmod; the ehci and ohci drivers are childre=
n
> of usbhsh and they get the
> data from usbhs. Hence the older name of ehci and ochi drivers are
> retained as it is.
>   if it is really needed,  to change ehci and ohci driver names , the=
n
> i can make it as another patch.

[sp] A common convetion helps. Another patch will definitely help usabi=
lity.

~sanjeev

>=20
>=20
> >
> > --
> > Regards,
> > Igor.
> >
> >
> --
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
