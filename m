From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: framebuffer on 2430sdp, configuration and bug
Date: Fri, 25 Apr 2008 00:13:13 +0300
Message-ID: <20080424211313.GD8794@kedavra.cpe.vivax.com.br>
References: <1ee641e10804240957o1bbc0011te4af31e1c15d6a4f@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55311 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbYDXVLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 17:11:48 -0400
Content-Disposition: inline
In-Reply-To: <1ee641e10804240957o1bbc0011te4af31e1c15d6a4f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Simon Braunschmidt <sbraunschmidt.linuxlists@googlemail.com>
Cc: linux-omap@vger.kernel.org, arthur.mielimonka@teleca.com, Ronny.Lampert@teleca.com

On Thu, Apr 24, 2008 at 06:57:48PM +0200, Simon Braunschmidt wrote:
> Hi all
> 
> We are running 2.6.24-omap1.
> 
> We have problems to get the framebuffer driver running on a
> SDP2430-VG5.0.1 board. At the moment the LCD stays dark, no penguin to
> be seen, test program not displaying anything, nothing. We tried
> different configurations already but we are not exactly sure which
> Kconfig options are relevant. The sdp2430 defconfig does not work for
> us.
> 
> A .config for a known to be working framebuffer configuration would be
> very helpfull, together with kernel version or git tag.
> 
> Also we are seeing a bug, instability, whatever coming from :
> 
> drivers/video/omap/dispc.c
> 
> in function:
> 
> static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
> 
> This patch adds extra debug output:
> 
> 
> 
> 
> Index: drivers/video/omap/dispc.c
> ===================================================================
> --- drivers/video/omap/dispc.c  (revision 325)
> +++ drivers/video/omap/dispc.c  (working copy)
> @@ -864,8 +864,13 @@
> 
>         if (stat & DISPC_IRQ_MASK_ERROR) {
>                 if (printk_ratelimit()) {
> -                       dev_err(dispc.fbdev->dev, "irq error status %04x\n",
> +                       dev_err(dispc.fbdev->dev, "irq error status %04x",
>                                 stat & 0x7fff);
> +                       printk("%s",(stat & DISPC_IRQ_SYNC_LOST)? "
> DISPC_IRQ_SYNC_LOST " : " ");
> +                       printk("%s",(stat &
> DISPC_IRQ_VID2_FIFO_UNDERFLOW)? "DISPC_IRQ_VID2_FIFO_UNDERFLOW " : "
> ");
> +                       printk("%s",(stat &
> DISPC_IRQ_VID1_FIFO_UNDERFLOW)? "DISPC_IRQ_VID1_FIFO_UNDERFLOW " : "
> ");
> +                       printk("%s",(stat &
> DISPC_IRQ_GFX_FIFO_UNDERFLOW)? "DISPC_IRQ_GFX_FIFO_UNDERFLOW\n" :
> "\n");

It's wrapped and you need to add some spaces before %s in all of them
:-p

In any case, this is only for testing purpose, i think it shouldn't be
applied. I don't have lcd working on 3430sdp as well but never look at
it.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
