From: David Miller <davem@davemloft.net>
Subject: Re: [net-next PATCH 1/1] drivers: net: davinci_cpdma: remove CRC
 bytes from skb added by CPDMA
Date: Fri, 31 May 2013 17:27:16 -0700 (PDT)
Message-ID: <20130531.172716.1763640633059509974.davem@davemloft.net>
References: <1369894922-27116-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:43306 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab3FAA1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 20:27:17 -0400
In-Reply-To: <1369894922-27116-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Thu, 30 May 2013 11:52:01 +0530

> Additional 4 bytes found in the skb is the CRC calculated by the
> CPDMA hardware, check the CRC bit in CPDMA status field of
> Descriptor and remove the CRC length from the skb. This extra
> 4 byte can be seen when capturing packets using tcpdump.
> This has been tested in TI816x platform.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied.
