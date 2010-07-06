From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Tue, 6 Jul 2010 12:13:14 +0300
Message-ID: <20100706091314.GG3035@nokia.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <20100624060338.GF8078@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21974 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0GFJNa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 05:13:30 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>

Hi,

On Thu, Jun 24, 2010 at 01:17:54PM +0200, ext Gupta, Ajay Kumar wrote:
>Fixes below compilation warning when host only configuration is
>selected.
>drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
>drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

>---
> drivers/usb/musb/musb_core.c |    7 +++----
> 1 files changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>index a8b0440..ed6e1a4 100644
>--- a/drivers/usb/musb/musb_core.c
>+++ b/drivers/usb/musb/musb_core.c
>@@ -704,7 +704,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
> #ifdef CONFIG_USB_MUSB_HDRC_HCD
> 	if (int_usb & MUSB_INTR_CONNECT) {
> 		struct usb_hcd *hcd = musb_to_hcd(musb);
>-		void __iomem *mbase = musb->mregs;
>
> 		handled = IRQ_HANDLED;
> 		musb->is_active = 1;
>@@ -717,9 +716,9 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
> 		if (is_peripheral_active(musb)) {
> 			/* REVISIT HNP; just force disconnect */
> 		}
>-		musb_writew(mbase, MUSB_INTRTXE, musb->epmask);
>-		musb_writew(mbase, MUSB_INTRRXE, musb->epmask & 0xfffe);
>-		musb_writeb(mbase, MUSB_INTRUSBE, 0xf7);
>+		musb_writew(musb->mregs, MUSB_INTRTXE, musb->epmask);
>+		musb_writew(musb->mregs, MUSB_INTRRXE, musb->epmask & 0xfffe);
>+		musb_writeb(musb->mregs, MUSB_INTRUSBE, 0xf7);
> #endif
> 		musb->port1_status &= ~(USB_PORT_STAT_LOW_SPEED
> 					|USB_PORT_STAT_HIGH_SPEED

-- 
balbi

DefectiveByDesign.org
