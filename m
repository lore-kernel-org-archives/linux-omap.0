From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] usb: musb: Fix fifo reads for dm816x with musb_dsps
Date: Thu, 19 Mar 2015 16:30:09 +0300
Message-ID: <550ACF61.5000909@cogentembedded.com>
References: <1426718882-27187-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32973 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbCSNaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 09:30:13 -0400
Received: by ladw1 with SMTP id w1so62058966lad.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 06:30:12 -0700 (PDT)
In-Reply-To: <1426718882-27187-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, George Cherian <george.cherian@ti.com>

Hello.

On 3/19/2015 1:48 AM, Tony Lindgren wrote:

> Looks like dm81xx can only do 32-bit fifo reads like am35x. Let's set
> up musb-dsps with a custom read_fifo function based on the compatible
> flag.

> Otherwise we can get the following errors when starting dhclient on a
> asix USB Ethernet adapter:

> asix 2-1:1.0 eth2: asix_rx_fixup() Bad Header Length 0xffff003c, offset 4

> While at it, let's also remove pointless cast of the driver data.

> Cc: Bin Liu <binmlist@gmail.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: George Cherian <george.cherian@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/usb/musb/musb_dsps.c | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)

> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -655,6 +655,36 @@ static int dsps_musb_reset(struct musb *musb)
>   	return !session_restart;
>   }
>
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
> +		dst += len & ~0x03;
> +		len &= 0x03;
> +	}
> +	/*
> +	 * Now read the remaining 1 to 3 byte or complete length if
> +	 * unaligned address.
> +	 */

   This comment seems misplaced, it belongs before the next *if*.

> +	if (len > 4) {
> +		for (i = 0; i < (len >> 2); i++) {
> +			*(u32 *)dst = musb_readl(fifo, 0);
> +			dst += 4;
> +		}

    Not sure how this is different to using readsl().

> +		len &= 0x03;
> +	}
> +	if (len > 0) {
> +		val = musb_readl(fifo, 0);
> +		memcpy(dst, &val, len);
> +	}
> +}
> +
>   static struct musb_platform_ops dsps_ops = {
>   	.quirks		= MUSB_INDEXED_EP,
>   	.init		= dsps_musb_init,
[...]

WBR, Sergei

