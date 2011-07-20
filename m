From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Wed, 20 Jul 2011 11:23:48 +0530
Message-ID: <CABb+yY0QsO-rh6Q9nffmPp=4sYi=6Csor1VPdhLvAXd5LJVeRg@mail.gmail.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com>
	<CABb+yY3E69J6vbHNP92k-b6ScFMcU2LY71rqEZMY_9+E+vx=fA@mail.gmail.com>
	<CAFm5wm3zZyMgScH6OqmVVW32mLUJ6OGcmDy+Wz9Gc7EBjsswJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:38621 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab1GTFye convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 01:54:34 -0400
In-Reply-To: <CAFm5wm3zZyMgScH6OqmVVW32mLUJ6OGcmDy+Wz9Gc7EBjsswJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, gadiyar@ti.com, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>

On Wed, Jul 20, 2011 at 11:15 AM, Pandita, Vikram <vikram.pandita@ti.co=
m> wrote:
> On Tue, Jul 19, 2011 at 10:34 PM, Jassi Brar <jassisinghbrar@gmail.co=
m> wrote:
>>
>> On Wed, Jul 20, 2011 at 10:41 AM, Vikram Pandita <vikram.pandita@ti.=
com> wrote:
>> > From: Anand Gadiyar <gadiyar@ti.com>
>> >
>> > This patch enables the DMA mode1 RX support.
>> > This feature is enabled based on the short_not_ok flag passed from
>> > gadget drivers.
>> >
>> > This will result in a thruput performance gain of around
>> > 40% for USB mass-storage/mtp use cases.
>> >
>> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
>> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> > Tested-by: Vikram Pandita <vikram.pandita@ti.com>
>> > ---
>> > v1 - initial push
>> > v2 - fixed whitespace issues as per Sergei Shtylyov<sshtylyov@mvis=
ta.com> comments
>> > v3 - restor authorship to Anand Gadiyar <gadiyar@ti.com>
>> > v4 - adding my signed-off as per Kevin Hilman <khilman@ti.com>
>> >
>> > =C2=A0drivers/usb/musb/musb_gadget.c | =C2=A0 68 +++++++++++++++++=
+++++++---------------
>> > =C2=A01 files changed, 42 insertions(+), 26 deletions(-)
>>
>> > @@ -683,6 +684,18 @@ static void rxstate(struct musb *musb, struct=
 musb_request *req)
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (csr & MUSB_RXCSR_RXPKTRDY) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D mus=
b_readw(epio, MUSB_RXCOUNT);
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Enable =
Mode 1 for RX transfers only for mass-storage
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* use-cas=
e, based on short_not_ok flag which is set only
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from fi=
le_storage and f_mass_storage drivers
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (request->sh=
ort_not_ok && len =3D=3D musb_ep->packet_sz)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 use_mode_1 =3D 1;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 use_mode_1 =3D 0;
>> > +
>> There is nothing UMS class specific in this patch...
>> (request->short_not_ok && len =3D=3D musb_ep->packet_sz) may not be =
the
>> signature of, and only of, Mass Storage Functions. So maybe removing
>> the UMS mention from
>> comment and change-log is a good idea.
>
> Have you grepped the code in drivers/usb/gadget/*.*
> only UMS sets this flag today and hence the use of this flag.
>
> As i understand, on UMS, CSW/data/CBW =C2=A0- the data part size is a=
 known
> size and to be safe that mode=3D1 dma is not stuck up,
> the mode is enabled only for the gadget driver that sets short_not_ok
> flag - and that today happens to be only UMS.

This *today happens to be only UMS* is my exact point here.
Can you guarantee no other function driver will ever expect only
full packet xfers and treat short as errors ?


>> You might want to add is-ep-type-bulk-out check to the condition
>> though, so that it doesn't affect
>> cases that you didn't verify.
>
> TX path (IN host), already uses the mode=3D1 DMA and hence the commen=
t
> is not valid.
> This patch just also enables mode=3D1 on RX path.
Well, then no need for the ep-type check.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
