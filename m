From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 00/34] omap drivers going upstream
Date: Mon, 1 Sep 2008 01:37:37 +0300
Message-ID: <20080831223721.GO9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52497 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbYHaWiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 18:38:07 -0400
Content-Disposition: inline
In-Reply-To: <1220116593-862-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sat, Aug 30, 2008 at 08:16:00PM +0300, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> The following drivers are going upstream for integration.
> They have been sitting on linux-omap for quite a while just
> increasing the diff against mainline and probability of
> merge conflicts.

Just one comment to this. I had to left bluetooth driver out of the
series because it's using omap2_block/allow_sleep in the driver code.
That should be fixed and the set_clock function should come via
platform_data to the driver.

  53 static void hci_h4p_set_clk(struct hci_h4p_info *info, int *clock, int enable)
  54 {
  55         unsigned long flags;
  56 
  57         spin_lock_irqsave(&info->clocks_lock, flags);
  58         if (enable && !*clock) {
  59                 NBT_DBG_POWER("Enabling %p\n", clock);
  60                 clk_enable(info->uart_fclk);
  61 #ifdef CONFIG_ARCH_OMAP2
  62                 if (cpu_is_omap24xx()) {
  63                         clk_enable(info->uart_iclk);
  64                         omap2_block_sleep();
  65                 }
  66 #endif
  67         }
  68         if (!enable && *clock) {
  69                 NBT_DBG_POWER("Disabling %p\n", clock);
  70                 clk_disable(info->uart_fclk);
  71 #ifdef CONFIG_ARCH_OMAP2
  72                 if (cpu_is_omap24xx()) {
  73                         clk_disable(info->uart_iclk);
  74                         omap2_allow_sleep();
  75                 }
  76 #endif
  77         }
  78 
  79         *clock = enable;
  80         spin_unlock_irqrestore(&info->clocks_lock, flags);
  81 }

That driver is full of arch specific code and should be cleaned up ASAP.

A few things I could get by briefly looking at the driver (actualy only
drivers/bluetooth/hci_h4p/core.c):

* set_clock should come via platform_data
* gpio handling should use gpiolib instead of omap-specific ones
* irq should come via platform_data to avoid 'if (cpu_is_xxx())'
* unnecessary casts should be removed
* one line ifs do not need {}
* there's a memory leak on probe if no platform_data is found
* use of io_p2v() should be avoided on drivers, refer to Russel King's
  patch
* OMAP_GPIO_IRQ() should not be used on the driver.

-- 
balbi
