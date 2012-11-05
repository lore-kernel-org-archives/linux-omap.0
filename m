From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv9 0/8] ARM: OMAP4: core retention support
Date: Mon, 05 Nov 2012 14:23:14 -0800
Message-ID: <87d2zrg04t.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55407 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab2KEWXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 17:23:15 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4254305pad.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 14:23:15 -0800 (PST)
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 18 Oct 2012 12:20:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> Hi,
>
> Changes compared to previous version:
> - rebased on top of 3.7-rc1
> - applies on top of latest func pwrst code (v6)
> - added back patch #1 to this set (it wasn't queued yet after all)
> - added patch #7 for fixing a bug in the functional pwrst code
> - added patch #8 for fixing a regression with MUSB PHY power handling
>   (not quite sure if this is the correct way to fix this or not)
>
> Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuid=
le +
> suspend.
>
> Branch also available here:
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.7-rc1-omap4-ret-v9

I tested this branch on 4430/Panda and 4460/Panda-ES and I'm seeing
several domains not hitting target power state in suspend[1].

Am I missing some other fixes?  Using omap2plus_defconfig, I tried your
branch alone, and merged with v3.7-rc4, and I get the same errors.

Kevin

[1]
# echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wake=
up
# echo mem > /sys/power/state=20
[  102.271087] PM: Syncing filesystems ... done.
[  102.282196] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[  102.312133] Freezing remaining freezable tasks ... (elapsed 0.02 sec=
onds) done.
[  102.343353] Suspending console(s) (use no_console_suspend to debug)
=EF=BF=BD[  102.363433] PM: suspend of devices complete after 10.650 ms=
ecs
[  102.365631] PM: late suspend of devices complete after 2.166 msecs
[  102.369201] PM: noirq suspend of devices complete after 3.509 msecs
[  102.369232] Disabling non-boot CPUs ...
[  102.373016] CPU1: shutdown
[  104.357421] Powerdomain (core_pwrdm) didn't enter target state 1
[  104.357452] Powerdomain (tesla_pwrdm) didn't enter target state 1
[  104.357452] Powerdomain (ivahd_pwrdm) didn't enter target state 1
[  104.357482] Powerdomain (l3init_pwrdm) didn't enter target state 1
[  104.357482] Could not enter target state in pm_suspend
[  104.357666] Enabling non-boot CPUs ...
[  104.359863] CPU1: Booted secondary processor
[  104.360626] cpu cpu0: opp_init_cpufreq_table: Device OPP not found (=
-19)
[  104.360656] cpu cpu0: omap_cpu_init: cpu1: failed creating freq tabl=
e[-19]
[  104.360656] CPU1 is up
[  104.362579] PM: noirq resume of devices complete after 1.892 msecs
[  104.364807] PM: early resume of devices complete after 1.373 msecs
[  104.710937] PM: resume of devices complete after 346.099 msecs
[  104.817901] Restarting tasks ... done.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
