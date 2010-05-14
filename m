From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Sat, 15 May 2010 00:53:34 +0530
Message-ID: <AANLkTim78r8bwcKc4MAqEexam_NJbrEkqNrgoBIknisH@mail.gmail.com>
References: <1273838737-6995-1-git-send-email-ajay.gupta@ti.com>
	 <1273838737-6995-2-git-send-email-ajay.gupta@ti.com>
	 <1273838737-6995-3-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55662 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759245Ab0ENTXg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 15:23:36 -0400
In-Reply-To: <1273838737-6995-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> AM35x supports only 32bit read operations so we need to have
> workaround for 8bit and 16bit read operations.
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
> =A0drivers/usb/musb/am3517.c =A0 =A0| =A0 30 ++++++++++++++++++++++++=
++++++
> =A0drivers/usb/musb/musb_core.c | =A0 =A02 ++
> =A02 files changed, 32 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
> index dd9e883..24bdc2e 100644
> --- a/drivers/usb/musb/am3517.c
> +++ b/drivers/usb/musb/am3517.c
> @@ -515,3 +515,33 @@ void musb_platform_restore_context(struct musb_c=
ontext_registers
> =A0 =A0 =A0 =A0phy_on();
> =A0}
> =A0#endif
> +
> +/* AM35x supports only 32bit read operation */
> +void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> +{
> + =A0 =A0 =A0 void __iomem *fifo =3D hw_ep->fifo;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 val;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 i;
> +
> + =A0 =A0 =A0 /* Read for 32bit-aligned destination address */
> + =A0 =A0 =A0 if ((likely((0x03 & (unsigned long) dst) =3D=3D 0)) && =
len >=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 readsl(fifo, dst, len >> 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst +=3D (len & ~0x03);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len &=3D 0x03;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Now read the rest 1 to 3 bytes or complete length if
check multiline comments style
> + =A0 =A0 =A0 =A0* unaligned address.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (len > 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < (len >> 2); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D musb_readl(fifo=
, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(dst, &val, 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst +=3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len %=3D 4;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (len > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D musb_readl(fifo, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(dst, &val, len);
> + =A0 =A0 =A0 }
> +}
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_cor=
e.c
> index 705cc4a..bc2cf14 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -191,6 +191,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u1=
6 len, const u8 *src)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +#if !defined(CONFIG_MACH_OMAP3517EVM)
> =A0/*
> =A0* Unload an endpoint's FIFO
> =A0*/
> @@ -228,6 +229,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16=
 len, u8 *dst)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readsb(fifo, dst, len);
> =A0 =A0 =A0 =A0}
> =A0}
> +#endif
>
> =A0#endif /* normal PIO */
>
> --
> 1.6.2.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
