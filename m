From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/3] musb: AM35x: Workaround for fifo read issue
Date: Tue, 18 May 2010 13:59:45 +0400
Message-ID: <4BF26511.2060705@ru.mvista.com>
References: <1274093235-7616-1-git-send-email-ajay.gupta@ti.com> <1274093235-7616-2-git-send-email-ajay.gupta@ti.com> <1274093235-7616-3-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57131 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0ERKAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 06:00:37 -0400
In-Reply-To: <1274093235-7616-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

Hello.

Ajay Kumar Gupta wrote:

> AM35x supports only 32bit read operations so we need to have
> workaround for 8bit and 16bit read operations.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
> Patch created against linus'tree + all musb patches in Greg's queue
> Changes from v2:
> 	- fixed multipline comment style
>  drivers/usb/musb/am3517.c    |   31 +++++++++++++++++++++++++++++++
>  drivers/usb/musb/musb_core.c |    2 ++
>  2 files changed, 33 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
> index b74e664..c68c784 100644
> --- a/drivers/usb/musb/am3517.c
> +++ b/drivers/usb/musb/am3517.c
> @@ -515,3 +515,34 @@ void musb_platform_restore_context(struct musb_context_registers
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
> +	if ((likely((0x03 & (unsigned long) dst) == 0)) && len >= 4) {

    You don't need to put likely() in parens.

> +		readsl(fifo, dst, len >> 2);
> +		dst += (len & ~0x03);

    You don't need parens here as well.

> +		len &= 0x03;
> +	}
> +	/*
> +	 * Now read the rest 1 to 3 bytes or complete length if
> +	 * unaligned address.
> +	 */
> +	if (len > 4) {
> +		for (i = 0; i < (len >> 2); i++) {
> +			val = musb_readl(fifo, 0);
> +			memcpy(dst, &val, 4);

    Can't you do away with memcpy() here?

> +			dst += 4;
> +		}
> +		len %= 4;
> +	}
> +	if (len > 0) {
> +		val = musb_readl(fifo, 0);
> +		memcpy(dst, &val, len);
> +	}
> +}

WBR, Sergei
