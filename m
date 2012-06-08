From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: suspend broken on 3.5-rc1?
Date: Fri, 08 Jun 2012 18:46:55 +0530
Message-ID: <4FD1FB47.8040007@ti.com>
References: <4FD1D570.1010508@ti.com> <20120608105611.GO12766@atomide.com>	 <4FD1EF25.3060906@ti.com> <1339160732.2091.47.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48611 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752703Ab2FHNRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 09:17:03 -0400
Received: by obbuo13 with SMTP id uo13so2302620obb.15
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 06:17:01 -0700 (PDT)
In-Reply-To: <1339160732.2091.47.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

On Friday 08 June 2012 06:35 PM, Tero Kristo wrote:
> On Fri, 2012-06-08 at 17:55 +0530, Rajendra Nayak wrote:
>> On Friday 08 June 2012 04:26 PM, Tony Lindgren wrote:
>>> * Rajendra Nayak<rnayak@ti.com>   [120608 03:40]:
>>>> Hi,
>>>>
>>>> I don;t seem to be able to get suspend to work on 3.5-rc1 on
>>>> my 4430 panda. I am not sure if its UART wakeups that are
>>>> an issue or suspend itself is broken.
>>>> Is there anything more than setting
>>>> '/sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup'
>>>> to 'enabled' that I need to do to get UART to be wakeup capable?
>>>>
>>>> 3.4 major works just fine for me.
>>>
>>> Can you try with the fixes branch that Olof just merged?
>>
>> I tried merging the fixes branch on 3.5-rc1 as well as latest
>> mainline and both didn't work.
>>
>>> If it's the UART wake-up events, there's a patch that should
>>> help.
>>>
>>> Tony
>>
>
> The patch referenced here helps:
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69596.html
>
> DSS crashes during wakeup from suspend.

great, thats what I found too with no_console_suspend, didn't know
a fix already exists. Thanks.

[   10.086334] Device name omapdss_dss
[   10.089996] Device name omapdss_dispc
[   10.093872] Device name omapdss_rfbi
[   10.097625] Device name omapdss_venc
[   10.101379] Device name omapdss_dsi.0
[   10.105224] Device name omapdss_dsi.1
[   10.109069] Device name omapdss_hdmi
[   10.112854] Device name omapdss_dpi
[   10.116516] Unable to handle kernel NULL pointer dereference at 
virtual address 00000018
[   10.125030] pgd = ee6ac000
[   10.127868] [00000018] *pgd=ae6c3831, *pte=00000000, *ppte=00000000
[   10.134490] Internal error: Oops: 17 [#1] SMP ARM
[   10.139434] Modules linked in:
[   10.142608] CPU: 0    Not tainted  (3.5.0-rc1-00143-ge8126d1-dirty #5)
[   10.149475] PC is at _od_resume_noirq+0x28/0x74
[   10.154235] LR is at _od_resume_noirq+0x28/0x74
[   10.158966] pc : [<c003be7c>]    lr : [<c003be7c>]    psr: 20000113
[   10.158966] sp : ee737e78  ip : c073fd80  fp : 00000006
[   10.171020] r10: ef1848b8  r9 : c0703010  r8 : c003be54
[   10.176483] r7 : 00000000  r6 : ef184800  r5 : 00000000  r4 : ef184808
[   10.183349] r3 : ef12d4c0  r2 : 00000000  r1 : ef12d950  r0 : 00000017
[   10.190185] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[   10.197662] Control: 10c53c7d  Table: ae6ac04a  DAC: 00000015
[   10.203674] Process sh (pid: 627, stack limit = 0xee7362f8)
[   10.209533] Stack: (0xee737e78 to 0xee738000)
[   10.214111] 7e60: 
    ef184808 ef184808
[   10.222686] 7e80: 00000000 c02be138 c0702fb4 c0702fd4 00000000 
00000000 ef184808 c0c69364
[   10.231262] 7ea0: 00000010 c0702fa8 c0703008 c02beccc 52d639d6 
00000002 52d639d6 00000002
[   10.239837] 7ec0: c06eb3f8 00000010 00000000 00000003 c0719f1c 
00000000 00000000 c06a8244
[   10.248413] 7ee0: 00000000 c02bf568 c072f9e8 c0080240 00000003 
c059933c 00000000 00000004
[   10.256988] 7f00: 00000000 c04af304 ef041440 c0080584 ef38f000 
00000003 c059933c c007f788
[   10.265563] 7f20: ef2dc8c0 ef2dc8d8 ee737f80 ef097e00 c0264728 
c0264740 00000004 c016aa44
[   10.274139] 7f40: ef0d4cc0 00000004 b6f05000 ee737f80 00000000 
00000000 00000000 c01096f4
[   10.282714] 7f60: c0014400 ef12d4c0 ef0d4cc0 b6f05000 00000004 
00000004 00000000 c0109848
[   10.291290] 7f80: 00000000 00000000 b6e325e8 00000000 00000004 
b6f05000 b6e325e8 c00144a8
[   10.299865] 7fa0: ee736000 c00142e0 00000004 b6f05000 00000001 
b6f05000 00000004 00000000
[   10.308441] 7fc0: 00000004 b6f05000 b6e325e8 00000004 00000004 
00000964 0000000a 00000000
[   10.317016] 7fe0: b6f05000 beecb5d0 b6d70c70 b6dc0abc 60000110 
00000001 af6fe821 af6fec21
[   10.325622] [<c003be7c>] (_od_resume_noirq+0x28/0x74) from 
[<c02be138>] (dpm_run_callback+0x2c/0x74)
[   10.335205] [<c02be138>] (dpm_run_callback+0x2c/0x74) from 
[<c02beccc>] (dpm_resume_noirq+0xdc/0x2f4)
[   10.344879] [<c02beccc>] (dpm_resume_noirq+0xdc/0x2f4) from 
[<c02bf568>] (dpm_resume_start+0xc/0x18)
[   10.354461] [<c02bf568>] (dpm_resume_start+0xc/0x18) from 
[<c0080240>] (suspend_devices_and_enter+0x114/0x2d8)
[   10.364959] [<c0080240>] (suspend_devices_and_enter+0x114/0x2d8) from 
[<c0080584>] (pm_suspend+0x180/0x1fc)
[   10.375183] [<c0080584>] (pm_suspend+0x180/0x1fc) from [<c007f788>] 
(state_store+0x90/0x124)
[   10.384063] [<c007f788>] (state_store+0x90/0x124) from [<c0264740>] 
(kobj_attr_store+0x18/0x1c)
[   10.393188] [<c0264740>] (kobj_attr_store+0x18/0x1c) from 
[<c016aa44>] (sysfs_write_file+0xfc/0x180)
[   10.402770] [<c016aa44>] (sysfs_write_file+0xfc/0x180) from 
[<c01096f4>] (vfs_write+0xb0/0x134)
[   10.411895] [<c01096f4>] (vfs_write+0xb0/0x134) from [<c0109848>] 
(sys_write+0x40/0x70)
[   10.420318] [<c0109848>] (sys_write+0x40/0x70) from [<c00142e0>] 
(ret_fast_syscall+0x0/0x3c)
[   10.429168] Code: e1a04000 05901008 e59f0048 eb112432 (e5d53018)
[   10.435607] ---[ end trace 0cf97fb0a3cafe35 ]---

>
> -Tero
>
>

