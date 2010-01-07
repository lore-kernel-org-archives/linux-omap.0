From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC PATCH] OMAP: DSS2: RFBI driver: Cleanup "kfifo is full"
 test
Date: Thu, 07 Jan 2010 14:06:19 +0200
Message-ID: <1262865979.2127.34.camel@tubuntu.research.nokia.com>
References: <20091214031816.GA1829@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64475 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0AGMFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 07:05:33 -0500
In-Reply-To: <20091214031816.GA1829@zakalwe.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Heikki Orsila <heikki.orsila@iki.fi>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Mon, 2009-12-14 at 04:18 +0100, ext Heikki Orsila wrote:
> RFBI_CMD_FIFO_LEN_BYTES might not be a power-of-two,
> but kfifo() allocates the size up to the next power of two,
> which makes (RFBI_CMD_FIFO_LEN_BYTES - kfifo_len())
> look very dubious (possibly a negative value!).

But this can never happen, as the code never pushes more than
RFBI_CMD_FIFO_LEN_BYTES bytes into the fifo.

> 
> Notes:
> 
> [1] Not tested nor compiled here
> 
> [2] The removed code compares int with a size_t.
> It looks buggy, because if the full allocated
> size of the fifo is used, the integer comparison
> leads to "always empty space in the fifo".
> Fortunately, the code can never go there, because
> available == 0 will come before negative integer
> values.
> 
> [3] Do we want to use the whole allocated space?

I think if we allocate space for n bytes, we should use n bytes of the
area, even though the underlying mechanism would allocate more. 

> In that case the change should be:
> 
> -               available = RFBI_CMD_FIFO_LEN_BYTES -
> -                       __kfifo_len(rfbi.cmd_fifo);
> +               available = rfbi.cmd_fifo->size - __kfifo_len(rfbi.cmd_fifo);
> 
> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
> ---
>  drivers/video/omap2/dss/rfbi.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index d0b3006..1dbe993 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -1050,14 +1050,11 @@ static void rfbi_push_cmd(struct update_param *p)
>  
>  	while (1) {
>  		unsigned long flags;
> -		int available;
>  
>  		spin_lock_irqsave(rfbi.cmd_fifo->lock, flags);
> -		available = RFBI_CMD_FIFO_LEN_BYTES -
> -			__kfifo_len(rfbi.cmd_fifo);
>  
>  /*		DSSDBG("%d bytes left in fifo\n", available); */
> -		if (available < sizeof(struct update_param)) {
> +		if (__kfifo_len(rfbi.cmd_fifo) >= RFBI_CMD_FIFO_LEN_BYTES) {
>  			DSSDBG("Going to wait because FIFO FULL..\n");
>  			spin_unlock_irqrestore(rfbi.cmd_fifo->lock, flags);
>  			atomic_inc(&rfbi.cmd_fifo_full);

Hmm, I don't think this is correct. The point is to test if there's
enough space for one struct update_param in the fifo. You are testing if
the fifo is full.

 Tomi


