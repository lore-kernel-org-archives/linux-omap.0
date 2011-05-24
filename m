From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] USB patches for next merge window
Date: Tue, 24 May 2011 11:52:45 +0300
Message-ID: <20110524085244.GE30799@atomide.com>
References: <20110518110353.GH13908@legolas.emea.dhcp.ti.com>
 <20110518114242.GI13908@legolas.emea.dhcp.ti.com>
 <20110523061346.GD3095@legolas.emea.dhcp.ti.com>
 <20110523101515.8c47e7a2.jhnikula@gmail.com>
 <20110523081524.GL3095@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60579 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754752Ab1EXIws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 May 2011 04:52:48 -0400
Content-Disposition: inline
In-Reply-To: <20110523081524.GL3095@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110523 11:11]:
> On Mon, May 23, 2011 at 10:15:15AM +0300, Jarkko Nikula wrote:
> > On Mon, 23 May 2011 09:14:38 +0300
> > Felipe Balbi <balbi@ti.com> wrote:
> > 
> > > a gentle ping here too. Without this we will have regressions on
> > > ehci/ohci as the pm_runtime patches have gone in via Samuel.
> > > 
> > Does this mean that those regressions happened already when those
> > patches were made if there is pull request dependency?
> 
> not really, no.
> 
> > Remember bisectability is important. And very important if you are
> > bisecting something else but which is dependent on this as then you
> > could mark wrong good/bad points or not able to determine.
> 
> True, true... I just wanted to avoid conflicts as much as possible so
> arch/arm/*omap*/ goes through Tony, and drivers/mfd/* goes through
> Samuel.
> 
> pm_rutime and hwmod conversion aren't really that tightly coupled. As
> long as the arch code is in place, we can do pm_runtime at any time. Not
> sure if it's true the other way around. But one thing is for sure, if
> this pull request isn't taken, then I guess clocks won't enable on
> omap-usbhs...

Looks like these patches are missing acks from Benoit and Paul?
I'd rather not pull them in without the acks. Note that we have
a very short merge window this time, so let's see if we can still
get them in.

Regards,

Tony
