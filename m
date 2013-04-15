From: David Miller <davem@davemloft.net>
Subject: Re: [net PATCH 1/1] drivers: net: ethernet: cpsw: get slave VLAN
 id from slave node instead of cpsw node
Date: Mon, 15 Apr 2013 14:16:25 -0400 (EDT)
Message-ID: <20130415.141625.856752541111913592.davem@davemloft.net>
References: <1366047088-7146-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:34843 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758Ab3DOSQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 14:16:28 -0400
In-Reply-To: <1366047088-7146-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, mpfj-list@mimc.co.uk

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Mon, 15 Apr 2013 23:01:28 +0530

> Dual EMAC slave VLAN id must be got from slave node instead of cpsw node as
> VLAN id for each slave will be different.
> 
> Reported-by: Mark Jackson <mpfj-list@mimc.co.uk>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied.
