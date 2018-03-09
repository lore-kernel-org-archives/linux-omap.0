From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
Date: Fri, 9 Mar 2018 07:39:53 -0600
Message-ID: <20180309133953.GL14921@uda0271908>
References: <20180308204049.29474-1-merlijn@wizzup.org>
 <20180308211525.GJ14921@uda0271908>
 <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 08, 2018 at 11:17:48PM +0100, Merlijn Wajer wrote:
> Hi,
> 
> On 08/03/18 22:15, Bin Liu wrote:
> 
> > please add patch version numbers in the subject when necessary. This
> > helps cross-referencing.
> 
> Will do. I naively assumed that the first patch would implicitly be
> number 1. Will send out v2 now.

Sorry, my bad, I forgot the first patch was a RFC. You are doing it
right.

> 
> >>  
> >> +	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> > 
> > Does it solve the issue if not moving this line? I'd like to have
> > minimum change if possible.
> 
> Yes, it does. The only reason I moved musb_writeb is because I
> understood you wanted me to move both (per previous message: "This can
> be move down to out side of holding the spinlock").

Typically the comments would only applies to the modified code.
Otherwise the comments have to be explicit to avoid confusion.
No worries here anyway, confusion does happen sometimes ;)

Regards,
-Bin.
