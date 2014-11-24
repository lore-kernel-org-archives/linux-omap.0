From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/8] usb: musb: Change to use new IO access
Date: Mon, 24 Nov 2014 11:26:09 -0800
Message-ID: <20141124192609.GF2757@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
 <1416855906-13931-5-git-send-email-tony@atomide.com>
 <20141124191202.GH25712@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54086 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaKXT2o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 14:28:44 -0500
Content-Disposition: inline
In-Reply-To: <20141124191202.GH25712@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

* Felipe Balbi <balbi@ti.com> [141124 11:13]:
> On Mon, Nov 24, 2014 at 11:05:02AM -0800, Tony Lindgren wrote:
> > @@ -312,10 +345,40 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> >  		ioread8_rep(fifo, dst, len);
> >  	}
> >  }
> > -#endif
> >  
> > -#endif	/* normal PIO */
> > +/*
> > + * Old style IO functions
> > + */
> > +u8 (*musb_readb)(const void __iomem *addr, unsigned offset);
> > +EXPORT_SYMBOL(musb_readb);
> > +
> > +void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
> > +EXPORT_SYMBOL(musb_writeb);
> >  
> > +u16 (*musb_readw)(const void __iomem *addr, unsigned offset);
> > +EXPORT_SYMBOL(musb_readw);
> > +
> > +void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
> > +EXPORT_SYMBOL(musb_writew);
> > +
> > +u32 (*musb_readl)(const void __iomem *addr, unsigned offset);
> > +EXPORT_SYMBOL(musb_readl);
> > +
> > +void (*musb_writel)(void __iomem *addr, unsigned offset, u32 data);
> > +EXPORT_SYMBOL(musb_writel);
> 
> let's make all these _GPL()

Sure.

Tony

