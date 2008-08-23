From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v2] OMAP:MUSB: Corrects urb unlink function path
Date: Sat, 23 Aug 2008 09:03:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD5D4D71@dbde02.ent.ti.com>
References: <1219425190-13540-1-git-send-email-ajay.gupta@ti.com>
 <Pine.LNX.4.44L0.0808221330310.2230-100000@iolanthe.rowland.org>,<20080822185439.GB7542@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55574 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbYHWDeg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 23:34:36 -0400
In-Reply-To: <20080822185439.GB7542@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Fri, Aug 22, 2008 at 01:32:12PM -0400, Alan Stern wrote:
> On Fri, 22 Aug 2008 ajay.gupta@ti.com wrote:
>
> > @@ -1785,9 +1784,11 @@ static int musb_urb_enqueue(
> >      * REVISIT consider a dedicated qh kmem_cache, so it's harder
> >      * for bugs in other kernel code to break this driver...
> >      */
>
> This doesn't look right.  After calling spin_lock_irqsave you are in an
> atomic context, so you can't pass mem_flags to kzalloc.
>
> Either move the spin_lock_irqsave after the call to kzalloc or else
> change mem_flags to GFP_ATOMIC.

first one, please.

should be like:

        qh = kzalloc(sizeof *qh, mem_flags);
        if (!qh) {
+               spin_lock_irqsave(&musb->lock, flags);
                usb_hcd_unlink_urb_from_ep(hcd, urb);
+               spin_unlock_irqrestore(&musb->lock, flags);
                return -ENOMEM;
        }

Similarly at the end of enqueue(),
         if (ret != 0) {
+               spin_lock_irqsave(&musb->lock, flags);
                 usb_hcd_unlink_urb_from_ep(hcd, urb);
+               spin_unlock_irqrestore(&musb->lock, flags);
                 kfree(qh);
         }
So hold the musb->lock at the two places in enqueue path and no 
other change. If this is fine then I will resubmit with this modification.

--Ajay
--
balbi