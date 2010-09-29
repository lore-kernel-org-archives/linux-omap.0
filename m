From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3 v4] musb: AM35x: Workaround for fifo read issue
Date: Wed, 29 Sep 2010 18:59:49 +0400
Message-ID: <4CA35465.4000400@ru.mvista.com>
References: <1285764321-13934-1-git-send-email-ajay.gupta@ti.com> <1285764321-13934-2-git-send-email-ajay.gupta@ti.com> <1285764321-13934-3-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285764321-13934-3-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> AM35x supports only 32bit read operations so we need to have
> workaround for 8bit and 16bit read operations.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

>  drivers/usb/musb/am35x.c     |   30 ++++++++++++++++++++++++++++++
>  drivers/usb/musb/musb_core.c |    2 ++
>  2 files changed, 32 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> index ee0c104..dce99fc 100644
> --- a/drivers/usb/musb/am35x.c
> +++ b/drivers/usb/musb/am35x.c
> @@ -508,3 +508,33 @@ void musb_platform_restore_context(struct musb *musb,
>  	phy_on();
>  }
>  #endif
> +
> +/* AM35x supports only 32bit read operation */
> +void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> +{
> +	void __iomem *fifo = hw_ep->fifo;
> +	u32		val;
> +	int		i;
> +
> +	/* Read for 32bit-aligned destination address */
> +	if (likely((0x03 & (unsigned long) dst) == 0) && len >= 4) {
> +		readsl(fifo, dst, len >> 2);
> +		dst += len & ~0x03;
> +		len &= 0x03;
> +	}
> +	/*
> +	 * Now read the rest 1 to 3 bytes or complete length if

    s/rest/remaining/

> +	 * unaligned address.
> +	 */
> +	if (len > 4) {
> +		for (i = 0; i < (len >> 2); i++) {
> +			*(u32 *) dst = musb_readl(fifo, 0);
> +			dst += 4;
> +		}
> +		len %= 4;

    Why not 'len &= 0x03' like above?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
