From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fail to enter retention
Date: Mon, 17 Nov 2014 12:38:08 -0800
Message-ID: <20141117203808.GH7046@atomide.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
 <20141117162209.GE7046@atomide.com>
 <CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
 <20141117180944.GG7046@atomide.com>
 <CAJ2oMhL5x3nAxTQg36O9-DUfHK9iy-g9+qqN=bYj3Nw7HNjAnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46184 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752045AbaKQUic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 15:38:32 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMhL5x3nAxTQg36O9-DUfHK9iy-g9+qqN=bYj3Nw7HNjAnA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [141117 11:48]:
> >You need to look if you have some devices blocking deeper
> >idle states in cm_idlest*_core and cm_idlest_per registers.
> 
> >The device will automatically idle whatever it can if there
> >are no blockers. I believe at least EHCI still is blocking,
> >and MUSB if configured and cable connected.
> 
> I'll check the registers value, should I then try to modify this
> registers in order to get into retention ?

No, those are read-only status registers. You need idle the
drivers that show as blocking in those registers.

> I will still have to disable serial right ? Maybe some kernel process
> which run in background prevents retention ?

Yes otherwise the UART bits will show as blocking in those
registers.

> Is there some simple way to debug this or do I need to modify these registers ?

Just printing them out in the idle loop most likely will give
you the info you need.

Regards,

Tony
