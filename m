From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 net-next 1/1] drivers: net: davinci_cpdma:
 acknowledge interrupt properly
Date: Mon, 18 Feb 2013 14:52:27 -0500 (EST)
Message-ID: <20130218.145227.706561380327970223.davem@davemloft.net>
References: <1361175560-600-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49027 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab3BRTw2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Feb 2013 14:52:28 -0500
In-Reply-To: <1361175560-600-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Mon, 18 Feb 2013 13:49:20 +0530

> CPDMA interrupts are not properly acknowledged which leads to interrupt
> storm, only cpdma interrupt 0 is acknowledged in Davinci CPDMA driver.
> Changed cpdma_ctlr_eoi api to acknowledge 1 and 2 interrupts which are
> used for rx and tx respectively.
> 
> Reported-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied, thanks.
