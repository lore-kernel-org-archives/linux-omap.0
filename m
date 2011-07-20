From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Wed, 20 Jul 2011 09:48:53 -0700
Message-ID: <CAFm5wm2ng-fs0OgUG+h1JaF3_LBp93fHw2Vap2oD_j7Ok0NNnw@mail.gmail.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
 <CABb+yY3E69J6vbHNP92k-b6ScFMcU2LY71rqEZMY_9+E+vx=fA@mail.gmail.com>
 <CAFm5wm3zZyMgScH6OqmVVW32mLUJ6OGcmDy+Wz9Gc7EBjsswJQ@mail.gmail.com> <CABb+yY0QsO-rh6Q9nffmPp=4sYi=6Csor1VPdhLvAXd5LJVeRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:32981 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751543Ab1GTQ4e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jul 2011 12:56:34 -0400
In-Reply-To: <CABb+yY0QsO-rh6Q9nffmPp=4sYi=6Csor1VPdhLvAXd5LJVeRg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>, Anand Gadiyar <gadiyar@ti.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>

On Tue, Jul 19, 2011 at 10:53 PM, Jassi Brar <jassisinghbrar@gmail.com>=
 wrote:
>
> On Wed, Jul 20, 2011 at 11:15 AM, Pandita, Vikram <vikram.pandita@ti.=
com> wrote:
> > On Tue, Jul 19, 2011 at 10:34 PM, Jassi Brar <jassisinghbrar@gmail.=
com> wrote:
> >>
> >> On Wed, Jul 20, 2011 at 10:41 AM, Vikram Pandita <vikram.pandita@t=
i.com> wrote:
> >> > From: Anand Gadiyar <gadiyar@ti.com>
> >> >
> >> > This patch enables the DMA mode1 RX support.
> >> > This feature is enabled based on the short_not_ok flag passed fr=
om
> >> > gadget drivers.
> >> >
> >> > This will result in a thruput performance gain of around
> >> > 40% for USB mass-storage/mtp use cases.
> >> >
> >> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> >> > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> >> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >> > Tested-by: Vikram Pandita <vikram.pandita@ti.com>
> >> > ---
> >> > v1 - initial push
> >> > v2 - fixed whitespace issues as per Sergei Shtylyov<sshtylyov@mv=
ista.com> comments
> >> > v3 - restor authorship to Anand Gadiyar <gadiyar@ti.com>
> >> > v4 - adding my signed-off as per Kevin Hilman <khilman@ti.com>
> >> >
> >> > =A0drivers/usb/musb/musb_gadget.c | =A0 68 +++++++++++++++++++++=
+++---------------
> >> > =A01 files changed, 42 insertions(+), 26 deletions(-)
> >>
> >> > @@ -683,6 +684,18 @@ static void rxstate(struct musb *musb, stru=
ct musb_request *req)
> >> >
> >> > =A0 =A0 =A0 =A0if (csr & MUSB_RXCSR_RXPKTRDY) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D musb_readw(epio, MUSB_RXC=
OUNT);
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable Mode 1 for RX transfer=
s only for mass-storage
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* use-case, based on short_not_=
ok flag which is set only
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* from file_storage and f_mass_=
storage drivers
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> > +
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (request->short_not_ok && len =3D=
=3D musb_ep->packet_sz)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_mode_1 =3D 1;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_mode_1 =3D 0;
> >> > +
> >> There is nothing UMS class specific in this patch...
> >> (request->short_not_ok && len =3D=3D musb_ep->packet_sz) may not b=
e the
> >> signature of, and only of, Mass Storage Functions. So maybe removi=
ng
> >> the UMS mention from
> >> comment and change-log is a good idea.
> >
> > Have you grepped the code in drivers/usb/gadget/*.*
> > only UMS sets this flag today and hence the use of this flag.
> >
> > As i understand, on UMS, CSW/data/CBW =A0- the data part size is a =
known
> > size and to be safe that mode=3D1 dma is not stuck up,
> > the mode is enabled only for the gadget driver that sets short_not_=
ok
> > flag - and that today happens to be only UMS.
>
> This *today happens to be only UMS* is my exact point here.
> Can you guarantee no other function driver will ever expect only
> full packet xfers and treat short as errors ?
>

We are trying to test if short_not_ok may not be needed at all. But
all gadgets need to be tested on MUSB for that.
We will need wider help from MUSB maintainer/author(anand g) to
determine if removing short_not_ok is fine on MUSB for _all_ gadgets.

To be safe we only enable for UMS use case today that is definitely
working fine.

Time for Maintainer/author to pitch in !!

>
> >> You might want to add is-ep-type-bulk-out check to the condition
> >> though, so that it doesn't affect
> >> cases that you didn't verify.
> >
> > TX path (IN host), already uses the mode=3D1 DMA and hence the comm=
ent
> > is not valid.
> > This patch just also enables mode=3D1 on RX path.
> Well, then no need for the ep-type check.

where did u see ep-type check? i can see only packet size check. Did i =
miss?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
