From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Put in supportframework for PR785 board.
Date: Thu, 4 Dec 2008 09:59:57 -0800
Message-ID: <200812040959.57532.david-b@pacbell.net>
References: <1228386206-13513-1-git-send-email-mani.pillai@ti.com> <20081204111409.GM10209@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E90E7234@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:26380 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751537AbYLDR77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 12:59:59 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E7234@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 04 December 2008, Pillai, Manikandan wrote:
> > > --- a/arch/arm/mach-omap2/mmc-twl4030.c
> > > +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> 
> > it doesn't make sense to build this file if you don't have twl4030 in
> > the board. Better to have something like mmc-tps6235x.c or something
> > like that.
>
> [Pillai, Manikandan] This would be provided in a latter patch that
> provides support for MMC1. I have created another file mmc-pr785.c in
> this patch. I am currently testing and shall send it soon.

Note that current plans for mmc-twl4030.c include
converting it to use the regulator framework after
the current stuff get submitted for mainline.

That should be the last remnant of the twl4030-specific
support in that driver glue.  Ideally there will be no
need for an mmc-pr785 ... so maybe mmc-twl4030.c should
get renamed (again!) to be generic.

Or better yet, your work for pr785 can produce that
fully genericized version.  :)

- Dave

