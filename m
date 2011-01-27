From: Tony Lindgren <tony@atomide.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Thu, 27 Jan 2011 10:41:47 -0800
Message-ID: <20110127184147.GI23412@atomide.com>
References: <20110114194758.GM4957@atomide.com>
 <9ba47985064c771620bac3f4fce6a3b0@mail.gmail.com>
 <126c39969c8e98576bfed2b4d28794b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16673 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab1A0SmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 13:42:19 -0500
Content-Disposition: inline
In-Reply-To: <126c39969c8e98576bfed2b4d28794b3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110117 02:14]:
> >
> > > - omap4430 es1.0 hangs if L2X0 cache is enabled
> > >
> > Will have look at this one on Monday
> >
> I don't see the hang with L2X0 enable on my ES1.0 SDP
> with the latest Linus's head.
> 
> (Mainline 'e78bf5e6cbe837' + Paul's sync timer fix)
> 
> The kernel boots fine.

Just checked this again, for me it hangs at some random point.

Tony
