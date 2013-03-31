From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: AM33xx: hwmod: Add missing sysc definition
 to wdt1 entry
Date: Sun, 31 Mar 2013 02:18:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303310218050.6436@utopia.booyaka.com>
References: <1364577017-22562-1-git-send-email-hvaibhav@ti.com> <1364577017-22562-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35993 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab3CaCSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 22:18:22 -0400
In-Reply-To: <1364577017-22562-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, santosh.shilimkar@ti.com, benoit.cousson@linaro.org

On Fri, 29 Mar 2013, Vaibhav Hiremath wrote:

> This patch adds sysc definitions to the wdt1 hwmod entry, which in-turn
> makes sure that sysc idle bit-fields are configured to valid state on
> enable/disable callbacks.
> 
> With the recent submitted patch from Santosh Shilimkar,
> "ARM: OMAP2+: hwmod: Don't call _init_mpu_rt_base if no sysc"
> (commit: 4a98c2d89), it is required to add sysconf
> information to each valid hwmod entry, else device will not be
> come out from idle state properly and leads to below kernel
> crash  -
> 
> [2.190237] Unhandled fault: external abort on non-linefetch (0x1028) at
> 0xf9e35034
> [2.198325] Internal error: : 1028 [#1] SMP ARM
> [2.203101] Modules linked in:
> [2.206334] CPU: 0    Not tainted  (3.9.0-rc3-00059-gd114294#1)
> [2.212679] PC is at omap_wdt_disable.clone.5+0xc/0x60
> [2.218090] LR is at omap_wdt_probe+0x184/0x1fc
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <benoit.cousson@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued for 3.10.

- Paul
