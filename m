From: David Miller <davem@davemloft.net>
Subject: Re: [net-next PATCH 0/2] network performance improvement patches
 for TI CPSW and Davinci EMAC drivers
Date: Wed, 27 Mar 2013 14:10:56 -0400 (EDT)
Message-ID: <20130327.141056.184216614500674595.davem@davemloft.net>
References: <1364395320-14973-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1364395320-14973-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Wed, 27 Mar 2013 20:11:58 +0530

> This patch series improves network performance of TI CPSW and Davinci EMAC
> drivers during bulk transfer. During heavy Tx load CPDMA may run out of
> descriptors and tx queue is stopped. When it descriptors are available it
> is reported to the stack via netif_start_queue which doesn't schedule tx
> queue immediately, so there can be dead time during continuous transfer,
> this can be fixed by using netif_wake_queue api which will schedule tx queue
> immediately.

Both applied to 'net'.
