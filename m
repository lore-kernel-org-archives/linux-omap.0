From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 29 Nov 2012 12:33:53 +0100
Message-ID: <CAFqH_50RAJmHZy0kOz3vEqaNcrmUc_vGb1hDTHDiftxXpezK=Q@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
	<CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
	<50ADE6A5.3030001@ti.com>
	<CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
	<50AF37EA.3080400@ti.com>
	<CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
	<50B4A4D7.2070203@ti.com>
	<CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com>
	<50B74592.3020308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51147 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab2K2Ldy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 06:33:54 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so7556966pad.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 03:33:54 -0800 (PST)
In-Reply-To: <50B74592.3020308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

2012/11/29 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On 2012-11-27 21:15, Steve Sakoman wrote:
>
>> During my testing I think I uncovered another issue :-(
>>
>> I set omapdss.def_disp=lcd43 on the kernel command line to see if the
>> behavior changed with the LCD as the default device.
>>
>> What I encountered was a null pointer crash:
>>
>> [    3.483062] fbcvt: 1024x768@60: CVT Name - .786M3-R
>> [    3.488250] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000028
>> [    3.496765] pgd = c0004000
>> [    3.499603] [00000028] *pgd=00000000
>> [    3.503387] Internal error: Oops: 5 [#1] PREEMPT ARM
>> [    3.508605] Modules linked in:
>> [    3.511810] CPU: 0    Not tainted  (3.6.0 #1)
>> [    3.516357] PC is at dss_mgr_check_timings+0x4/0x30
>> [    3.521484] LR is at dpi_check_timings+0x18/0xb8
>> [    3.526336] pc : [<c025df70>]    lr : [<c0260dc0>]    psr: 40000013
>> [    3.526336] sp : dec2bd88  ip : 22222222  fp : def7e180
>> [    3.538330] r10: def951c0  r9 : def61000  r8 : de41b858
>> [    3.543823] r7 : dec2bdfc  r6 : c06c0a50  r5 : dec2be00  r4 : deea1cd4
>> [    3.550659] r3 : dec1ba40  r2 : dec2bdc8  r1 : dec2be00  r0 : 00000000
>> [    3.557495] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
>> Segment kernel
>> [    3.565155] Control: 10c5387d  Table: 80004019  DAC: 00000015
>> [    3.571166] Process swapper (pid: 1, stack limit = 0xdec2a2f0)
>> [    3.577270] Stack: (0xdec2bd88 to 0xdec2c000)
>> [    3.581848] bd80:                   dec1ba40 c0260dc0 ffffffff
>> deea1cd4 def7e180 c046a7d0
>> [    3.590423] bda0: 22222222 22222222 22222222 22222222 deea1cd4
>> c06c0a50 dec2be00 dec2bdfc
>> [    3.598968] bdc0: deea1cd4 c06c0a50 dec2be00 c026e738 c06c0a50
>> 00000000 de41b800 c046749c
>> [    3.607513] bde0: 0000003d c0495788 00000018 00000000 00000010
>> def98640 dec00140 00000000
>> [    3.616088] be00: 03000400 0000dac0 00300020 00040050 0003000f
>> 00000001 00000000 00000000
>> [    3.624664] be20: 00000001 00000000 00000000 c0459380 deea257c
>> c06c0d00 dec2be50 00000000
>> [    3.633209] be40: c025cc10 c029a98c 00000000 c029ae80 dec075d8
>> 00000000 00000000 de41b800
>> [    3.641784] be60: c06c1200 c06c3098 c06c3090 de41b80c 00000002
>> 00000001 de41b800 c0689470
>> [    3.650360] be80: def99148 def99148 dec2beb8 c01371c4 dec1ba40
>> 00000000 def99148 decdf208
>> [    3.658935] bea0: def95240 c0137e24 00000000 c0054e18 00000000
>> 00000003 decdf208 00000000
>> [    3.667510] bec0: c06e25dc c06c3098 c06e25dc c06e25dc c029c728
>> 0000009e 00000000 c068920c
>> [    3.676055] bee0: 00000000 c029d830 c029d81c c029c514 c06e25dc
>> c06c3098 c06c3098 c06c30cc
>> [    3.684631] bf00: c06e25dc c029c790 00000000 dec2bf18 c06e25dc
>> c029aa9c dec077d8 decd9670
>> [    3.693176] bf20: c06e25dc c06e25dc c06e8868 def95240 00000000
>> c029bb2c c05a9b18 c05a9b18
>> [    3.701751] bf40: c06e25dc 00000001 c06a0c9c c0710300 0000009e
>> c029ccb4 00000000 c06e25c8
>> [    3.710296] bf60: 00000001 c06a0c9c c0710300 0000009e c068920c
>> c029daa4 00000007 c06967d8
>> [    3.718872] bf80: c06a0c9c c0689234 dec2a000 c0008654 c068920c
>> 976c0d2e c06a0cc4 00000008
>> [    3.727447] bfa0: 00000007 c06967d8 c06a0c9c c0710300 0000009e
>> c0669160 c06967e0 c06698d8
>> [    3.735992] bfc0: 00000007 00000007 c0669160 00000013 00000000
>> 00000000 00000000 c06697a0
>> [    3.744567] bfe0: c000eea8 00000013 00000000 00000000 00000000
>> c000eea8 fffffff7 dffefffe
>> [    3.753143] [<c025df70>] (dss_mgr_check_timings+0x4/0x30) from
>> [<c0260dc0>] (dpi_check_timings+0x18/0xb8)
>> [    3.763183] [<c0260dc0>] (dpi_check_timings+0x18/0xb8) from
>> [<c026e738>] (tfp410_check_timings+0x28/0x3c)
>> [    3.773223] [<c026e738>] (tfp410_check_timings+0x28/0x3c) from
>> [<c046749c>] (omapfb_parse_def_modes+0x338/0x3f4)
>> [    3.783905] [<c046749c>] (omapfb_parse_def_modes+0x338/0x3f4) from
>> [<c0689470>] (omapfb_probe+0x210/0x600)
>> [    3.794036] [<c0689470>] (omapfb_probe+0x210/0x600) from
>> [<c029d830>] (platform_drv_probe+0x14/0x18)
>> [    3.803619] [<c029d830>] (platform_drv_probe+0x14/0x18) from
>> [<c029c514>] (driver_probe_device+0x11c/0x330)
>> [    3.813812] [<c029c514>] (driver_probe_device+0x11c/0x330) from
>> [<c029c790>] (__driver_attach+0x68/0x8c)
>> [    3.823760] [<c029c790>] (__driver_attach+0x68/0x8c) from
>> [<c029aa9c>] (bus_for_each_dev+0x48/0x80)
>> [    3.833251] [<c029aa9c>] (bus_for_each_dev+0x48/0x80) from
>> [<c029bb2c>] (bus_add_driver+0xf0/0x248)
>> [    3.842742] [<c029bb2c>] (bus_add_driver+0xf0/0x248) from
>> [<c029ccb4>] (driver_register+0x9c/0x12c)
>> [    3.852203] [<c029ccb4>] (driver_register+0x9c/0x12c) from
>> [<c029daa4>] (platform_driver_probe+0x18/0x9c)
>> [    3.862243] [<c029daa4>] (platform_driver_probe+0x18/0x9c) from
>> [<c0689234>] (omapfb_init+0x28/0x54)
>> [    3.871826] [<c0689234>] (omapfb_init+0x28/0x54) from [<c0008654>]
>> (do_one_initcall+0x90/0x160)
>> [    3.880950] [<c0008654>] (do_one_initcall+0x90/0x160) from
>> [<c06698d8>] (kernel_init+0x138/0x1f8)
>> [    3.890228] [<c06698d8>] (kernel_init+0x138/0x1f8) from
>> [<c000eea8>] (kernel_thread_exit+0x0/0x8)
>> [    3.899566] Code: e3e00015 e8bd8010 c05d88aa e92d4008 (e5900028)
>> [    3.906097] ---[ end trace 38f657b10d460537 ]---
>>
>> It seems that dss_mgr_check_timings is being called with a null dssdev->manager.
>>
>> Other than the fact that there should be a null pointer check in the
>> code, it seems that this is a regression since it used to be possible
>> to switch the default display in this fashion.  Is this no longer
>> allowed?
>
> It is allowed. Which kernel is that? I tried v3.7-rc4 and the current
> omapdss master, both work for me with overo + lcd43 add on.
>

Sorry for the delay, I also can't reproduce the issue, I think is
related due I upgrated the X server to a newer version. I would
recover my old rootfs to try to reproduce the issue...

>  Tomi
>
>
