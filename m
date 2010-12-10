From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/9 v3] usb: musb: Remove board_data parameter from
 musb_platform_init()
Date: Fri, 10 Dec 2010 12:29:06 -0800
Message-ID: <20101210202906.GB23759@kroah.com>
References: <1285201660-26309-1-git-send-email-hemahk@ti.com>
 <871v8c629u.fsf@deeprootsystems.com>
 <4D027FEA.9050206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:40714 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757120Ab0LJUab (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 15:30:31 -0500
Content-Disposition: inline
In-Reply-To: <4D027FEA.9050206@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Hema HK <hemahk@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Dec 10, 2010 at 10:30:50PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Kevin Hilman wrote:
> 
> >>Removed the board_data parameter being passed to musb_platform_init function
> >>as board data can be extracted from device structure which is already member of
> >>musb structure.
> 
> >>Signed-off-by: Hema HK <hemahk@ti.com>
> >>Cc: Felipe Balbi <balbi@ti.com>
> >>Cc: Tony Lindgren <tony@atomide.com>
> >>Cc: Kevin Hilman <khilman@deeprootsystems.com>
> >>Cc: Cousson, Benoit <b-cousson@ti.com>
> >>Cc: Paul Walmsley <paul@pwsan.com>
> 
> >For the davinci changes:
> 
> >Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> >Kevin
> 
> >>---
> >> drivers/usb/musb/blackfin.c  |    2 +-
> >> drivers/usb/musb/davinci.c   |    2 +-
> >> drivers/usb/musb/musb_core.c |    2 +-
> >> drivers/usb/musb/musb_core.h |    2 +-
> >> drivers/usb/musb/omap2430.c  |    6 ++++--
> >> drivers/usb/musb/tusb6010.c  |    2 +-
> >> 6 files changed, 9 insertions(+), 7 deletions(-)
> 
>    Grr. This misses changes to da8xx.c and am35x.c -- which breaks
> the compilation for them!
>    Greg, could you drop it from your usb-next branch? Or should we
> send a patch adding these glue layers?

I can't drop patches from a git branch, sorry, it doesn't work that way
anymore.

greg k-h
