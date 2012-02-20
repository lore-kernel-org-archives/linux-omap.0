From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 02/11] OMAP: mcbsp: Move core driver under sound/soc/omap
Date: Mon, 20 Feb 2012 09:21:59 -0800
Message-ID: <20120220172159.GK18185@atomide.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
 <1329320280-1621-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36933 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2BTRWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 12:22:05 -0500
Content-Disposition: inline
In-Reply-To: <1329320280-1621-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120215 07:07]:
> In order to consolidate the McBSP driver move it out from
> arch/arm/plat-omap directory under sound/soc/omap/
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for doing this! These may cause some minor merge
conflicts with the planned header clean-up, but those should
be trivial to deal with.

Acked-by: Tony Lindgren <tony@atomide.com>
