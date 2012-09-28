From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: DMA: Move plat/dma hearder to
 platform_data/dma-omap
Date: Fri, 28 Sep 2012 07:55:00 -0700
Message-ID: <20120928145459.GZ4840@atomide.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
 <1348839609-10456-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:33549 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757416Ab2I1OzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Sep 2012 10:55:05 -0400
Content-Disposition: inline
In-Reply-To: <1348839609-10456-3-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

* Lokesh Vutla <lokeshvutla@ti.com> [120928 06:41]:
> Move plat/dma.h header to platform_data/dma-omap.h as
> part of the single zImage work.

Hmm there's no platform data in this header, just
exported things for drivers to use. So it should not
be placed into platform_data.

Maybe it should be #include <asm/mach/dma-omap.h> for now?

Regards,

Tony
