From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC] usb: musb: fail unaligned DMA transfers on v1.8 and
 above
Date: Mon, 01 Nov 2010 15:43:08 +0300
Message-ID: <4CCEB5DC.5000509@ru.mvista.com>
References: <1288502759-18618-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288502759-18618-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 31-10-2010 8:25, Anand Gadiyar wrote:

> The Inventra DMA engine in version 1.8 and later of the MUSB
> controller cannot handle DMA addresses that are not aligned
> to a 4 byte boundary. It ends up ignoring the last two bits
> programmed in the DMA_ADDR register. This is a deliberate
> design change in the controller and is documented in the
> programming guide.

> Earlier versions of the controller could handle these
> accesses just fine.

> Fail dma_channel_program if we see an unaligned address when
> using the newer controllers, so that the caller can carry out
> the transfer using PIO mode.
> (Current callers already have this backup path in place).

> Signed-off-by: Anand Gadiyar<gadiyar-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
> Cc: Ming Lei<tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
> Cc: Mike Frysinger<vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
[...]

> Index: mainline/drivers/usb/musb/musbhsdma.c
> ===================================================================
> --- mainline.orig/drivers/usb/musb/musbhsdma.c
> +++ mainline/drivers/usb/musb/musbhsdma.c
[...]
> @@ -167,6 +169,18 @@ static int dma_channel_program(struct dm
>   	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
>   		channel->status == MUSB_DMA_STATUS_BUSY);
>
> +	/*
> +	 * The DMA engine in RTL1.8 and above cannot handle
> +	 * DMA addresses that are not aligned to a 4 byte boundary.
> +	 * It ends up masking the last two bits of the address
> +	 * programmed in DMA_ADDR.
> +	 *
> +	 * Fail such DMA transfers, so that the backup PIO mode
> +	 * can carry out the transfer
> +	 */
> +	if ((musb->hwvers >= MUSB_HWVERS_1800) && (dma_addr %4))

    Also need space after %.

> +		return false;
> +

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
