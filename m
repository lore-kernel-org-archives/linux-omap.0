From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/9] ARM/ASoC: OMAP McBSP device tree support
Date: Fri, 17 Aug 2012 06:10:24 -0700
Message-ID: <20120817131023.GE11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <20120817101838.GB30548@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20245 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab2HQNK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 09:10:29 -0400
Content-Disposition: inline
In-Reply-To: <20120817101838.GB30548@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120817 03:18]:
> On Thu, Aug 16, 2012 at 04:40:59PM +0300, Peter Ujfalusi wrote:
> 
> > in order to be able to add DT support for the McBSP driver which is used on all
> > OMAP platforms (OMAP1/2/3/4/5) I needed to make some cleanups to the stack:
> 
> Tony, are you OK with these changes going via ASoC?

Yes, had one 2420 related question about the FIFO, other than that
I've acked the omap related patches.

Tony
