From: David Miller <davem@davemloft.net>
Subject: Re: [net PATCH v3 1/1] drivers: net : cpsw: pass proper device
 name while requesting irq
Date: Sun, 22 Dec 2013 18:22:43 -0500 (EST)
Message-ID: <20131222.182243.37050518449066904.davem@davemloft.net>
References: <1387382630-3683-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1387382630-3683-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Wed, 18 Dec 2013 21:33:50 +0530

> During checking the interrupts with "cat /proc/interrupts", it is showing
> device name as (null), this change was done with commit id aa1a15e2d where
> request_irq is changed to devm_request_irq also changing the irq name from
> platform device name to net device name, but the net device is not
> registered at this point with the network frame work, so devm_request_irq
> is called with device name as NULL, by which it is showed as "(null)" in
> "cat /proc/interrupts". So this patch changes back irq name to platform
> device name itself in devm_request_irq so that the device name shows as
> below.
 ...
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

This looks a lot better, thanks.
