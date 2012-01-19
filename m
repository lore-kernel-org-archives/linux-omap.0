From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 11:29:11 +0000
Message-ID: <WC20120119112911.670749@terrafix.co.uk>
References: <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com> <20120113222045.37f9b4ec@notabene.brown> <1326870839.1954.23.camel@deskari> <20120118221538.342b4782@notabene.brown> <1326886940.1999.5.camel@lappy> <20120119073032.74cc0992@notabene.brown> <WC20120119101721.07072A@terrafix.co.uk> <1326969658.1935.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:58233 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501Ab2ASL3e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 06:29:34 -0500
In-Reply-To: <1326969658.1935.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neilb@suse.de>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

... (apologies for awful formatting of the previous mail) ...
 
> Well, I don't see how UART could directly affect DSS. The thing that
> comes to my mind is that typing a char in the console causes a change
> in
> the power management, which then "fixes" the DSS. But then again, I'd
> expect the console to go into sleep/idle state after a short while,
> which should again cause sync_losts. But that's not happening...
> 
> Can you show the dss clocks you use (cat debugfs/omapdss/clk)?
> 
> It's been a while since I did anything with PM, so I don't remember how
> and if it can be done, but a simple test would be to lock the OMAP to
> always use OPP100.
> 
>  Tomi
> 

Right,

I'm running with both CPUIDLE and CPUFREQ disabled at present so I assume that means I should always be in OPP100?

The panel is 800x480 (I've added a configuration to the generic-panel with the correct panel parameters), with just 1 FB device (/dev/fb0).

Clock dump is shown below:

# pwd
/debug/omapdss
# cat clk
[   53.146057] omapdss DSS: dss_runtime_get
[   53.151000] omapdss DSS: dss_runtime_put
[   53.155151] omapdss DISPC: dispc_runtime_get
[   53.160430] omapdss DISPC: dispc_runtime_put
- DSS -
dpll4_ck 432000000
DSS_FCK (DSS1_ALWON_FCLK) = 432000000 / 12 * 2 = 72000000
- DISPC -
dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
fck             72000000
- LCD1 -
lcd1_clk source = DSS_FCK (DSS1_ALWON_FCLK)
lck             72000000        lck div 1
pck             36000000        pck div 2


The SYNC_LOST errors sometimes don't happen, and sometimes fix themselves. It does seem that whenever a character is typed in to the UART the SYNC_LOST errors stop immediately.

This is a question more for Kevin, but is there some debug/tracing I can enable within the PM framework to see a bit more of whats going on?

I've added some more traces below...

Trace with no errors:
[   91.806427] PM: Syncing filesystems ... done.
[   91.811370] PM: Preparing system for mem sleep
[   91.816986] Freezing user space processes ... (elapsed 0.02 seconds) done.
[   91.846221] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   91.877441] PM: Entering mem sleep
[   91.881317] Suspending console(s) (use no_console_suspend to debug)
[   92.001068] omapdss CORE: suspend 2
[   92.184600] omapdss DISPC: dispc_runtime_put
[   92.184631] omapdss DISPC: dispc_save_context
[   92.184692] omapdss DISPC: context saved, ctx_loss_count 0
[   92.184722] omapdss DSS: dss_runtime_put
[   92.184753] omapdss DSS: dss_runtime_put
[   92.184783] omapdss DSS: dss_save_context
[   92.184783] omapdss DSS: context saved
[   92.185485] PM: suspend of devices complete after 297.088 msecs
[   92.186401] PM: late suspend of devices complete after 0.885 msecs
[   94.111755] Successfully put all powerdomains to target state
[   94.112518] PM: early resume of devices complete after 0.549 msecs
[   94.113555] omapdss CORE: resume
[   94.114135] omapdss DSS: dss_runtime_get
[   94.114166] omapdss DSS: dss_restore_context
[   94.114196] omapdss DSS: context restored
[   94.114196] omapdss DISPC: dispc_runtime_get
[   94.114227] omapdss DSS: dss_runtime_get
[   94.114257] omapdss DISPC: dispc_restore_context
[   94.114288] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 1 ivs 1 acbi 0 acb 0
[   94.114318] omapdss DSS: dispc clock info found from cache.
[   94.114318] omapdss DSS: dpll4_m4 = 432000000
[   94.114349] omapdss DSS: fck = 72000000 (12)
[   94.114379] omapdss DISPC: lck = 72000000 (1)
[   94.114379] omapdss DISPC: pck = 36000000 (2)
[   94.114410] omapdss DISPC: channel 0 xres 800 yres 480
[   94.114440] omapdss DISPC: pck 36000
[   94.114440] omapdss DISPC: hsw 10 hfp 164 hbp 89 vsw 10 vfp 10 vbp 23
[   94.114471] omapdss DISPC: hsync 33866Hz, vsync 64Hz
[   94.698455] PM: resume of devices complete after 585.082 msecs
[   94.847900] PM: Finishing wakeup.
[   94.851409] Restarting tasks ... done.

