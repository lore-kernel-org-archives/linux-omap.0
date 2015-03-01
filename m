From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4+: PRM: fix omap4 version of
 prm_save_and_clear_irqen
Date: Sun, 1 Mar 2015 23:53:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503012352490.9987@utopia.booyaka.com>
References: <1425045566-19580-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41222 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbCAXxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2015 18:53:04 -0500
In-Reply-To: <1425045566-19580-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Fri, 27 Feb 2015, Tero Kristo wrote:

> This was incorrectly reading the irq status registers during the save
> and clear, instead of the irq enable. This worked because there is only
> one user for the prcm interrupts currently, namely the io-chain. Whenever
> the function was called, an io-chain interrupt was both pending and
> enabled.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>

Thanks queued for v4.0-rc fixes.


- Paul
