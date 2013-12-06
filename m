From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/1] drivers: net : cpsw: Use netdev_name while
 requesting irq
Date: Fri, 06 Dec 2013 15:46:40 -0500 (EST)
Message-ID: <20131206.154640.2274056773488827363.davem@davemloft.net>
References: <1386313107-8597-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1386313107-8597-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, george.cherian@ti.com
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Fri, 6 Dec 2013 12:28:27 +0530

> From: George Cherian <george.cherian@ti.com>
> 
> Use netdev_name while requesting irq so that eth* name is shown
> in /proc/interrupts. Previously it was showing device name as (null)
> for cpsw interrupts. For using netdev_name register_netdev and then
> call devm_request_irq.
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Why is it showing "(null)" as the name, is dev_name() not working
properly for this device?

The only change you are making is passing netdev_name() instead
of dev_name().  dev_name() giving NULL doesn't make much sense
to me.
