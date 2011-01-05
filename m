From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when !CONFIG_RUNTIME_PM
Date: Wed, 05 Jan 2011 09:53:07 -0800
Message-ID: <87aajfz18c.fsf@ti.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
	<68789fa8ba11b9427aa6321da55c9a8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56130 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab1AERxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 12:53:11 -0500
Received: by mail-pv0-f182.google.com with SMTP id 22so3736817pvc.41
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 09:53:11 -0800 (PST)
In-Reply-To: <68789fa8ba11b9427aa6321da55c9a8b@mail.gmail.com> (Santosh
	Shilimkar's message of "Wed, 5 Jan 2011 19:23:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

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
> [    1.372558] Unhandled fault: imprecise external abort (0x1406) at
> 0xad733eeb
> [    1.379913] Internal error: : 1406 [#1] SMP
> [    1.384277] last sysfs file:
> [    1.387359] Modules linked in:
> [    1.390563] CPU: 0    Tainted: G        W
> (2.6.37-rc7-00265-g4298a4c-dirty #23)
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
> timer.  Patch generated against 'omap-for-linus' branch and boot
> tested on OMAP4 with and without CONFIG_OMAP_WATCHDOG.
>
>  arch/arm/mach-omap2/io.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index e66687b..b879a16 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -378,7 +378,11 @@ void __init omap2_init_common_infrastructure(void)
>  	 * XXX ideally we could detect whether the MPU WDT was currently
>  	 * enabled here and make this conditional
>  	 */
> +#ifdef CONFIG_PM_RUNTIME
>  	postsetup_state = _HWMOD_STATE_DISABLED;
> +#else
> +	postsetup_state = _HWMOD_STATE_ENABLED;
> +#endif

You shouldn't need the 'else' part of this since the default a few lines
above this code is already setting that for the !CONFIG_PM_RUNTIME case.

Kevin

>  	omap_hwmod_for_each_by_class("wd_timer",
>  				     _set_hwmod_postsetup_state,
>  				     &postsetup_state);
