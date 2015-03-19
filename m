From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: Fix fifo reads for dm816x with musb_dsps
Date: Thu, 19 Mar 2015 08:45:44 -0700
Message-ID: <20150319154543.GC31346@atomide.com>
References: <1426718882-27187-1-git-send-email-tony@atomide.com>
 <550ACF61.5000909@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550ACF61.5000909-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org> [150319 06:30]:
> On 3/19/2015 1:48 AM, Tony Lindgren wrote:
> 
> >Looks like dm81xx can only do 32-bit fifo reads like am35x. Let's set
> >up musb-dsps with a custom read_fifo function based on the compatible
> >flag.
...
> >--- a/drivers/usb/musb/musb_dsps.c
> >+++ b/drivers/usb/musb/musb_dsps.c
> >+/* Similar to am35x, dm81xx support only 32-bit read operation */
> >+static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> >+{
> >+	void __iomem *fifo = hw_ep->fifo;
> >+	u32		val;
> >+	int		i;
> >+
> >+	/* Read for 32bit-aligned destination address */
> >+	if (likely((0x03 & (unsigned long)dst) == 0) && len >= 4) {
> >+		readsl(fifo, dst, len >> 2);
> >+		dst += len & ~0x03;
> >+		len &= 0x03;
> >+	}
> >+	/*
> >+	 * Now read the remaining 1 to 3 byte or complete length if
> >+	 * unaligned address.
> >+	 */
> 
>   This comment seems misplaced, it belongs before the next *if*.
> 
> >+	if (len > 4) {
> >+		for (i = 0; i < (len >> 2); i++) {
> >+			*(u32 *)dst = musb_readl(fifo, 0);
> >+			dst += 4;
> >+		}
> 
>    Not sure how this is different to using readsl().
> 
> >+		len &= 0x03;
> >+	}
> >+	if (len > 0) {
> >+		val = musb_readl(fifo, 0);
> >+		memcpy(dst, &val, len);
> >+	}
> >+}

Indeed, thanks for looking at it. That function in the TI kernel probably
had something else for the 32-bit aligned case that got swapped to use
readsl().

Looks like the following works just fine for me with a USB Ethernet
and variable size ping test:

static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
{
	void __iomem *fifo = hw_ep->fifo;

	if (len >= 4) {
		readsl(fifo, dst, len >> 2);
		dst += len & ~0x03;
		len &= 0x03;
	}

	/* Read any remaining 1 to 3 bytes */                                                                                
	if (len > 0) {
		u32 val = musb_readl(fifo, 0);
		memcpy(dst, &val, len);
	}
}

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
