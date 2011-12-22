From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/9] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Thu, 22 Dec 2011 13:04:54 +0000
Message-ID: <20111222130453.GQ4546@opensource.wolfsonmicro.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com>
 <1324557768-8216-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44824 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752629Ab1LVNE5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 08:04:57 -0500
Content-Disposition: inline
In-Reply-To: <1324557768-8216-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 02:42:40PM +0200, Peter Ujfalusi wrote:

>  include/linux/platform_data/omap-abe-twl6040.h |   48 ++++++++++++++++++++++++

omap-abe-mcpdm-twl6040 please.  Seriously, just drop the abe - it's not
an optional feature of the OMAP and the names are getting quite long.
