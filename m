From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Sat, 27 Oct 2012 15:59:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210271545390.16409@utopia.booyaka.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com> <alpine.DEB.2.00.1210262251020.11258@utopia.booyaka.com> <508BBC59.60504@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42081 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759158Ab2J0P7a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Oct 2012 11:59:30 -0400
In-Reply-To: <508BBC59.60504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Sat, 27 Oct 2012, Santosh Shilimkar wrote:

> Another alternative, which I will recommend to just make use of the
> read*/wrire* instead __raw versions. The barriers are taken care
> already and driver point of view, it is transparent.

Those barriers will disappear if CONFIG_ARM_DMA_MEM_BUFFERABLE is set to 
N, so that's probably not the right thing to do in this case.  The barrier 
here isn't DMA-related, it's needed due to the design of the driver.

In fact the wmb() is probably overkill, since only a compiler reordering 
barrier is needed.  It can probably just be barrier().


- Paul
