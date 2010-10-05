From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
Date: Tue, 5 Oct 2010 11:15:25 -0700
Message-ID: <20101005181525.GL3117@atomide.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56398 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab0JESPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 14:15:39 -0400
Content-Disposition: inline
In-Reply-To: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [101004 23:37]:
> Hello,
> 
> This v5 series is based on the v3.
> The first two patch is the actual fix for the original problems without any
> major change in the code (only handling the corresponding erratas in the legacy
> way).
> The third patch in the series is optional, and it is implementing (in one patch)
> the errata handling via flags. This patch converts all errata cases to use the
> introduced dma_errata variable via macros.
> 
> Tony: the first two patch need to go for 2.6.36, and if it is possible it shall
> be backported to .33, .34, and .35 as well.

OK, I'll the first two into omap-fixes.

> The final patch in this series is optional, if you feel like you can take it
> (or drop it). AFAIK the upcoming hwmod changes to dma code will also have
> similar feature to handle the erratas.
> I'm not sure what is the schedule for the hwmod conversion of dma...

Let's queue this clean-up with the hwmod patches then.

Regards,

Tony
