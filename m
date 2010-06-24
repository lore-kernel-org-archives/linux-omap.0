From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 4/8] USB: musb: suppress warning about unused flags
Date: Thu, 24 Jun 2010 09:08:57 +0300
Message-ID: <20100624060857.GG8078@nokia.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21561 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0FXGLY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 02:11:24 -0400
Content-Disposition: inline
In-Reply-To: <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "gregkh@suse.de" <gregkh@suse.de>, Jon Povey <jon.povey@racelogic.co.uk>

On Thu, Jun 17, 2010 at 12:40:37PM +0200, ext Ajay Kumar Gupta wrote:
>From: Jon Povey <jon.povey@racelogic.co.uk>
>
>Wrap flags with uninitialized_var() to suppress this:
>
>drivers/usb/musb/cppi_dma.c:1158: warning: 'flags' may be used uninitialized
>in this function
>
>Signed-off-by: Jon Povey <jon.povey@racelogic.co.uk>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>---
> drivers/usb/musb/cppi_dma.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
>index 59dc3d3..e3753ba 100644
>--- a/drivers/usb/musb/cppi_dma.c
>+++ b/drivers/usb/musb/cppi_dma.c
>@@ -1155,7 +1155,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
> 	struct musb_hw_ep	*hw_ep = NULL;
> 	u32			rx, tx;
> 	int			i, index;
>-	unsigned long		flags;
>+	unsigned long		uninitialized_var(flags);

I think the problem here is different. First of all, an IRQ of number 0 
is valid and your locking would be broken in that case. Is there really 
any board that doesn't have the irq line routed ? To me it just looks 
that branching if (irq) is completely bogus.

-- 
balbi

DefectiveByDesign.org
