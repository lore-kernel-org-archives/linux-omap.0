From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V3 8/8] ARM: OMAP2+: PMU: Add QoS constraint
Date: Thu, 20 Sep 2012 17:14:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209201705570.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com> <1347290626-21164-9-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59905 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab2ITRON (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 13:14:13 -0400
In-Reply-To: <1347290626-21164-9-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi

On Mon, 10 Sep 2012, Jon Hunter wrote:

> When CPU-idle is enabled, the MPU sub-system will transition to low power
> states during idle periods. If the PMU is active and the MPU sub-system
> transitions to a low power state, such as retention, then the PMU context
> will be lost and PMU events will stop. To prevent this from happening add a
> QoS constraint whenever PMU is active to prevent the MPU sub-system from
> transitioning to a low power state.
> 
> By default the PMU QoS constraint is set to -1 so it will not prevent any low
> power states and when the PMU is enabled, it is set to 0, so that only C-state
> C0 is allowed. I plan to re-visit this and relax the constraint to allow some
> low power states, but for now I just wish to ensure PMU is working.
> 
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

This one looks like 3.7-rc material, due to the dependency on Will's PMU 
runtime PM adaptation series, which is unfortunately not yet in the 
stable merge base that I need to use to send these upstream.  Jon, care to 
update and re-send this one after Linus merges the other PMU patches?


- Paul
