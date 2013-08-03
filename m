From: David Miller <davem@davemloft.net>
Subject: Re: [net PATCH 1/1] net: ethernet: davinci_emac: drop IRQF_DISABLED
Date: Sat, 03 Aug 2013 11:53:35 -0700 (PDT)
Message-ID: <20130803.115335.755727267007117131.davem@davemloft.net>
References: <1375528185-24507-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52285 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3HCSxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Aug 2013 14:53:35 -0400
In-Reply-To: <1375528185-24507-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Sat, 3 Aug 2013 16:39:45 +0530

> IRQF_DISABLED is a no-op by now and should be removed.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied, thanks.
