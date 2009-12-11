From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Initial support for OMAP3 Thunder board
Date: Fri, 11 Dec 2009 18:41:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B8E@dbde02.ent.ti.com>
References: <4B21593C.9060409@dmhome.net>
 <20091210204821.GV24013@atomide.com>
	 <6cb69d4a0912101430l2555db33y8c56f7f75a1f9dd@mail.gmail.com>
	 <20091210224556.GW24013@atomide.com>
 <6cb69d4a0912110418x2d06acem1408e4b9d2e0a5fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46741 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbZLKNLR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:11:17 -0500
In-Reply-To: <6cb69d4a0912110418x2d06acem1408e4b9d2e0a5fd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Toussaint <daniel@dmhome.net>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Daniel Toussaint wrote:
> On Thu, Dec 10, 2009 at 11:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Daniel Toussaint <daniel@dmhome.net> [091210 14:29]:
> >> >
> >> > Cool. Can you please split the the patches into following
> >> > separate patches:
> >> >
> >> > 1. Add minimal board support
> >> > 2. Add defconfig
> >> > 3. Add ASoC support
> >> > 4. Add DSS2 support
> >>
> >> Ok, so can the DSS2 related stuff be ifdef-ed in the board file ,or
> >> does it have to be completely seperated ?
> >
> > Please leave it out for now as the DSS2 code is not merged yet.
> >
> > That can be patched in later on, it's best to leave out all the
> > dependencies from patches when possible.
> >
> > Also, your patches need to be against current Linus' mainline
> > tree, not against linux-omap master branch as we already have
> > DSS2 merged in for testing.
> Mainline ? ok. I noticed mainline is still using <mach/xxxx> instead
> of <plat/xxxx> and there no support for the ehci reset with GPIO's.
> Or am I looking at the wrong tree ?
> 

ehci-omap is still in Greg's tree; it hasn't reached mainline yet.
You should see it by next week, with the GPIO reset stuff in.

For now, you can take mainline + Greg's usb queue at [1]

- Anand

[1] <http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-all-2.6.32.patch>



