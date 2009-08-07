From: Tony Lindgren <tony@atomide.com>
Subject: Re: N8x0 to mainline patches
Date: Fri, 7 Aug 2009 10:51:41 +0300
Message-ID: <20090807075135.GU2358@atomide.com>
References: <87zlb95dwx.fsf@litku.valot.fi> <20090713060354.GJ6589@nokia.com> <87vdlx5b3y.fsf@litku.valot.fi> <20090713065341.GC16778@nokia.com> <20090806071038.GE7374@atomide.com> <87y6pwnc9t.fsf@litku.valot.fi> <da94abde0908060927s57a5bdcfxac4e46db16913820@mail.gmail.com> <20090807070317.GR2358@atomide.com> <87prb8m5kp.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62724 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757024AbZHGHvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 03:51:47 -0400
Content-Disposition: inline
In-Reply-To: <87prb8m5kp.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kalle Valo <kalle.valo@iki.fi> [090807 10:44]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> >> > 2. finins and send tusb6010 patch
> >> >
> >> > + omap2-add-usb-tusb6010-c
> >
> > The tusb6010 could be added later on as a fix too if you want to cut
> > down dependencies.
> 
> Good point, I'll send that separately.
> 
> Current n8x0 patches are here:
> 
> http://www.valot.fi/kalle/n8x0/patches/n8x0-add/2009-08-06-19:21/
> 
> They are just pending final testing and I'll send them after I have done
> that, hopefully tonight.
> 
> Tony, on which tree should I base the patches? They are now against
> linus's tree.

Great, yeah it's best to base all the patches against Linus' tree where
possible.

I'll start piling up the omap-upstream queue for the merge window and
will add your serial patch there. So we still have few more days to
deal with the board file patch.

Tony
