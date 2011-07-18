From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Mon, 18 Jul 2011 16:38:59 -0700
Message-ID: <CAFm5wm0+t5DBO98k7krcp8Y+_GKDRT4UkxGWZgQ-jb-6QTQqXg@mail.gmail.com>
References: <1310773489-19184-1-git-send-email-vikram.pandita@ti.com> <4E21746C.4040301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:35910 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751728Ab1GRXjU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 19:39:20 -0400
In-Reply-To: <4E21746C.4040301@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, gadiyar@ti.com, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>

On Sat, Jul 16, 2011 at 4:22 AM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
>
> Hello.
>
> On 16-07-2011 3:44, Vikram Pandita wrote:
>
>> From: Vikram Pandita <vikram.pandita@ti.com>
>
>> This patch enables the DMA mode1 RX support.
>> This feature is enabled based on the short_not_ok flag passed from
>> gadget drivers.
>
>> This will result in a thruput performance gain of around
>> 40% for USB mass-storage/mtp use cases.
>
>> Based on Original work by
>> Anand Gadiyar<gadiyar@ti.com> =A0on 2.6.35 kernel
>
>> Tested on OMAP4460 Blaze board.
>
>> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>> =A0drivers/usb/musb/musb_gadget.c | =A0 42 +++++++++++++++++++++++++=
+++-----------
>> =A01 files changed, 30 insertions(+), 12 deletions(-)
>
>> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_=
gadget.c
>> index 9412410..e643ec2 100644
>> --- a/drivers/usb/musb/musb_gadget.c
>> +++ b/drivers/usb/musb/musb_gadget.c
>> @@ -624,6 +624,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>> =A0/*
>> =A0 * Context: controller locked, IRQs blocked, endpoint selected
>> =A0 */
>> +
>
> =A0 Why?

typo - will fix in v2

>
>> =A0static void rxstate(struct musb *musb, struct musb_request *req)
>> =A0{
>> =A0 =A0 =A0 =A0const u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0epnum =3D req=
->epnum;
>> @@ -714,10 +728,13 @@ static void rxstate(struct musb *musb, struct =
musb_request *req)
>> =A0 =A0 =A0 =A0 * then becomes usable as a runtime "use mode 1" hint=
=2E..
>> =A0 =A0 =A0 =A0 */
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr |=3D=
 MUSB_RXCSR_DMAENAB;
>> -#ifdef USE_MODE1
>> + =A0 =A0 =A0 /* Experimental: Mode1 works with mass storage use cas=
es
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (use_mode_1) {
>
> =A0 No, you can't put the code at the arbitrary indentation levels. P=
lease indent properly.

agree. v2 will address.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csr |=
=3D MUSB_RXCSR_AUTOCLEAR;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* csr=
 |=3D MUSB_RXCSR_DMAMODE; */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_w=
ritew(epio, MUSB_RXCSR, csr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr |=3D=
 MUSB_RXCSR_DMAENAB;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_w=
ritew(epio, MUSB_RXCSR, csr);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* th=
is special sequence (enabling and then
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * di=
sabling MUSB_RXCSR_DMAMODE) is required
>> @@ -725,26 +742,27 @@ static void rxstate(struct musb *musb, struct =
musb_request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0musb_=
writew(epio, MUSB_RXCSR,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0csr | MUSB_RXCSR_DMAMODE);
>> -#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_w=
ritew(epio, MUSB_RXCSR, csr);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!=
musb_ep->hb_mult &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0musb_ep->hw_ep->rx_double_buffered)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0csr |=3D MUSB_RXCSR_AUTOCLEAR;
>> -#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr |=3D=
 MUSB_RXCSR_DMAENAB;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0musb_=
writew(epio, MUSB_RXCSR, csr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (r=
equest->actual< =A0request->length) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0int transfer_size =3D 0;
>> -#ifdef USE_MODE1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (use_mode_1) {
>
> =A0 Same here.

agree. v2 will address.


>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0transfer_size =3D min(request->length - request->actual,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0channel->max_len);
>> -#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_ep->dma->desired_mode =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0transfer_size =3D min(request->length - request->actual,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned)len);
>> -#endif
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (transfer_size <=3D musb_ep->packet_sz)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 musb_ep->dma->desired_mode =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 musb_ep->dma->desired_mode =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_ep->dma->desired_mode =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0use_dma =3D c->channel_program(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0channel,
>
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
