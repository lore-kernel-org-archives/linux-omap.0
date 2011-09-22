From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 01/12] OMAP2+: dmtimer: add device names to flck
 nodes
Date: Wed, 21 Sep 2011 18:00:32 -0700
Message-ID: <20110922010031.GR2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37077 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1IVBAd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 21:00:33 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-2-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can be
> retrieved by doing a clk_get with the corresponding device pointers or
> device names.
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com

I've fixed the missing bracket in the email address     ^^^

Tony