Trace with SYNC_LOST errors:
[  106.635437] PM: Syncing filesystems ... done.
[  106.640563] PM: Preparing system for mem sleep
[  106.646118] Freezing user space processes ... (elapsed 0.02 seconds) done.
[  106.677703] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[  106.708923] PM: Entering mem sleep
[  106.712768] Suspending console(s) (use no_console_suspend to debug)
[  106.832672] omapdss CORE: suspend 2
[  107.011260] omapdss DISPC: dispc_runtime_put
[  107.011291] omapdss DISPC: dispc_save_context
[  107.011352] omapdss DISPC: context saved, ctx_loss_count 0
[  107.011383] omapdss DSS: dss_runtime_put
[  107.011413] omapdss DSS: dss_runtime_put
[  107.011444] omapdss DSS: dss_save_context
[  107.011444] omapdss DSS: context saved
[  107.012145] PM: suspend of devices complete after 292.266 msecs
[  107.013061] PM: late suspend of devices complete after 0.885 msecs
[  107.716400] Successfully put all powerdomains to target state
[  107.717102] PM: early resume of devices complete after 0.488 msecs
[  107.718139] omapdss CORE: resume
[  107.718780] omapdss DSS: dss_runtime_get
[  107.718811] omapdss DSS: dss_restore_context
[  107.718841] omapdss DSS: context restored
[  107.718872] omapdss DISPC: dispc_runtime_get
[  107.718872] omapdss DSS: dss_runtime_get
[  107.718902] omapdss DISPC: dispc_restore_context
[  107.718933] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 1 ivs 1 acbi 0 acb 0
[  107.718963] omapdss DSS: dispc clock info found from cache.
[  107.718963] omapdss DSS: dpll4_m4 = 432000000
[  107.718994] omapdss DSS: fck = 72000000 (12)
[  107.719024] omapdss DISPC: lck = 72000000 (1)
[  107.719024] omapdss DISPC: pck = 36000000 (2)
[  107.719055] omapdss DISPC: channel 0 xres 800 yres 480
[  107.719085] omapdss DISPC: pck 36000
[  107.719085] omapdss DISPC: hsw 10 hfp 164 hbp 89 vsw 10 vfp 10 vbp 23
[  107.719116] omapdss DISPC: hsync 33866Hz, vsync 64Hz
[  108.307922] PM: resume of devices complete after 589.996 msecs
[  108.457397] PM: Finishing wakeup.
[  108.460876] Restarting tasks ... done.
[  108.597045] DISPC IRQ: 0x40a2: SYNC_LOST
[  108.601470] omapdss DISPC: dispc_runtime_get
[  108.606872] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled
[  108.802520] omapdss DISPC: dispc_runtime_put
[  108.807037] omapdss DSS: dss_runtime_put
[  108.812103] omapdss DISPC: dispc_enable_plane 1, 0
[  108.817596] omapdss DISPC: dispc_enable_plane 2, 0
[  108.873352] omapdss DSS: dss_runtime_get
[  108.877502] omapdss DISPC: dispc_runtime_get
[  108.882568] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 1 ivs 1 acbi 0 acb 0
[  108.890411] omapdss DSS: dispc clock info found from cache.
[  108.896789] omapdss DSS: dpll4_m4 = 432000000
[  108.901733] omapdss DSS: fck = 72000000 (12)
[  108.906250] omapdss DISPC: lck = 72000000 (1)
[  108.911407] omapdss DISPC: pck = 36000000 (2)
[  108.916015] omapdss DISPC: channel 0 xres 800 yres 480
[  108.922027] omapdss DISPC: pck 36000
[  108.926116] omapdss DISPC: hsw 10 hfp 164 hbp 89 vsw 10 vfp 10 vbp 23
[  108.933288] omapdss DISPC: hsync 33866Hz, vsync 64Hz
[  108.940887] omapdss DISPC: dispc_runtime_put

Thanks,
Joe


