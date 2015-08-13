From: David Miller <davem@davemloft.net>
Subject: Re: [net-next PATCH 0/3] Add AM335x PG1.0 CPSW errata workaround
Date: Thu, 13 Aug 2015 16:51:13 -0700 (PDT)
Message-ID: <20150813.165113.1810080698956348801.davem@davemloft.net>
References: <1439373175-8650-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1439373175-8650-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, alex.aring@gmail.com
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Wed, 12 Aug 2015 15:22:52 +0530

> With commit 870915feabdc ("drivers: net: cpsw: remove
> disable_irq/enable_irq as irq can be masked from cpsw itself"),
> CPSW on AM335x beagle bone white is broken as there is a errata
> for AM335x PG1.0. This patch series implements the workaround by
> disabling the interrupts from ARM IRQ controller for AM335x SoC
> in addition to the masking of interrupts in CPSW.

Series applied, thanks.
