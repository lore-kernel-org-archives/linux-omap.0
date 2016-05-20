From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] musb_host: TX DMA cleanup after Tony's patches to
 the MUSB host driver
Date: Fri, 20 May 2016 15:53:21 -0500
Message-ID: <20160520205321.GA7475@uda0271908>
References: <6373243.fXzdouumn8@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6373243.fXzdouumn8-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, May 04, 2016 at 01:49:06AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's 2 patches against the 'next' branch of Felipe's 'usb.git' repo. Tony
> Lindgren's patches from the last year didn't seem complete, so trying to clean
> up the TX DMA patch...
> 
> [1/2] musb_host: move DMA engine check from musb_tx_dma_set_mode_cppi_tusb() to its caller
> [2/2] musb_host: make musb_tx_dma_set_mode_*() *void*

I revised the subject prefix to "usb: musb: host: ..." for both patches.

Regards,
-Bin.

> 
> MBR  ,Sergei
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
