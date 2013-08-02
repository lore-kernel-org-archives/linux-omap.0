From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: cpsw: drop IRQF_DISABLED
Date: Fri, 02 Aug 2013 14:54:07 -0700 (PDT)
Message-ID: <20130802.145407.1085542888053882863.davem@davemloft.net>
References: <1375429450-25454-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42225 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab3HBVyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 17:54:08 -0400
In-Reply-To: <1375429450-25454-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: mugunthanvnm@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>
Date: Fri, 2 Aug 2013 10:44:10 +0300

> IRQF_DISABLED is a no-op by now and should be
> removed.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied.
