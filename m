From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/9] ASoC: twl6040: Convert MICBIAS to SUPPLY widget
Date: Thu, 22 Dec 2011 17:32:24 +0000
Message-ID: <20111222173223.GB29622@opensource.wolfsonmicro.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
 <1324571902-16918-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38043 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753226Ab1LVRc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:32:28 -0500
Content-Disposition: inline
In-Reply-To: <1324571902-16918-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 22, 2011 at 06:38:17PM +0200, Peter Ujfalusi wrote:
> In order to avoid breakage change the omap-abe-twl6040
> machine driver's routing.

It'd be better to put this before all the renaming and whatever, it's a
mostly separate change and it'd save having to look at it again.
