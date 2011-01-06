From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
 !CONFIG_RUNTIME_PM
Date: Thu, 6 Jan 2011 11:25:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101061120480.31961@utopia.booyaka.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50287 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1AFSZc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:25:32 -0500
In-Reply-To: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh,

On Wed, 5 Jan 2011, Santosh Shilimkar wrote:

> Commit ff2516fb 'wd_timer: disable on boot via hwmod postsetup mechanism'
> introduced watchdog timer state state management using postsetup_state.
> This was done to allow some board files to support watchdog coverage
> throughout kernel initialization and it work as intended when RUNTIME_PM
> is enabled.
> 
> With !CONFIG_RUNTIME_PM and no board is specifically requests watchdog
> to remain enabled the omap_wdt_probe crashesh. This is because hwmod
> in absense of runtime PM unable to turn watchdog clocks because it's
> state is set to be disabled. For rest of the device, the state is
> set as enabled in absense of RUNTIME_PM
> 
> [    1.372558] Unhandled fault: imprecise external abort (0x1406) at 0xad733eeb
> [    1.379913] Internal error: : 1406 [#1] SMP
> [    1.384277] last sysfs file:
> [    1.387359] Modules linked in:
> [    1.390563] CPU: 0    Tainted: G        W    (2.6.37-rc7-00265-g4298a4c-dirty #23)
> [    1.398468] PC is at omap_wdt_disable+0x2c/0x3c
> [    1.403198] LR is at omap_wdt_probe+0x124/0x1e0
> [    1.407928] pc : [<c02f5bf4>]    lr : [<c03be10c>]    psr: 60000013
> [    1.407958] sp : df833f00  ip : 00000000  fp : 00000000
> [    1.419921] r10: c0ac57ac  r9 : df959e00  r8 : 00000000
> [    1.425384] r7 : df959e08  r6 : df8000c0  r5 : df95bebc  r4 : df87dde0
> [    1.432189] r3 : fc314000  r2 : 00005555  r1 : fc314034  r0 : df87dde0
> 
> This patch make the default watchdog state to be enabled in case of
> !CONFIG_RUNTIME_PM. This fixes the crash
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> Paul, I am not too sure if it breaks your _shutdown idea of watchdog
> timer.

Maybe.  What happens in a case where the bootloader enables the watchdog, 
but the booting kernel is compiled with !CONFIG_OMAP_WATCHDOG and 
!CONFIG_PM_RUNTIME?  Won't the watchdog reset the MPU unexpectedly in that 
case?  Or am I missing something...


- Paul
