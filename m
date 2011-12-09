From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 16:07:33 -0800
Message-ID: <20111209000733.GA9504@kroah.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
 <CAMP44s16cSBw23Py7qUW4Oj60gXKuvmtx-c=urisxecMQEE6Dw@mail.gmail.com>
 <CAB-zwWiH020HfovGF8CA-v9t8Pjc3kLbsXezN6ToLdyC4muHqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38678 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1LIAHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 19:07:41 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A1FA22054F
	for <linux-omap@vger.kernel.org>; Thu,  8 Dec 2011 19:07:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAB-zwWiH020HfovGF8CA-v9t8Pjc3kLbsXezN6ToLdyC4muHqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Thu, Dec 08, 2011 at 02:16:10PM -0600, Ramirez Luna, Omar wrote:
> On Thu, Dec 8, 2011 at 2:11 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Sat, Nov 19, 2011 at 12:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> >> Given that dm timer framework doesn't support request of clocks
> >> by soft | hard irqs because some recent changes, tidspbridge needs
> >> to request its clocks on init and enable/disable them on demand.
> >>
> >> This was first seen on 3.2-rc1.
> >>
> >> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> >
> > Tested-by: Felipe Contreras <felipe.contreras@gmail.com>
> > Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Thanks!
> 
> > Something the commit message didn't mention is that this fixes a nasty
> > continuous loop that happens as soon as you load the module.
> 
> Indeed.
> 
> > Definitely 3.2-fix material IMO :)
> 
> I believe it was pushed to staging-next... I'm rooting so it can be
> pushed to staging-linus :)

As it wasn't originally stated that this was a problem that needed to be
fixed for 3.2, can it wait for 3.3-rc1?  Especially given that there is
still discussion about this?

thanks,

greg k-h
