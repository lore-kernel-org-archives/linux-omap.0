From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
Date: Mon, 10 May 2010 10:14:43 -0700
Message-ID: <20100510171443.GE16460@atomide.com>
References: <1273474110-22451-1-git-send-email-svadivu@ti.com>
 <1A2F53DA-903A-4667-A27F-492A3499F7ED@student.utwente.nl>
 <FCCFB4CDC6E5564B9182F639FC356087030428879D@dbde02.ent.ti.com>
 <73F3CED4-60D5-4351-A921-335110542B6F@dominion.thruhere.net>
 <FCCFB4CDC6E5564B9182F639FC356087030428879F@dbde02.ent.ti.com>
 <4BE7ECE4.5070608@gmail.com>
 <4BE8063B.1080709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59601 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab0EJROr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 13:14:47 -0400
Content-Disposition: inline
In-Reply-To: <4BE8063B.1080709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

* Nishanth Menon <nm@ti.com> [100510 06:07]:
> On 05/10/2010 06:24 AM, Nishanth Menon wrote:
> >On 05/10/2010 03:26 AM, Guruswamy, Senthilvadivu wrote:
> >>Tiler support is not yet in OMAP builds. So multi-omap build will NOT break, but would exclude VRFB feature in the build.
> >in which case, is'nt this patch redundant :) ?
> >
> >joking apart, would'nt a set of function pointers be better - the
> >function pointers could be runtime initialized. the rotational functions
> >for Tiler OR vrfb could be used?
> 
> just an addon -> I can see one more potential user of the FEATURES
> framework like dma descriptor feature.. what kind of rotator do we
> have? vrfb Vs tiler..

Guys, let's make one thing clear: We want to make sure things compile
and boot with the omap3_defconfig for all mach-omap2 machines.

This means we must be able to compile in all the drivers (and panels)
without breaking other configurations. This is the standard Linux
behaviour. Any patches that break this will not get merged.

Also, please follow the mailing list etiquette, no more top posting:

http://www.elinux.org/Netiquette

Regards,

Tony
