From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Sat, 15 Jan 2011 00:54:31 +0100
Message-ID: <4D30E237.4050802@gmail.com>
References: <20110114194758.GM4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61609 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab1ANXyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 18:54:32 -0500
Received: by fxm20 with SMTP id 20so3341716fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 15:54:31 -0800 (PST)
In-Reply-To: <20110114194758.GM4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Am 14.01.2011 20:47, schrieb Tony Lindgren:
> Hi all,
>
> Before I update out master branch, let's try to summarize the
> open issues after the merge window. Here's a list of issues
> in omap-fixes-for-linus that I'm aware of:
>
> - NFS root oopses while mounting root
>
> - omap4430 es1.0 hangs if L2X0 cache is enabled
>
> - omap4 panda powers down after boot (watchdog?)
>
> - omap3 ldp board powers down after boot?
>
> Any other issues?
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hello,

today I tried to enable the DVI output on Devkit8000 and got the
following error.

When the DVI port is configured as omapdss.def_disp I can turn on and
off the DVI, but not the display0 (LCD).

Thomas

My cmdline is:
console=ttyO2,115200n8 root=/dev/nfs nfsroot=192.168.1.102:/nfsroot
ip=192.168.1.200 rootdelay=1 omapdss.def_disp=lcd
omapfb.mode=lcd:800x480 vram=12M

# echo 1 > /sys/devices/omapdss/display1/enabled
[   27.399017] omapdss DPI: Could not find exact pixel clock. Requested
23500 kHz, got 24000 kHz
[   27.410156] Unable to handle kernel NULL pointer dereference at
virtual address 00000078
[   27.418731] pgd = ce438000
[   27.421844] [00000078] *pgd=8e432031, *pte=00000000, *ppte=00000000
[   27.428466] Internal error: Oops: 17 [#1] SMP
[   27.433044] last sysfs file: /sys/devices/omapdss/display1/enabled
[   27.439544] Modules linked in:
[   27.442779] CPU: 0    Not tainted  (2.6.37-rc5-09166-g28d7f6a #26)
[   27.449279] PC is at omapdss_dpi_display_enable+0x8c/0xd8
[   27.454956] LR is at omapdss_dpi_display_enable+0x88/0xd8
[   27.460632] pc : [<c026c110>]    lr : [<c026c10c>]    psr: 60000013
[   27.460632] sp : ce425f00  ip : 000026ca  fp : 00000002
[   27.472686] r10: cef240f8  r9 : c0439634  r8 : 00000002
[   27.478179] r7 : cef240e0  r6 : c05db110  r5 : 00000000  r4 : c05db108
[   27.485015] r3 : c0b61e7c  r2 : 00000740  r1 : cef19a50  r0 : 00000000
[   27.491882] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[   27.499359] Control: 10c5387d  Table: 8e438019  DAC: 00000015
[   27.505401] Process sh (pid: 546, stack limit = 0xce4242f8)
[   27.511260] Stack: (0xce425f00 to 0xce426000)
[   27.515838] 5f00: 00000000 c05db108 00000002 c0272370 c02723c0
c05db108 00000002 c02723cc
[   27.524444] 5f20: c05db108 c02695ec 00000002 cee5e148 ce425f80
c0299c1c 00000002 c016fd0c
[   27.533020] 5f40: 00000002 ce407080 400ea000 ce425f80 00000000
00000000 00000000 c01205a0
[   27.541625] 5f60: ce407080 400ea000 ce407080 400ea000 00000002
00000004 00000000 c01206c8
[   27.550201] 5f80: 00000000 00000000 00000002 00000000 00000002
402d35c8 00000002 c005a3e8
[   27.558807] 5fa0: ce424000 c005a220 00000002 402d35c8 00000001
400ea000 00000002 00000000
[   27.567382] 5fc0: 00000002 402d35c8 00000002 00000004 400ea000
40084000 0000000a 00000002
[   27.575988] 5fe0: 00000000 bea235f8 401f9e98 40256adc 60000010
00000001 00000000 00000000
[   27.584594] [<c026c110>] (omapdss_dpi_display_enable+0x8c/0xd8) from
[<c0272370>] (generic_panel_power_on+0x1c/0x50)
[   27.595672] [<c0272370>] (generic_panel_power_on+0x1c/0x50) from
[<c02723cc>] (generic_panel_enable+0xc/0x1c)
[   27.606079] [<c02723cc>] (generic_panel_enable+0xc/0x1c) from
[<c02695ec>] (display_enabled_store+0x50/0x74)
[   27.616424] [<c02695ec>] (display_enabled_store+0x50/0x74) from
[<c0299c1c>] (dev_attr_store+0x1c/0x20)
[   27.626312] [<c0299c1c>] (dev_attr_store+0x1c/0x20) from [<c016fd0c>]
(sysfs_write_file+0x10c/0x144)
[   27.635925] [<c016fd0c>] (sysfs_write_file+0x10c/0x144) from
[<c01205a0>] (vfs_write+0xb0/0x128)
[   27.645172] [<c01205a0>] (vfs_write+0xb0/0x128) from [<c01206c8>]
(sys_write+0x3c/0x68)
[   27.653594] [<c01206c8>] (sys_write+0x3c/0x68) from [<c005a220>]
(ret_fast_syscall+0x0/0x3c)
[   27.662445] Code: 1a000005 e59f004c ebff2da5 e59402b4 (e5903078)
[   27.669006] ---[ end trace f5536249261ca351 ]---

