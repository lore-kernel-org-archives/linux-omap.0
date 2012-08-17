From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 8/9] ARM: OMAP2+: McBSP: Do not create legacy
 devices when booting with DT data
Date: Fri, 17 Aug 2012 06:09:04 -0700
Message-ID: <20120817130904.GD11011@atomide.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20841 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2HQNJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 09:09:09 -0400
Content-Disposition: inline
In-Reply-To: <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> Only create the devices in a legacy way if we do not have the DT data.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
