From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Initial support for OMAP3 Thunder board
Date: Thu, 10 Dec 2009 14:45:56 -0800
Message-ID: <20091210224556.GW24013@atomide.com>
References: <4B21593C.9060409@dmhome.net>
 <20091210204821.GV24013@atomide.com>
 <6cb69d4a0912101430l2555db33y8c56f7f75a1f9dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49702 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762052AbZLJWpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 17:45:53 -0500
Content-Disposition: inline
In-Reply-To: <6cb69d4a0912101430l2555db33y8c56f7f75a1f9dd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Toussaint <daniel@dmhome.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Daniel Toussaint <daniel@dmhome.net> [091210 14:29]:
> >
> > Cool. Can you please split the the patches into following
> > separate patches:
> >
> > 1. Add minimal board support
> > 2. Add defconfig
> > 3. Add ASoC support
> > 4. Add DSS2 support
> 
> Ok, so can the DSS2 related stuff be ifdef-ed in the board file ,or
> does it have to be completely seperated ?

Please leave it out for now as the DSS2 code is not merged yet.

That can be patched in later on, it's best to leave out all the
dependencies from patches when possible.

Also, your patches need to be against current Linus' mainline
tree, not against linux-omap master branch as we already have
DSS2 merged in for testing.

Regards,

Tony
