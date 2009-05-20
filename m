From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Wed, 20 May 2009 22:11:00 +0300
Message-ID: <873aazegjf.fsf@litku.valot.fi>
References: <200905091745.06435.luke@dashjr.org>
	<200905121818.13785.luke@dashjr.org>
	<20090513121219.43206b03.jhnikula@gmail.com>
	<200905190009.28222.luke@dashjr.org>
	<20090519094240.dbe5b959.jhnikula@gmail.com>
	<20090519171521.GA19742@atomide.com> <87bppneuel.fsf@litku.valot.fi>
	<20090520151301.GB8308@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42320 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbZETTLC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 15:11:02 -0400
Received: by fxm2 with SMTP id 2so617594fxm.37
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 12:11:02 -0700 (PDT)
In-Reply-To: <20090520151301.GB8308@atomide.com> (Tony Lindgren's message of "Wed\, 20 May 2009 08\:13\:02 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: ext-jani.1.nikula@nokia.com, Jarkko Nikula <jhnikula@gmail.com>, Luke-Jr <luke@dashjr.org>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> OK, I can help a bit too. Here's what I have in mind we should do:
>
> - Rename the board-*c files to board-n8x0-*.c. I can do this assuming
>   people are OK with this.
>
> - Get the gpio-switch replacement completed and into mainline.
>   Jani, any news on that? There's a threaad about that at:
>   http://thread.gmane.org/gmane.linux.kernel/809866
>
> - Stop using omap specific ATAGs and pass all the gpio etc info
>   from platform_data. This should be easy with CONFIG_ATAGS_PROC
>   that shows the passed ATAGs in /proc. I can work on this too.
>
> - Get drivers/cbus into mainline. Kalle, do you want to do this?

Sure, I can work with cbus. I can't give any promises how long it will
take, so don't have your hopes up :)

> I guess there's some other clean-up needed too that we can all
> work once we have the initial patches working against the mainline.

Yes, I agree.

For reference, we discussed a bit about this last September:

http://www.spinics.net/lists/linux-omap/msg05505.html

-- 
Kalle Valo
