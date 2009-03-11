From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.29-rc7-omap-git] Overo: MMC regulator configuration
Date: Wed, 11 Mar 2009 21:33:47 +0200
Message-ID: <20090311193347.GC19730@gandalf>
References: <200903111158.29860.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42579 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZCKTdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 15:33:54 -0400
Content-Disposition: inline
In-Reply-To: <200903111158.29860.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>, Steve Sakoman <steve@sakoman.com>

On Wed, Mar 11, 2009 at 10:58:29AM -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> This patch hooks up the twl4030 MMC1 regulator on Overo,
> as well as the MMC1 card detect signal.  The WLAN chip
> connected to MMC2 on some board versions has a dedicated
> regulator.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Patches still needed for LDP/Zoom and Pandora...

with this patch I get:

regulator: Unable to get requested regulator: vmmc_aux
------------[ cut here ]------------
WARNING: at drivers/regulator/core.c:1216 regulator_disable+0x64/0x90()
unbalanced disables for supply mmci-omap-hs.0-vmmc
Modules linked in:
[<c0363198>] (dump_stack+0x0/0x14) from [<c004f0fc>] (warn_slowpath+0x6c/0x88)
[<c004f090>] (warn_slowpath+0x0/0x88) from [<c01b2694>] (regulator_disable+0x64/0x90)
 r3:cf9deae0 r2:c0425c79
 r7:cfa16e00 r6:cfa06c38 r5:cfa16e00 r4:fffffffb
[<c01b2630>] (regulator_disable+0x0/0x90) from [<c025ed6c>] (mmc_regulator_set_ocr+0xb0/0xcc)
 r7:cfa16e00 r6:00000001 r5:00000000 r4:00000000
[<c025ecbc>] (mmc_regulator_set_ocr+0x0/0xcc) from [<c003af08>] (twl_mmc1_set_power+0xc0/0xec)
 r7:cfa93538 r6:00000000 r5:00000000 r4:c04a5b58
[<c003ae48>] (twl_mmc1_set_power+0x0/0xec) from [<c0267b34>] (omap_mmc_set_ios+0x54/0x314)
 r7:cfa93538 r6:cfa935c0 r5:cfa93400 r4:cf9a93c0
[<c0267ae0>] (omap_mmc_set_ios+0x0/0x314) from [<c025e54c>] (mmc_power_off+0x90/0x9c)
 r7:00000000 r6:00000000 r5:cfa93400 r4:00000000
[<c025e4bc>] (mmc_power_off+0x0/0x9c) from [<c025ea98>] (mmc_start_host+0x14/0x24)
 r5:00000000 r4:cfa93400
[<c025ea84>] (mmc_start_host+0x0/0x24) from [<c025fcbc>] (mmc_add_host+0x64/0x70)
 r5:00000000 r4:cfa93400
[<c025fc58>] (mmc_add_host+0x0/0x70) from [<c0021cac>] (omap_mmc_probe+0x464/0x614)
 r5:cfa935c0 r4:cfa93470
[<c0021848>] (omap_mmc_probe+0x0/0x614) from [<c01d7b60>] (platform_drv_probe+0x20/0x24)
[<c01d7b40>] (platform_drv_probe+0x0/0x24) from [<c01d6d54>] (driver_probe_device+0xd4/0x180)
[<c01d6c80>] (driver_probe_device+0x0/0x180) from [<c01d6e68>] (__driver_attach+0x68/0x8c)
 r7:cfa15120 r6:c0499e34 r5:cfa06290 r4:cfa06208
[<c01d6e00>] (__driver_attach+0x0/0x8c) from [<c01d65f8>] (bus_for_each_dev+0x4c/0x80)
 r7:cfa15120 r6:c0499e34 r5:c01d6e00 r4:00000000
[<c01d65ac>] (bus_for_each_dev+0x0/0x80) from [<c01d6b98>] (driver_attach+0x20/0x28)
 r6:c0499e34 r5:00000000 r4:00000000
[<c01d6b78>] (driver_attach+0x0/0x28) from [<c01d5ed4>] (bus_add_driver+0xa4/0x20c)
[<c01d5e30>] (bus_add_driver+0x0/0x20c) from [<c01d708c>] (driver_register+0x98/0x120)
 r8:00000000 r7:c002182c r6:c0499e34 r5:00000000 r4:c0028a58
[<c01d6ff4>] (driver_register+0x0/0x120) from [<c01d8008>] (platform_driver_register+0x6c/0x88)
 r9:00000000 r8:00000000 r7:c002182c r6:00000000 r5:00000000
r4:c0028a58
[<c01d7f9c>] (platform_driver_register+0x0/0x88) from [<c0021840>] (omap_mmc_init+0x14/0x1c)
[<c002182c>] (omap_mmc_init+0x0/0x1c) from [<c002d2bc>] (__exception_text_end+0x5c/0x19c)
[<c002d260>] (__exception_text_end+0x0/0x19c) from [<c0008400>] (kernel_init+0x80/0xf4)
 r8:00000000 r7:00000000 r6:00000000 r5:00000000 r4:c0028a58
[<c0008380>] (kernel_init+0x0/0xf4) from [<c0051f50>] (do_exit+0x0/0x6a4)
 r4:00000000
---[ end trace e00c52255ce89b8f ]---
mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
regulator: Unable to get requested regulator: vmmc

does this depend on any patch dave ? Using current omap HEAD.

-- 
balbi
