From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH v2 ] McBSP: Fix the free variable update at remove
Date: Wed, 3 Nov 2010 15:10:40 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF76816C@dbde02.ent.ti.com>
References: <1288695814-8915-1-git-send-email-shubhrajyoti@ti.com>
 <20101103112806.c2cfe3d7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40177 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab0KCJkq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 05:40:46 -0400
In-Reply-To: <20101103112806.c2cfe3d7.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com]
> Sent: Wednesday, November 03, 2010 2:58 PM
> To: Datta, Shubhrajyoti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v2 ] McBSP: Fix the free variable update at remove
> 
> On Tue,  2 Nov 2010 16:33:34 +0530
> shubhrajyoti@ti.com wrote:
> 
> > From: Shubhrajyoti D <shubhrajyoti@ti.com>
> >
> > At remove the free variable is wrongly updated.Attempting to solve the
> same.
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Reported-by: Vikram Pandita <vikram.pandita@ti.com>
> > ---
> > -[v2] Instead of using 0/1 use true/false
> >  arch/arm/plat-omap/mcbsp.c |   10 +++++-----
> >  1 files changed, 5 insertions(+), 5 deletions(-)
> ...
> > @@ -1845,7 +1845,7 @@ static int __devexit omap_mcbsp_remove(struct
> platform_device *pdev)
> >
> >  		mcbsp->fclk = NULL;
> >  		mcbsp->iclk = NULL;
> > -		mcbsp->free = 0;
> > +		mcbsp->free = true;
> >  		mcbsp->dev = NULL;
> >  	}
> >
> While reviewing this I noticed that mcbsp->free is not problem at all
> but the memory leak as there is no kfree(mcbsp) here and clk_disables
> looked suspicious too.
> 
> I sent a patch fixing these and your patch changing to use true/false
> flags with mcbsp->free looks worth to do as well. Care to send an
> updated patch on top of mine (i.e no changes to omap_mcbsp_remove
> reguired)?

Makes sense. I agree will send a fresh patch.
> 
> 
> --
> Jarkko
