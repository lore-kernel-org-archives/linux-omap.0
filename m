From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 18 Nov 2013 11:22:56 -0800
Message-ID: <20131118192256.GU10317@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
 <20131118181110.GM10317@atomide.com>
 <20131118190921.GT13640@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27973 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751666Ab3KRTXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 14:23:01 -0500
Content-Disposition: inline
In-Reply-To: <20131118190921.GT13640@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

* Lee Jones <lee.jones@linaro.org> [131118 11:10]:
> > > Are you Acking this patch by the way?
> > 
> > If this looks acceptable to you guys, I'd like to merge this via my fixes
> > branch this week with your acks if that works for you. That way I can base
> > my omap legacy platform data removal patches on my fixes branch while keep
> > things working for the drivers. Alternatively I can naturally base my
> > legacy data removal on -rc2 too if this gets merged to mainline by then 
> > via the MFD tree.
> 
> I can either send it up for the -rcs, or I can create an immutable
> branch for you to pull from. That way the patch can do in via ARM-SoC
> and MFD and we can let Git sort it out.

OK great, I'd prefer an immutable branch that I can merge in too. Then
you can bundle it with other MFD fixes for the -rc series and send it
in when it suits you :)

Regards,

Tony
