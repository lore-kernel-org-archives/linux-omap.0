From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH-REWORKED] OMAP: MUSB: MUSB gadget fix
Date: Thu, 29 Nov 2007 10:38:10 -0800
Message-ID: <200711291038.10971.david-b@pacbell.net>
References: <5DF83221BE20114E9C331F665ACBC08003E80033@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08003E80033@dbde01.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 21 November 2007, Pandita, Vikram wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> REWORKED: 
> This fix gets MUSB Gadget Isochronous IN/OUT transfers working
> 
> 1) Isochronous IN transfers working for File Storage Gadget
>    TXCSR register write was wrongly erasing all bits

Could you elaborate a bit?  File storage is only specified to work
with bulk transfers.  Were you just hacking that to become a source
of ISO data?

Normally one just configures the gadgetfs example program to set
up ISO endpoints with known/testable data patterns.


> 2) Isochronous OUT transfers working for File Storage Gadget
>    Minor fix:
>    ./testusb -a -t15 -c1 -s512 -g8
>    Testing with -g8 option will always case OVERFLOW condition
>    which should not be a problem for ISO mode. So check for that
>    condition and not report it as error in gadgetfs test application  

That's wrong.  The reason any fault would "not" be a problem is
because the software which *issues* the transfer request knows
how to handle that fault code.  And an OVERFLOW condition is very
clearly an error that might need attention ... the host goofed up
badly, sending more data than was allowed, in most cases.

 
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> 
> Index: linux-omap/drivers/usb/musb/musb_gadget.c
> ===================================================================
> --- linux-omap.orig/drivers/usb/musb/musb_gadget.c	2007-11-19 18:04:25.000000000 +0530
> +++ linux-omap/drivers/usb/musb/musb_gadget.c	2007-11-21 16:15:50.000000000 +0530
> @@ -111,7 +111,8 @@
>  	req = to_musb_request(request);
>  
>  	list_del(&request->list);
> -	if (req->request.status == -EINPROGRESS)
> +	if (req->request.status == -EINPROGRESS ||
> +		(ep->type == USB_ENDPOINT_XFER_ISOC && req->request.status == -EOVERFLOW))

... so NAK on this part ...

>  		req->request.status = status;
>  	musb = req->musb;
>  
> @@ -499,9 +500,10 @@
>  
>  					DBG(4, "sending zero pkt\n");
>  					musb_writew(epio, MUSB_TXCSR,
> -							MUSB_TXCSR_MODE
> +							csr | MUSB_TXCSR_MODE
>  							| MUSB_TXCSR_TXPKTRDY);
>  					request->zero = 0;
> +					break;

This might be correct, I'd have to look in more detail at that
logic.  I do seem to recall distrusting that code path, in part
because it was awkward to test.

However, your explanation of what's going on doesn't wash.
Every bit in MUSB_TXCSR_P_WZC_BITS is a write-zero-to-clear,
and you're writing zero there.  So ... which bits outside of
that group needed to stay set?

Also, why the "break"?  You added that in this iteration of
the patch, with no comments...

>  				}
>  
>  				/* ... or if not, then complete it */
> 
> ---
> 
