From: Tony Lindgren <tony@atomide.com>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Wed, 20 May 2009 08:13:02 -0700
Message-ID: <20090520151301.GB8308@atomide.com>
References: <200905091745.06435.luke@dashjr.org> <200905121818.13785.luke@dashjr.org> <20090513121219.43206b03.jhnikula@gmail.com> <200905190009.28222.luke@dashjr.org> <20090519094240.dbe5b959.jhnikula@gmail.com> <20090519171521.GA19742@atomide.com> <87bppneuel.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64079 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZETPNM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 11:13:12 -0400
Content-Disposition: inline
In-Reply-To: <87bppneuel.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>, ext-jani.1.nikula@nokia.com
Cc: Jarkko Nikula <jhnikula@gmail.com>, Luke-Jr <luke@dashjr.org>, linux-omap@vger.kernel.org

* Kalle Valo <kalle.valo@iki.fi> [090520 07:11]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> >> > Is anyone actually trying to work on or maintain N8x0 support?
> >> 
> >> I think N8x0 support is a little bit behind from other boards. Lot of
> >> active development is going around on newer and more open platforms like
> >> Beagle and not all patches are necessary tested on N8x0 (or other boards
> >> too!). Of course active hacker base helps to point out breakages.
> >
> > We should try to get the board-n8x0 stuff in shape for mainline maybe
> > the next merge window after this, anybody willing to spend some cycles
> > on preparing the patches against the mainline tree?
> 
> So that's something like three months from now? Hmm. If someone else
> doesn't volunteer I can try to spend some time on this. I would love to
> see n800 and n810 supported in mainline.
> 
> But I cannot make any promises, though. It would be great if someone
> else can step up.

OK, I can help a bit too. Here's what I have in mind we should do:

- Rename the board-*c files to board-n8x0-*.c. I can do this assuming
  people are OK with this.

- Get the gpio-switch replacement completed and into mainline.
  Jani, any news on that? There's a threaad about that at:
  http://thread.gmane.org/gmane.linux.kernel/809866

- Stop using omap specific ATAGs and pass all the gpio etc info
  from platform_data. This should be easy with CONFIG_ATAGS_PROC
  that shows the passed ATAGs in /proc. I can work on this too.

- Get drivers/cbus into mainline. Kalle, do you want to do this?

I guess there's some other clean-up needed too that we can all
work once we have the initial patches working against the mainline.

Regards,

Tony
  
