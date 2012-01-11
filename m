From: Archit <a0393947@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 11 Jan 2012 21:22:00 +0530
Message-ID: <4F0DB020.2080804@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <4F0D9B15.4070803@ti.com> <WC20120111151532.4602C0@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35840 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757614Ab2AKPwT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 10:52:19 -0500
In-Reply-To: <WC20120111151532.4602C0@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, khilman@ti.com, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

On Wednesday 11 January 2012 08:45 PM, Joe Woodward wrote:
> ...snip...
>
>>
>> Could you enable omapdss debug by adding 'omapdss.debug=1 debug' in
>> your bootargs and share logs?
>
> As requested:
>
> # echo mem>  /sys/power/state
> [   37.371734] PM: Syncing filesystems ... done.
> [   37.397460] PM: Preparing system for mem sleep
> [   37.402923] Freezing user space processes ... (elapsed 0.02 seconds) done.
> [   37.432312] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [   37.463256] PM: Entering mem sleep
> [   37.467132] Suspending console(s) (use no_console_suspend to debug)
>
> #### SYSTEM SUSPENDS HERE
>
> [   37.587646] omapdss CORE: suspend 2
> [   37.776000] omapdss DISPC: dispc_runtime_put
> [   37.776336] omapdss DSS: dss_runtime_put
> [   37.779693] PM: suspend of devices complete after 305.389 msecs
> [   37.786010] omapdss DISPC: dispc_save_context
> [   37.786437] omapdss DISPC: context saved, ctx_loss_count 0
> [   37.786560] omapdss DSS: dss_runtime_put
> [   37.786773] omapdss DSS: dss_save_context
> [   37.786895] omapdss DSS: context saved
> [   37.787384] PM: late suspend of devices complete after 7.446 msecs
> [   40.932312] Successfully put all powerdomains to target state
> [   40.934509] omapdss DSS: dss_restore_context
> [   40.934661] omapdss DSS: context restored
> [   40.934814] omapdss DSS: dss_runtime_get
> [   40.934967] @@@ dss_runtime_get::pm_runtime_get_sync() return val = -13

This resume/restore looks to be happening a bit early according to me. 
All the resuming should happen after the print 'omapdss CORE: resume'.

One experiment worth trying would be to reboot/halt the kernel which 
will lead to only shutdown of DSS, and no resume. This will help us 
figure out if the issue is in the suspend or resume path.

Archit

