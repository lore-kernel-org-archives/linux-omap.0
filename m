From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH v4] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Thu, 28 Jul 2011 21:50:17 -0700
Message-ID: <CAFm5wm10MhJOLQ1WcWDSa3CpAQu7FnFcSQ8h4t9ZFJTrCj_V5Q@mail.gmail.com>
References: <1311138718-5072-1-git-send-email-vikram.pandita@ti.com> <20110729044508.GY9069@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39814 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914Ab1G2Euk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 00:50:40 -0400
In-Reply-To: <20110729044508.GY9069@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, gadiyar@ti.com, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>

On Thu, Jul 28, 2011 at 9:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Jul 19, 2011 at 10:11:58PM -0700, Vikram Pandita wrote:
>> From: Anand Gadiyar <gadiyar@ti.com>
>>
>> This patch enables the DMA mode1 RX support.
>> This feature is enabled based on the short_not_ok flag passed from
>> gadget drivers.
>>
>> This will result in a thruput performance gain of around
>> 40% for USB mass-storage/mtp use cases.
>>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> Tested-by: Vikram Pandita <vikram.pandita@ti.com>
>
> applied this one, but I changed commit log and code comment a little
> bit. Here's updated commit:
>
> commit e9c281b174f188adb7950ea8f6a55ca07be69914
> Author: Anand Gadiyar <gadiyar@ti.com>
> Date: =A0 Tue Jul 19 22:11:58 2011 -0700
>
> =A0 =A0usb: musb: Enable DMA mode1 RX for transfers without short pac=
kets
>
> =A0 =A0This patch enables DMA mode1 for the RX patch when we know
> =A0 =A0there won't be any short packets. We check that by looking
> =A0 =A0into the short_no_ok flag, if it's true we enable mode1, other=
wise
> =A0 =A0we use mode0 to transfer the data.
>
> =A0 =A0This will result in a throughput performance gain of around
> =A0 =A040% for USB mass-storage/mtp use cases.
>
> =A0 =A0[ balbi@ti.com : updated commit log and code comments slightly=
 ]

Ack

>
> =A0 =A0Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> =A0 =A0Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> =A0 =A0Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> =A0 =A0Tested-by: Vikram Pandita <vikram.pandita@ti.com>
> =A0 =A0Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_g=
adget.c
> index b67a062..d314f58 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -634,6 +634,7 @@ static void rxstate(struct musb *musb, struct mus=
b_request *req)
> =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len;
> =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr =3D mu=
sb_readw(epio, MUSB_RXCSR);
> =A0 =A0 =A0 =A0struct musb_hw_ep =A0 =A0 =A0 *hw_ep =3D &musb->endpoi=
nts[epnum];
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0use_mode_=
1;
>
> =A0 =A0 =A0 =A0if (hw_ep->is_shared_fifo)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0musb_ep =3D &hw_ep->ep_in;
> @@ -683,6 +684,18 @@ static void rxstate(struct musb *musb, struct mu=
sb_request *req)
>
> =A0 =A0 =A0 =A0if (csr & MUSB_RXCSR_RXPKTRDY) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D musb_readw(epio, MUSB_RXCOUNT)=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable Mode 1 on RX transfers only=
 when short_not_ok flag
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is set. Currently short_not_ok fla=
g is set only from
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* file_storage and f_mass_storage dr=
ivers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (request->short_not_ok && len =3D=3D=
 musb_ep->packet_sz)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_mode_1 =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_mode_1 =3D 0;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (request->actual < request->length)=
 {
> =A0#ifdef CONFIG_USB_INVENTRA_DMA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_buffer_mapped(r=
eq)) {
> @@ -714,37 +727,41 @@ static void rxstate(struct musb *musb, struct m=
usb_request *req)
> =A0 =A0 =A0 =A0 * then becomes usable as a runtime "use mode 1" hint.=
=2E.
> =A0 =A0 =A0 =A0 */
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr |=3D=
 MUSB_RXCSR_DMAENAB;
> -#ifdef USE_MODE1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 csr |=3D=
 MUSB_RXCSR_AUTOCLEAR;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* csr =
|=3D MUSB_RXCSR_DMAMODE; */
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this=
 special sequence (enabling and then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* di=
sabling MUSB_RXCSR_DMAMODE) is required
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to=
 get DMAReq to activate
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_wr=
itew(epio, MUSB_RXCSR,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 csr | MUSB_RXCSR_DMAMODE);
> -#else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mu=
sb_ep->hb_mult &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_ep->hw_ep->rx_double_buffered)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Expe=
rimental: Mode1 works with mass storage use cases */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (use=
_mode_1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0csr |=3D MUSB_RXCSR_AUTOCLEAR;
> -#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_wr=
itew(epio, MUSB_RXCSR, csr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_writew(epio, MUSB_RXCSR, csr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 csr |=3D MUSB_RXCSR_DMAENAB;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_writew(epio, MUSB_RXCSR, csr);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0* this special sequence (enabling and then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0* disabling MUSB_RXCSR_DMAMODE) is required
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0* to get DMAReq to activate
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_writew(epio, MUSB_RXCSR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 csr | MUSB_RXCSR_DMAMODE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_writew(epio, MUSB_RXCSR, csr);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (!musb_ep->hb_mult &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 musb_ep->hw_ep->rx_double_buffered)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 csr |=3D MUSB_RXCSR_AUTOCLEAR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 csr |=3D MUSB_RXCSR_DMAENAB;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 musb_writew(epio, MUSB_RXCSR, csr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (re=
quest->actual < request->length) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0int transfer_size =3D 0;
> -#ifdef USE_MODE1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 transfer_size =3D min(request->length - request->actual,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel->max_len);
> -#else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 transfer_size =3D min(request->length - request->actual,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned)len);
> -#endif
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (transfer_size <=3D musb_ep->packet_sz)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 musb_ep->dma->desired_mode =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (use_mode_1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 transfer_size =3D min(request->length - reques=
t->actual,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel->max_l=
en);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0musb_ep->dma->desired_mode =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 transfer_size =3D min(request->length - reques=
t->actual,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned)len)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 musb_ep->dma->desired_mode =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0use_dma =3D c->channel_program(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0channel,
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
