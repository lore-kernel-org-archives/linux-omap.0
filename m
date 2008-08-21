From: Dmitry Krivoschekov <dmitry.krivoschekov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Thu, 21 Aug 2008 19:09:26 +0400
Message-ID: <48AD8526.8080206@gmail.com>
References: <1219327122-28334-1-git-send-email-swami.iyer@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1219327122-28334-1-git-send-email-swami.iyer-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Swaminathan S <swami.iyer-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Swami,

Swaminathan S wrote:
>     Signed-off-by: Swaminathan S <swami.iyer-l0cyMroinI0@public.gmane.org>
>     
>     This patch implements a tasklet to poll for TX Endpoint FIFO
>     empty status before completing a transfer.  This is required
>     in the context of DaVinci CPPI DMA Tx transfers.  CPPI
>     DMA engine generates completion interrupt before the data
>     actually moves out of TX FIFO 

I guess the DMA interrupt is generated after the data have been moved
from a s/w buffer to TX FIFO.
> and the driver needs to save the
>     Data toggle after ensuring that the FIFO is empty.

why don't rely on an endpoint interrupt which is generated after a USB
transaction is complete?


Thanks,
Dmitry



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
