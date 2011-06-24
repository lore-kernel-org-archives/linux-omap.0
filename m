From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 13:14:10 -0700
Message-ID: <87mxh70yy5.fsf@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<20110624140142.GM9449@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
	<20110624141402.GN9449@n2100.arm.linux.org.uk>
	<20110624151201.GO9449@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2F56@dbde02.ent.ti.com>
	<20110624185107.GP9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40625 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752191Ab1FXUOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 16:14:14 -0400
Received: by mail-pz0-f50.google.com with SMTP id 2so2362057pzk.37
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 13:14:13 -0700 (PDT)
In-Reply-To: <20110624185107.GP9449@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 24 Jun 2011 19:51:07 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Jun 24, 2011 at 11:20:44PM +0530, Premi, Sanjeev wrote:
>> I was able to test BogoMIPS calculations via /proc/cpuinfo for
>> both with & without CONFIG_SMP selected.
>> 
>> For most part things work fine - but I do notice occassional Oops
>> and segmentation faults while doing "cat /proc/cpuinfo"
>> 
>> With CONFIG_SMP enabled, system doesn't recover from the Oops;
>> but without SMP - I noticed segmentation faults/ BUG but system
>> does recover.
>> 
>> They could be unrelated - but i didn't see any of these earlier
>> today. I will continue debug on MON.
>
> I don't think these are related to the patch - I think there's something
> up with your hardware.
>
> Let's take the first.
>
>> [root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
>> [   73.832366] Internal error: Oops - undefined instruction: 0 [#1] SMP
>
> Ok an undefined instruction.  So...
>
>> [   73.839019] Modules linked in:
>> [   73.842193] CPU: 0    Not tainted  (3.0.0-rc3-14002-g40b6752-dirty #21)
>> [   73.849121] PC is at __do_fault+0x1c0/0x450
>> [   73.853485] LR is at __do_fault+0x2b0/0x450
>> [   73.857879] pc : [<c010fa18>]    lr : [<c010fb08>]    psr: 00000113
>> [   73.857879] sp : c7907d48  ip : 00000000  fp : c5d518c0
>> [   73.869873] r10: 00000200  r9 : 40214000  r8 : 00000000
>> [   73.875335] r7 : c2692f98  r6 : c0ad7600  r5 : 87fb018f  r4 : 00000000
>> [   73.882141] r3 : 87fb0a3e  r2 : 00000800  r1 : 87fb01cf  r0 : c5d518c0
>> [   73.888977] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> [   73.896423] Control: 10c5387d  Table: 8795c019  DAC: 00000015
>> [   73.902435] Process cat (pid: 449, stack limit = 0xc79062f8)
>
> ... lets look at the code line:
>
>> [   74.176879] Code: e1a01005 e3a02000 ebfd1694 e59d0014 (eb07fcba)
>
> and disassemble it:
>
>    0:   e1a01005        mov     r1, r5
>    4:   e3a02000        mov     r2, #0  ; 0x0
>    8:   ebfd1694        bl      0xfff45a60
>    c:   e59d0014        ldr     r0, [sp, #20]
>   10:   eb07fcba        bl      0x1ff300
>
> There is no way that 0xeb07fcba should ever cause an undefined ARM
> instruction on a properly functioning system.
>
> It points at a hardware problem - are you using a socketed SoC?  Is
> it properly socketed?  Is the socket dirty?  And all other questions
> related to hardware integrity...

And in particular, since we're talking CPUfreq, are you running at a
frequency that the SoC and especially the memory support?

Kevin


