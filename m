From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: pandora: fix wifi support
Date: Mon, 20 Dec 2010 17:14:44 -0800
Message-ID: <20101221011444.GG5941@atomide.com>
References: <1292798016-11098-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59607 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864Ab0LUBOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 20:14:47 -0500
Content-Disposition: inline
In-Reply-To: <1292798016-11098-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>

* Grazvydas Ignotas <notasas@gmail.com> [101219 14:33]:
> After commit ed919b0 "mmc: sdio: fix runtime PM anomalies by introducing
> MMC_CAP_POWER_OFF_CARD" it is required to specify MMC_CAP_POWER_OFF_CARD
> to have runtime PM support. As the wl1251 driver expects card to be
> powered down when it's not used, wifi will no longer work after interface
> is brought down at least once without functioning runtime PM.
> 
> Fix this by declaring MMC_CAP_POWER_OFF_CARD for MMC3.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> this is a fix but can go for 2.6.38 as wl1251 runtime PM support
> is only queued for .38 .

Thanks queuing for the merge window.

Regards,

Tony
