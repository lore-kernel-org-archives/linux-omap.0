From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fail to enter retention
Date: Mon, 17 Nov 2014 10:09:46 -0800
Message-ID: <20141117180944.GG7046@atomide.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
 <20141117162209.GE7046@atomide.com>
 <CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58235 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751283AbaKQSKJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 13:10:09 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [141117 09:14]:
> Hi Tony,
> 
> Thanks very much for suggestions,
> I am able to wakeup the uart (though it takes about 10 seconds till it wakeup).

The wake-up should happen within few hundred milliseconds at most.
Sounds like you're waking on some timer event instead.

> Do you have any suggestion, how I can understnad why it did not get
> into retention and how to continue from this point ?

You need to look if you have some devices blocking deeper
idle states in cm_idlest*_core and cm_idlest_per registers.

The device will automatically idle whatever it can if there
are no blockers. I believe at least EHCI still is blocking,
and MUSB if configured and cable connected.

Regards,

Tony
