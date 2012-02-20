From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 01/11] ARM: OMAP: mcbsp: Convert core driver to proper
 platform driver
Date: Mon, 20 Feb 2012 09:20:41 -0800
Message-ID: <20120220172040.GJ18185@atomide.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
 <1329320280-1621-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35310 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab2BTRUv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 12:20:51 -0500
Content-Disposition: inline
In-Reply-To: <1329320280-1621-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120215 07:06]:
> Convert the plat-omap/mcbsp.c driver to be proper platform driver.
> Remove the omap_mcbsp_init function call which was called from
> mach-omap1/2/mcbsp.c to register the platform driver for the just
> created platform device in the same function.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
