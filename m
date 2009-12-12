From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: Fix omap3_defconfig build
Date: Sat, 12 Dec 2009 11:19:46 -0800
Message-ID: <20091212191945.GC27594@atomide.com>
References: <1260424192-29012-1-git-send-email-gadiyar@ti.com>
 <20091210061030.GA19668@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51967 "HELO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933552AbZLMCBw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Dec 2009 21:01:52 -0500
Content-Disposition: inline
In-Reply-To: <20091210061030.GA19668@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [091209 22:06]:
> Hi,
> 
> {removing invalid lkml-like addressee}
> 
> On Thu, Dec 10, 2009 at 11:19:52AM +0530, Anand Gadiyar wrote:
> > Select sound codecs to allow this defconfig to build again
> 
> You need to fix the config option dependencies/selects, updating the
> defconfig just papers over the real problem.
> 
> > Also, sync up this defconfig with the generated .configs.
> 
> Good idea, but I suggest holding off until the merge window has closed
> since there are still new options going in. Doing a respin after -rc2
> or so makes more sense. So please redo in a few weeks?
> 
> Traditionally Linus hasn't minded pulling in defconfig updates a little
> later in the release cycles.

This sounds like a good plan. Let's plan on doing a round of defconfig
updates later on during the merge cycle.

Regards,

Tony
