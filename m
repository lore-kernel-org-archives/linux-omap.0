From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] net: ethernet: davinci_cpdma: Add boundary for
 rx and tx descriptors
Date: Tue, 11 Dec 2012 13:57:59 -0500 (EST)
Message-ID: <20121211.135759.1010213285970148974.davem@davemloft.net>
References: <20121211.133058.2238010228178961245.davem@davemloft.net>
	<20121211.133426.484976995112519196.davem@davemloft.net>
	<1355252096.27891.130.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:41708 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab2LKS6B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 13:58:01 -0500
In-Reply-To: <1355252096.27891.130.camel@edumazet-glaptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: erdnetdev@gmail.com
Cc: mugunthanvnm@ti.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, s.hauer@pengutronix.de

From: Eric Dumazet <erdnetdev@gmail.com>
Date: Tue, 11 Dec 2012 10:54:56 -0800

> Suggested fix : add a TCQ_F_MQSLAVE flag to allow dequeue_skb() to test
> the netif_xmit_frozen_or_stopped() status _before_ dequeing packet from
> qdisc.

This sounds fine to me.
