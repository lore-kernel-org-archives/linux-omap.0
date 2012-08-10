From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Switch to use the unified audio driver
 (omap-twl4030) for selected boards
Date: Thu, 9 Aug 2012 23:31:06 -0700
Message-ID: <20120810063105.GQ11011@atomide.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
 <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11764 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab2HJGbK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Aug 2012 02:31:10 -0400
Content-Disposition: inline
In-Reply-To: <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, devicetree-discuss@lists.ozlabs.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120808 02:54]:
> These boards have similar audio setup and they can all use the same driver
> for audio support if it is enabled in the kernel config.

After the naming changes suggested by Igor:

Acked-by: Tony Lindgren <tony@atomide.com>
