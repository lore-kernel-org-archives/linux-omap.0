From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/9] include: platform_data: Platform data header for
 OMAP4 ASoC audio
Date: Fri, 23 Dec 2011 10:37:44 +0000
Message-ID: <20111223103744.GC2834@opensource.wolfsonmicro.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
 <1324582474-18181-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54091 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756537Ab1LWKhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 05:37:48 -0500
Content-Disposition: inline
In-Reply-To: <1324582474-18181-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 22, 2011 at 09:34:26PM +0200, Peter Ujfalusi wrote:

>  include/linux/platform_data/omap-abe-twl6040.h |   48 ++++++++++++++++++++++++

I have to say I'm still really unhappy with the name - it's not like we
should ever be seeing an omap-twl6040 driver but the naming suggests
that there should be.  Bypassing the ABE ought to be a runtime decision
as it's policy and might change with use case.  But anyway:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
