From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Remove OMAP revision check
Date: Thu, 4 Oct 2012 09:36:05 -0700
Message-ID: <20121004163605.GC3874@atomide.com>
References: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
 <1349339236-3622-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37086 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945961Ab2JDQgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 12:36:10 -0400
Content-Disposition: inline
In-Reply-To: <1349339236-3622-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [121004 01:27]:
> The OMAP revision check is not needed since the watchdog bit is not in use
> on 4430 ES1.0 and have no effect when we set the bit. The watchdog need to
> be enabled on all other revisions.

OK seems like you found a local solution :) Thanks for fixing it.

Regards,

Tony
