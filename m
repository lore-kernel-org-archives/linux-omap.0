From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V2] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick
 clock
Date: Wed, 27 Mar 2013 17:45:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303271744510.17356@utopia.booyaka.com>
References: <1364378666-23641-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47816 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab3C0RpZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 13:45:25 -0400
In-Reply-To: <1364378666-23641-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Wed, 27 Mar 2013, Vaibhav Hiremath wrote:

> It is required to enable respective clock-domain before
> enabling any clock/module inside that clock-domain.
> 
> During common-clock migration, .clkdm_name field got missed
> for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
> unused; so it will be disabled even if childs of this clock-domain
> is enabled, which keeps child modules in idle mode.
> 
> This fixes the kernel crash observed on AM335xEVM-SK platform,
> where clkdiv32_ick clock is being used as a gpio debounce clock
> and since clkdiv32k_ick is in idle mode it leads to below crash -
> 
> Crash Log:
> ==========
> [    2.598347] Unhandled fault: external abort on non-linefetch (0x1028) at
> 0xfa1ac150
> [    2.606434] Internal error: : 1028 [#1] SMP ARM
> [    2.611207] Modules linked in:
> [    2.614449] CPU: 0    Not tainted  (3.8.4-01382-g1f449cd-dirty #4)
> [    2.620973] PC is at _set_gpio_debounce+0x60/0x104
> [    2.626025] LR is at clk_enable+0x30/0x3c
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Tony, if it isn't too late, could this one be added to your 3.9-rc fixes 
series?


- Paul