> [   40.935089] ------------[ cut here ]------------
> [   40.935241] WARNING: at drivers/video/omap2/dss/dss.c:716 0xc0137304()
> [   40.935363] Modules linked in:
> [   40.935516] Backtrace:
> [   40.935638] Function entered at [<c0010c48>] from [<c02bdad0>]
> [   40.935791]  r6:c02fa302 r5:000002cc r4:00000000 r3:00000000
> [   40.936065] Function entered at [<c02bdab8>] from [<c0034874>]
> [   40.936218] Function entered at [<c0034820>] from [<c00348b0>]
> [   40.936340]  r8:00000000 r7:c0386c14 r6:c0028c48 r5:c0371c24 r4:fffffff3
> [   40.936645] r3:00000009
> [   40.936767] Function entered at [<c003488c>] from [<c0137304>]
> [   40.936920] Function entered at [<c01372a8>] from [<c0137b20>]
> [   40.937042]  r4:dec50008 r3:c0137b10
> [   40.937225] Function entered at [<c0137b10>] from [<c0179ff0>]
> [   40.937347]  r6:c0028c48 r5:c0371c24 r4:dec50008 r3:c0137b10
> [   40.937652] Function entered at [<c0179fbc>] from [<c0028ca4>]
> [   40.937774] Function entered at [<c0028c48>] from [<c017afc0>]
> [   40.937927]  r4:dec50008 r3:00000000
> [   40.938079] Function entered at [<c017aee0>] from [<c017b5ec>]
> [   40.938232]  r9:c02d0044 r8:00000000 r6:dec5005c r5:00000010 r4:dec50008
> [   40.938568] Function entered at [<c017b520>] from [<c0063e48>]
> [   40.938690]  r8:c02c3898 r7:00000000 r6:00000003 r5:00000000 r4:00000000
> [   40.938995] Function entered at [<c0063cc0>] from [<c0064004>]
> [   40.939147]  r7:00000004 r6:00000000 r5:c02c388c r4:00000003
> [   40.939422] Function entered at [<c0063ef4>] from [<c0062e78>]
> [   40.939544]  r6:00000003 r5:00000003 r4:d8869000 r3:0000006d
> [   40.939819] Function entered at [<c0062dd0>] from [<c0117ac8>]
> [   40.939971] Function entered at [<c0117aac>] from [<c00e2e54>]
> [   40.940124] Function entered at [<c00e2d44>] from [<c009903c>]
> [   40.940246] Function entered at [<c0098f88>] from [<c00992b8>]
> [   40.940368]  r8:00000004 r7:00000000 r6:00000000 r5:000aabf8 r4:d857c940
> [   40.940704] Function entered at [<c0099274>] from [<c000dcc0>]
> [   40.941101]  r8:c000de44 r7:00000004 r6:000aabf8 r5:00000004 r4:000a8e38
> [   40.941436] ---[ end trace db0a5fd53a21ce6e ]---
> [   40.943511] PM: early resume of devices complete after 9.307 msecs
> [   40.950622] omapdss DISPC: dispc_save_context
> [   40.951049] omapdss DISPC: context saved, ctx_loss_count 0
> [   40.951171] omapdss DSS: dss_runtime_put
> [   40.951812] omapdss CORE: resume
> [   40.953460] omapdss DSS: dss_runtime_get
> [   40.953613] @@@ dss_runtime_get::pm_runtime_get_sync() return val = 1
> [   40.953735] omapdss DISPC: dispc_runtime_get
> [   40.953948] omapdss DSS: dss_runtime_get
> [   40.954071] @@@ dss_runtime_get::pm_runtime_get_sync() return val = 1
> [   40.954193] omapdss DISPC: dispc_restore_context
> [   40.954467] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 1 ivs 1 acbi 0 acb 0
> [   40.954620] omapdss DSS: dispc clock info found from cache.
> [   40.954772] omapdss DSS: dpll4_m4 = 432000000
> [   40.954986] omapdss DSS: fck = 72000000 (12)
> [   40.955108] omapdss DISPC: lck = 72000000 (1)
> [   40.955230] omapdss DISPC: pck = 36000000 (2)
> [   40.955383] omapdss DISPC: channel 0 xres 800 yres 480
> [   40.955505] omapdss DISPC: pck 36000
> [   40.955657] omapdss DISPC: hsw 10 hfp 164 hbp 89 vsw 10 vfp 10 vbp 23
> [   40.955810] omapdss DISPC: hsync 33866Hz, vsync 64Hz
> [   41.294464] PM: resume of devices complete after 345.153 msecs
> [   41.688568] PM: Finishing wakeup.
> [   41.692169] Restarting tasks ... done.
>
> When SYNC is lost we get something like:
> [  118.972534] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled
> [  119.166839] omapdss DISPC: dispc_runtime_put
> [  119.175292] omapdss DSS: dss_runtime_put
> [  119.183746] omapdss DISPC: dispc_enable_plane 1, 0
> [  119.193054] omapdss DISPC: dispc_enable_plane 2, 0
> [  119.261230] omapdss DSS: dss_runtime_get
> [  119.261383] @@@ dss_runtime_get::pm_runtime_get_sync() return val = 1
> [  119.261505] omapdss DISPC: dispc_runtime_get
> [  119.261718] omapdss DISPC: onoff 0 rf 0 ieo 0 ipc 0 ihs 1 ivs 1 acbi 0 acb 0
> [  119.261871] omapdss DSS: dispc clock info found from cache.
> [  119.262023] omapdss DSS: dpll4_m4 = 432000000
> [  119.262237] omapdss DSS: fck = 72000000 (12)
> [  119.262329] omapdss DISPC: lck = 72000000 (1)
> [  119.262451] omapdss DISPC: pck = 36000000 (2)
> [  119.262603] omapdss DISPC: channel 0 xres 800 yres 480
> [  119.262725] omapdss DISPC: pck 36000
> [  119.262878] omapdss DISPC: hsw 10 hfp 164 hbp 89 vsw 10 vfp 10 vbp 23
> [  119.263000] omapdss DISPC: hsync 33866Hz, vsync 64Hz
> [  119.265228] omapdss DISPC: dispc_runtime_put
> [  119.962738] DISPC IRQ: 0x40a2: SYNC_LOST
> [  119.968017] omapdss DISPC: dispc_runtime_get
>
>
>>
>> The pm_runtime_get_sync() call in dss_runtime_get() is returning  a
>> negative value, could you print out that value too?
>>
>> If the call to pm_runtime_get_sync() fails, we bail out immediately. So
>> the LCD interface shouldn't have been enabled at all. I don't know why
>> we get sync lost errors.
>>
>> There is a possibility that the LCD interface wasn't switched off when
>> for some reason when we suspended, and switching on the clocks again
>> tries to start the transfer without DSS being configured correctly?
>>
>> Also, are you on the final 3.2, or the 3.2-rc's by any chance? There
>> were some hwmod patches which got in 3.2-rc4 related to hwmod fixes.
>
> Yep, it's definately the final mainline 3.2 taken from kernel.org.
>
> Cheers,
> Joe
>
>> Archit
>>
>>>
>>>>    - HDQ seems to lose everything.
>>>
>>> Is this with off-mode enabled, or just with retention idle?
>>>
>>> If the former, this is hardly surprising as the HDQ driver
>>> (drivers/w1/masters/omap_hdq.c) doesn't contain any context
>> save/restore
>>> code.  In fact the HDQ driver doesn't even use PM runtime, so quite a
>> bit
>>> of work is needed there.
>>>
>>>
>>> - Paul
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

