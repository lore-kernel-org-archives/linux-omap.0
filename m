From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
Date: Wed, 18 Sep 2013 08:00:13 -0500
Message-ID: <20130918130012.GB3579@kahuna>
References: <1379503416-26318-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34381 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab3IRNAr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Sep 2013 09:00:47 -0400
Content-Disposition: inline
In-Reply-To: <1379503416-26318-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, rnayak@ti.com, tony@atomide.com, marc.zyngier@arm.com, mark.rutland@arm.com

On 16:53-20130918, Sricharan R wrote:
> The realtime counter called master counter, produces the count
> used by the private timer peripherals in the MPU_CLUSTER. The
> CNTFRQ per cpu register is used to denote the frequency of the counter.
> Currently the frequency value is passed from the
> DT file, but this is not scalable when we have other non-DT guest
> OS. This register must be set to the right value by the
> host OS, as this will be propagated to the guests as well.
> 
> More discussions and the reason for adding this in a non-DT
> way can be seen from below.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg93832.html
> 
> So configuring this secure register for all the cpus here.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>

Tested-by: Nishanth Menon <nm@ti.com>
thanks for a better alternative.

[...]

-- 
Regards,
Nishanth Menon
