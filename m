From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 23:33:56 +0300
Message-ID: <20080829203353.GB14130@frodo>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <200808291112.24443.david-b@pacbell.net> <20080829190048.GA6768@frodo> <200808291305.31639.david-b@pacbell.net> <20080829202114.GA14130@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58155 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbYH2UeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 16:34:17 -0400
Content-Disposition: inline
In-Reply-To: <20080829202114.GA14130@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Fri, Aug 29, 2008 at 11:21:16PM +0300, Felipe Balbi wrote:
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index b398776..bcd0832 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -534,15 +534,15 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>                          */
>                 case OTG_STATE_A_WAIT_BCON:
>                 case OTG_STATE_A_WAIT_VRISE:
> -                       if (musb->vbuserr_retry) {
> -                               musb->vbuserr_retry--;
> +                       while(--vbuserr_retry) {
>                                 ignore = 1;
>                                 devctl |= MUSB_DEVCTL_SESSION;
>                                 musb_writeb(mbase, MUSB_DEVCTL, devctl);
> -                       } else {
> -                               musb->port1_status |=
> -                                         (1 << USB_PORT_FEAT_OVER_CURRENT)
> -                                       | (1 << USB_PORT_FEAT_C_OVER_CURRENT);
> +
> +                               if (vbuserr_retry == 0)

for both I meant musb->vbuserr_retry, sorry.

> +                                       musb->port1_status |=
> +                                               (1 << USB_PORT_FEAT_OVER_CURRENT)
> +                                               | (1 << USB_PORT_FEAT_C_OVER_CURRENT);
>                         }
>                         break;
>                 default:
> 
> Didn't test though. If it works nicely, the same logic will have to go
> to tusb6010.c
> 
> -- 
> balbi

-- 
balbi
