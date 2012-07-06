From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/14] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Fri, 6 Jul 2012 05:36:11 -0700
Message-ID: <20120706123611.GW1122@atomide.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37312 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab2GFMgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:36:16 -0400
Content-Disposition: inline
In-Reply-To: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120706 02:26]:
> Tony,
> 
> Here is the updated series with suggested corrections and generated against
> the latest cleanup-part2 at commit ae6df418. The series adds minimal OMAP5
> support. OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
> L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and hence
> large part of the peripherals are re-used.

Looking good to me, just one cosmetic comment below:
 
>   ARM: OMAP: counter-32k: Select the CR register offset using the IP scheme.
>   ARM: OMAP5: l3: Add l3 error handler support for omap5.
>   ARM: omap2+: board-generic: clean up the irq data from board file.
>   ARM: OMAP5: board-generic: Add device tree support.
>   ARM: OMAP5: Add SMP support.

Can you please remove the trailing period from the patch title lines?
That's not typically used..

Thanks,

Tony
