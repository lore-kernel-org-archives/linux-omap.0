From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [net-next PATCH 1/1] drivers: net: cpsw: enable promiscuous mode
 support
Date: Wed, 22 Jan 2014 23:27:06 +0530
Message-ID: <52E00672.6070004@ti.com>
References: <1390219718-31749-1-git-send-email-mugunthanvnm@ti.com> <20140121.181137.840971123475894969.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56198 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaAVR5M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jan 2014 12:57:12 -0500
In-Reply-To: <20140121.181137.840971123475894969.davem@davemloft.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org

On Wednesday 22 January 2014 07:41 AM, David Miller wrote:
> From: Mugunthan V N <mugunthanvnm@ti.com>
> Date: Mon, 20 Jan 2014 17:38:38 +0530
>
>> +		if (!enable && ((priv->slaves[0].ndev->flags & IFF_PROMISC) ||
>> +				(priv->slaves[1].ndev->flags & IFF_PROMISC))) {
> This assumption that there are exactly 2 slaves is not valid.
>
> Use the appropriate for_each_slave() et al. abstractions to access
> the slaves.
for_each_slave cannot be used here as in dual EMAC, callback will be
called only once for that particular slave. So I will use a for loop
with the slave count so that it can be utilized for any no of slaves.

Regards
Mugunthan V N
