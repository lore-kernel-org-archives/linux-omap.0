From: David Brownell <david-b@pacbell.net>
Subject: Re: pending patch
Date: Fri, 25 Apr 2008 02:35:21 -0700
Message-ID: <200804250235.21910.david-b@pacbell.net>
References: <20080425075245.GX23350@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:41849 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758745AbYDYJfZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Apr 2008 05:35:25 -0400
In-Reply-To: <20080425075245.GX23350@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Friday 25 April 2008, Felipe Balbi wrote:
> Hi Tony and Dave,
> 
> there's this one pending patch [1]. Do you guys have any comments on that
> one?
> 
> Author: Felipe Balbi <felipe.balbi@nokia.com>
> Date:   Thu Apr 17 17:34:20 2008 +0300
> 
>     USB: MUSB: Don't ignore disconnect on suspend
>     
>     As soon as a usb device is disconnect we should
>     fall into a_wait_bcon state, ignoring disconnect
>     irq will prevent this behaviour.

If it passes the OTG tests, fine.  I don't recall how the
HNP handoff's disconnect signaling is handled ... presumably
it's different from some "real" disconnect.



>     Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index c5816a2..019898a 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -659,7 +659,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>                         switch (musb->xceiv.state) {
>  #ifdef CONFIG_USB_OTG
>                         case OTG_STATE_A_SUSPEND:
> -                               musb->ignore_disconnect = 1;
> +                               musb->ignore_disconnect = 0;
>                                 musb_g_reset(musb);
>                                 /* FALLTHROUGH */
>                         case OTG_STATE_A_WAIT_BCON:     /* OPT TD.4.7-900ms */
> 
> [1] http://marc.info/?l=linux-omap&m=120844324526642&w=2
> -- 
> 	- Balbi
> 


