From: Bin Liu <b-liu@ti.com>
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu, 8 Mar 2018 12:22:38 -0600
Message-ID: <20180308182238.GI14921@uda0271908>
References: <20180308093121.11943-1-merlijn@wizzup.org>
 <20180308164613.GH14921@uda0271908>
 <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 08, 2018 at 07:00:16PM +0100, Merlijn Wajer wrote:
> Hi,
> 
> On 08/03/18 17:46, Bin Liu wrote:
> 
> 
> > No need to flush, the work is already cancelled at this point.
> > 
> >> +
> >>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> >> +	musb_platform_exit(musb);
> > 
> > This can be move down to out side of holding the spinlock,
> > 
> >>  	spin_unlock_irqrestore(&musb->lock, flags);
> > 
> > to here.
> 
> Thank you - with I've verified that it works with these changes. I'm
> surprised, because I believe that I had tried this already. I must have
> missed a step in my testing-routine.
> 
> I will send a patch shortly.

Thank you for fixing this up.

Regards,
-Bin.
