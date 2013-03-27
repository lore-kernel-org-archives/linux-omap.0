From: David Miller <davem@davemloft.net>
Subject: Re: [net-next PATCH 1/1] drivers: net: ethernet: ti: sparse
 warning fix for ti ethernet drivers
Date: Wed, 27 Mar 2013 13:08:42 -0400 (EDT)
Message-ID: <20130327.130842.1463605715833541825.davem@davemloft.net>
References: <1364378287-11194-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:57995 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab3C0RIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 13:08:44 -0400
In-Reply-To: <1364378287-11194-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Wed, 27 Mar 2013 15:28:07 +0530

> @@ -179,7 +179,7 @@ cpdma_desc_pool_create(struct device *dev, u32 phys, u32 hw_addr,
>  	} else {
>  		pool->cpumap = dma_alloc_coherent(dev, size, &pool->phys,
>  						  GFP_KERNEL);
> -		pool->iomap = pool->cpumap;
> +		pool->iomap = (void __iomem *) pool->cpumap;

This is bogus.

Either a pointer is to RAM, or it's an IOMEM pointer.  It cannot be both.

This indicates that pool->iomap's usage in this scenerio is not correct
at all.

