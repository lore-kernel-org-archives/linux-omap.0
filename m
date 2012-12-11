From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] net: ethernet: davinci_cpdma: Add boundary for
 rx and tx descriptors
Date: Tue, 11 Dec 2012 13:34:26 -0500 (EST)
Message-ID: <20121211.133426.484976995112519196.davem@davemloft.net>
References: <1355197433-7492-1-git-send-email-mugunthanvnm@ti.com>
	<20121211.133058.2238010228178961245.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:41440 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2LKSe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 13:34:28 -0500
In-Reply-To: <20121211.133058.2238010228178961245.davem@davemloft.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, s.hauer@pengutronix.de

From: David Miller <davem@davemloft.net>
Date: Tue, 11 Dec 2012 13:30:58 -0500 (EST)

> 
> You cannot do this.
> 
> After your changes the driver no longer does any TX flow control.
> 
> It never stops the TX queue and never wakes it up later.
> 
> It just drops packets on the floor when it runs out of descriptors.
> 
> This breaks everything, and in particular packet schedulers and
> TCP.
> 
> I'm not applying this.

And yes I mean that the "fail_tx" path of the transmit method
is bogus too.

You can't signal "out of descriptors" and stop the queue after the
fact.  NETDEV_TX_BUSY is for handling exceptional and extraordinary
conditions, not for the normal queue full handling.

You have to stop the queue before you run out of descriptors.  When
the queue is not stopped, you are telling the core networking that you
absoultely will be able to successfully queue a packet and enough
descriptors are available.

This means the other CPDMA driver needs to be reworked too.
