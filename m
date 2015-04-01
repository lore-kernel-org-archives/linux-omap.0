From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] usb: musb: Fix fifo reads for dm816x with musb_dsps
Date: Wed, 1 Apr 2015 14:35:39 -0700
Message-ID: <20150401143539.b5ad81f576101080848147ca@linux-foundation.org>
References: <1426718882-27187-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426718882-27187-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 18 Mar 2015 15:48:02 -0700 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> Looks like dm81xx can only do 32-bit fifo reads like am35x. Let's set
> up musb-dsps with a custom read_fifo function based on the compatible
> flag.
> 
> Otherwise we can get the following errors when starting dhclient on a
> asix USB Ethernet adapter:
> 
> asix 2-1:1.0 eth2: asix_rx_fixup() Bad Header Length 0xffff003c, offset 4
> 
> While at it, let's also remove pointless cast of the driver data.

This breaks my i386 allmodconfig build.

> +/* Similar to am35x, dm81xx support only 32-bit read operation */
> +static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> +{
> +	void __iomem *fifo = hw_ep->fifo;
> +	u32		val;
> +	int		i;
> +
> +	/* Read for 32bit-aligned destination address */
> +	if (likely((0x03 & (unsigned long)dst) == 0) && len >= 4) {
> +		readsl(fifo, dst, len >> 2);

akpm3:/usr/src/linux-4.0-rc6> grep -r readsl arch/x86 
akpm3:/usr/src/linux-4.0-rc6> 

> +		dst += len & ~0x03;
> +		len &= 0x03;
> +	}
> +	/*
> +	 * Now read the remaining 1 to 3 byte or complete length if
> +	 * unaligned address.
> +	 */
> +	if (len > 4) {
> +		for (i = 0; i < (len >> 2); i++) {
> +			*(u32 *)dst = musb_readl(fifo, 0);
> +			dst += 4;
> +		}
> +		len &= 0x03;
> +	}
> +	if (len > 0) {
> +		val = musb_readl(fifo, 0);
> +		memcpy(dst, &val, len);
> +	}
> +}

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
