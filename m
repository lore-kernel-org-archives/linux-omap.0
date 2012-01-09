From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: DSS2/PM on 3.2 broken?
Date: Mon, 09 Jan 2012 12:46:43 +0000
Message-ID: <WC20120109124643.880164@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:53309 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751818Ab2AINlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 08:41:07 -0500
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q09Ckpto012127
	for <linux-omap@vger.kernel.org>; Mon, 9 Jan 2012 12:46:56 GMT
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.2)
	with ESMTP id md50002140523.msg
	for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 12:46:44 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm running on a Gumstix Overo (OMAP3530) with an 24-bit LCD panel connected via the DPI interface (using the generic panel driver).

Entering standby used to work just fine on 3.0, but on 3.2 I get the following:

# echo mem > /sys/power/state
[   23.186279] PM: Syncing filesystems ... done.
[   23.194244] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   23.219543] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   23.251037] Suspending console(s) (use no_console_suspend to debug)
[   23.554656] PM: suspend of devices complete after 296.417 msecs
[   23.561859] PM: late suspend of devices complete after 6.957 msecs
[   24.464813] Successfully put all powerdomains to target state
[   24.466674] ------------[ cut here ]------------
[   24.466857] WARNING: at drivers/video/omap2/dss/dss.c:713 0xc01350f8()
[   24.467010] Modules linked in:
[   24.467132] Backtrace:
[   24.467254] Function entered at [<c0010c3c>] from [<c02c4a60>]
[   24.467407]  r6:c02ffdaa r5:000002c9 r4:00000000 r3:00000000
[   24.467651] Function entered at [<c02c4a48>] from [<c00344d0>]
[   24.467803] Function entered at [<c003447c>] from [<c003450c>]
[   24.467926]  r8:00000000 r7:c0390a84 r6:c00288a4 r5:c037b85c r4:fffffff3
[   24.468200] r3:00000009
[   24.468322] Function entered at [<c00344e8>] from [<c01350f8>]
[   24.468475] Function entered at [<c01350ac>] from [<c013595c>]
[   24.468597]  r4:dec50208 r3:c013594c
[   24.468780] Function entered at [<c013594c>] from [<c0182724>]
[   24.468902]  r6:c00288a4 r5:c037b85c r4:dec50208 r3:c013594c
[   24.469177] Function entered at [<c01826f0>] from [<c0028900>]
[   24.469299] Function entered at [<c00288a4>] from [<c01836f4>]
[   24.469421]  r4:dec50208 r3:00000000
[   24.469604] Function entered at [<c0183614>] from [<c0183d20>]
[   24.469726]  r9:c02d7044 r8:00000000 r6:dec5025c r5:00000010 r4:dec50208
[   24.470031] Function entered at [<c0183c54>] from [<c0063aa4>]
[   24.470153]  r8:c02ca888 r7:00000000 r6:00000003 r5:00000000 r4:00000000
[   24.470458] Function entered at [<c006391c>] from [<c0063c60>]
[   24.470581]  r7:00000004 r6:00000000 r5:c02ca87c r4:00000003
[   24.471130] Function entered at [<c0063b50>] from [<c0062ad4>]
[   24.471282]  r6:00000003 r5:00000003 r4:c6a87000 r3:0000006d
[   24.471557] Function entered at [<c0062a2c>] from [<c0117728>]
[   24.471679] Function entered at [<c011770c>] from [<c00e2ab0>]
[   24.471832] Function entered at [<c00e29a0>] from [<c0098c98>]
[   24.471954] Function entered at [<c0098be4>] from [<c0098f14>]
[   24.472076]  r8:00000004 r7:00000000 r6:00000000 r5:000ac750 r4:d8a70dc0
[   24.472412] Function entered at [<c0098ed0>] from [<c000dcc0>]
[   24.472534]  r8:c000de44 r7:00000004 r6:000ac750 r5:00000004 r4:000a8e38
[   24.472839] ---[ end trace 9f4f3053f6637dae ]---
[   24.475006] PM: early resume of devices complete after 8.666 msecs
[   25.040344] PM: resume of devices complete after 560.943 msecs
[   25.277801] Restarting tasks ... done.

At which point the screen either restarts, or sometimes flickers and I get the following:
[   22.578796] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled
[   23.391571] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled
[   24.391571] omapdss DISPC error: SYNC_LOST on channel lcd, restarting the output with video overlays disabled

It normally recovers after doing this for a while...

Anyone have any ideas?

Cheers,
Joe



