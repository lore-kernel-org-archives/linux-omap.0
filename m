From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V3 3/8] ARM: OMAP4: Re-map the CTIs IRQs from MPU to
 DEBUGSS
Date: Thu, 20 Sep 2012 17:00:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209201659470.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com> <1347290626-21164-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59852 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2ITRAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 13:00:48 -0400
In-Reply-To: <1347290626-21164-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi

On Mon, 10 Sep 2012, Jon Hunter wrote:

> In order to use the CTI interrupts inconjunction with the DEBUGSS we need to
> re-map the CTI IRQs to the DEBUGSS HWMOD. The purpose for doing this is so we
> can create a PMU device based upon the DEBUGSS HWMOD and use the CTI interrupts
> for routing ARM PMU events for OMAP4430 devices.
> 
> This is based upon Benoit Cousson's patch [1].
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073319.html
> 
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

As with patch 6 of this series, setting this one aside until we can take a 
closer look at the way we set up the CTI.


- Paul
