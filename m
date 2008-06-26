From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] usb: musb: musb on omap3 has 32 endpoints
Date: Thu, 26 Jun 2008 15:15:58 +0300
Message-ID: <20080626121557.GD12992@atomide.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com> <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com> <20080623111009.GM7741@atomide.com> <20080623111455.GH4414@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BE46969@dbde02.ent.ti.com> <48625971.8060800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50731 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYFZMQK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 08:16:10 -0400
Content-Disposition: inline
In-Reply-To: <48625971.8060800@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com> [080625 17:46]:
> apologies for being late with my comment, and it might be not directly
> related  to the initial patch but,
> 
> Gadiyar, Anand wrote:
> >>>> Fix hdrc_cnf.h for omap3 configuration.
> >>> Does this break the configuration for omap2?
> >>>
> >>> We should set these dynamically if different for omap2 and omap3
> >>> so we can compile both into the same kernel.
> >> Should check omap2430 trm to be sure, maybe someone in TI
> >> could help us with it ?
> >
> > It won't break the 2430. The 2430 has 32 endpoints as well.
> to be more precise, OMAP2430 has 1 control + 15 TX + 15 RX endpoints,
> i.e.total of 31 eps.
> 
> To me it's not clear if these TX/RX endpoints is really independent.  In
> other words,  is it
> really possible to schedule for example 1st TX and 1st RX endpoint at
> the same time (in the same USB frame)?
> 
> If you look at Felipe's patch, it changes a total number of eps from 8
> to 16. In my understanding the driver is now able to schedule only this
> number of endpoints. That is, the driver consider both 1TX and 1RX
> endpoints as the same endpoint that is able to operate for Tx and Rx.
> And, the driver can use only 16 endpoints at the same time, not 31.
> 
> But if all those 15Tx and 15Rx eps are mutually independent then it
> makes sense to treat them in another way, MUSB_C_NUM_EPS should be 31
> plus appropriate modifications to the driver are needed.
> 
> 
> Of course I may be missing something, please correct me if I'm wrong
> with my conclusions.

Let's wait on this until Felipe has the patch for getting the endpoint
configuration from board-*.c files.

Tony

> 
> 
> Thanks,
> Dmitry
> >
> >
> >> Maybe we could bring it via platform_data as well?
> >
> > Yep. That would be good.
> >
> > - Anand
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
