From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] usb: add back otg_get_transceiver
Date: Fri, 3 Oct 2008 17:30:17 +0300
Message-ID: <20081003143017.GE27798@gandalf.research.nokia.com>
References: <1223043350-17588-1-git-send-email-felipe.balbi@nokia.com> <20081003143132.GG6251@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56906 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbYJCObb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:31:31 -0400
Content-Disposition: inline
In-Reply-To: <20081003143132.GG6251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Oct 03, 2008 at 05:31:34PM +0300, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [081003 17:18]:
> > make twl4030_usb transceiver reach musb.
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/usb/musb/omap2430.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> > index 9d2dcb1..be4e779 100644
> > --- a/drivers/usb/musb/omap2430.c
> > +++ b/drivers/usb/musb/omap2430.c
> > @@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
> >  
> >  int __init musb_platform_init(struct musb *musb)
> >  {
> > +	struct otg_transceiver *x = otg_get_transceiver();
> >  	u32 l;
> >  
> >  #if defined(CONFIG_ARCH_OMAP2430)
> >  	omap_cfg_reg(AE5_2430_USB0HS_STP);
> >  #endif
> >  
> > +	musb->xceiv = *x;
> >  	musb_platform_resume(musb);
> >  
> >  	l = omap_readl(OTG_SYSCONFIG);
> 
> Pushed until you have something in mainline.

Will actually be kept... the change is that otg_get_transceiver will be
generic

-- 
balbi
