From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: Gadget regression with u_ether in Linux next
Date: Mon, 19 Sep 2016 11:07:05 +0200
Message-ID: <20160919090705.GA7531@kroah.com>
References: <20160916220355.w6whbd75eqegrz3q@atomide.com>
 <87h99c4804.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87h99c4804.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 19, 2016 at 11:19:07AM +0300, Felipe Balbi wrote:
> 
> Hi Greg,
> 
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> > Hi,
> >
> > Looks like commit c9ffc78745f8 ("usb: gadget: NCM: Protect dev->port_usb
> > using dev->lock") causes hangs for me with Linux next.
> >
> > Reverting c9ffc78745f8 makes the issues go away, some more info below.
> 
> Can you revert this commit from your tree?
> 
> Here's the full commit for reference:
> 
> commit c9ffc78745f89e300fe704348dd8e6800acf4d18
> Author: Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
> Date:   Fri Sep 9 11:30:42 2016 +0200
> 
>     usb: gadget: NCM: Protect dev->port_usb using dev->lock
>     
>     This commit incorporates findings from
>     https://lkml.org/lkml/2016/4/25/594
>     
>     The function has been modified to make sure we hold
>     the dev lock when accessing the net device pointer.
>     
>     Acked-by: Jim Baxter <jim_baxter-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>     Signed-off-by: Harish Jenny K N <harish_kandiga-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>     Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Now reverted, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
