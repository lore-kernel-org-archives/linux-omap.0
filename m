From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: pm-core broken
Date: Thu, 16 Dec 2010 08:36:57 -0800
Message-ID: <87wrn9hdxy.fsf@deeprootsystems.com>
References: <4D09719E.7080700@ti.com> <4D0978F3.3090704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:60222 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab0LPQhC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 11:37:02 -0500
Received: by pzk36 with SMTP id 36so660709pzk.11
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 08:37:01 -0800 (PST)
In-Reply-To: <4D0978F3.3090704@ti.com> (Nishanth Menon's message of "Wed, 15
	Dec 2010 20:26:59 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Hi Kevin,
>
> Just fyi, I tested pm-core(no patches of mine) against SDP3430(ES3.1)
> and Beagle Rev C1(ES3.0) (that is the only board I could dig up): both
> fail - I think basically <3630 is broken atm!.
>
> Beagleboard:
> with omap2plus_defconfig + MLO, u-boot.bin from
> http://www.angstrom-distribution.org/demo/beagleboard/
> filesystem is a minimal busybox that I had built and init=/bin/sh to
> prevent any other apps running in the background - I use the same on
> SDP3630 and 3430 platforms.
>
> branch: pm-core (from your tree).
> defconfig: omap2plus_defconfig - no changes other than disable RM680
> board - currently causes a build failure.

At least for Beagle (and I assume it's same for SDP, but don't have one
to test with) the problem is that u-boot leaves the USB OTG block in a
state that does not idle, and thus prevents CORE from hitting RET.

The solution: ensure the USB OTG block is reset.

Also in my tree, threre is an usb-otg-reset branch which you can merge
with pm-core to test if this helps.

Until we have the USB OTG hwmod conversion merged, this temporary hack
is needed.  After conversion to hwmod, all hwmod will be reset during
boot so we are not affected by bootloader (mis)behavior.

Kevin

> test script - same one I had send to ML earlier today
> replica here: http://pastebin.mozilla.org/889933
>
> log:
> # ./suspend-idle.sh 
>
> mount: no /proc/mounts 
>
> [   12.493682] PM: Syncing filesystems ... done. 
>
> [   12.749114] Freezing user space processes ... (elapsed 0.01
> seconds) done.
> [   12.774780] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) don
> e. 
>
> [   12.807891] Suspending console(s) (use no_console_suspend to debug) 
>
> [   12.930480] PM: suspend of devices complete after 111.450 msecs 
>
> [   12.933990] omap_device: i2c_omap.1: new worst case deactivate
> latency 0: 152
> 587 
>
> [   12.934234] PM: late suspend of devices complete after 3.692 msecs 
>
> [   12.934295] Disabling non-boot CPUs ... 
>
> [   12.934906] PM: Resume timer in 5.000 secs (163840 ticks at 32768
> ticks/sec.)
> [   12.935119] omap_device: omap-hsuart.1: new worst case deactivate
> latency 0:
> 30517 
>
> [   17.848388] omap_device: omap-hsuart.0: new worst case activate
> latency 0: 91
> 552 
>
> [   17.848541] Powerdomain (core_pwrdm) didn't enter target state 0 
>
> [   17.848571] Powerdomain (dss_pwrdm) didn't enter target state 0 
>
> [   17.848602] Could not enter target state in pm_suspend 
>
> [   17.850952] PM: early resume of devices complete after 1.983 msecs 
>
> [   18.238128] PM: resume of devices complete after 386.688 msecs 
>
> [   18.321746] Restarting tasks ... done. 
>
> SUSPEND:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (6 sec) 
>
> [   19.755401] PM: Syncing filesystems ... done. 
>
> [   19.801116] Freezing user space processes ... (elapsed 0.02
> seconds) done.
> [   19.829406] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) don
> e. 
>
> [   19.861419] Suspending console(s) (use no_console_suspend to debug) 
>
> [   19.984863] PM: suspend of devices complete after 112.487 msecs 
>
> [   19.988281] PM: late suspend of devices complete after 3.387 msecs 
>
> [   19.988311] Disabling non-boot CPUs ... 
>
> [   19.988616] PM: Resume timer in 5.000 secs (163840 ticks at 32768
> ticks/sec.)
> [   24.853942] Powerdomain (core_pwrdm) didn't enter target state 1 
>
> [   24.853942] Powerdomain (dss_pwrdm) didn't enter target state 1 
>
> [   24.853973] Could not enter target state in pm_suspend 
>
> [   24.855926] PM: early resume of devices complete after 1.739 msecs 
>
> [   25.243804] PM: resume of devices complete after 387.634 msecs 
>
> [   25.303649] Restarting tasks ... done. 
>
> SUSPEND:RET test | FAIL | OFF: 0->0| RET:0 ->0 (7 sec) 
>
> IDLE:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec) 
>
> IDLE:RET test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec) 
>
> usbhost_pwrdm
> (RET),OFF:2,RET:3,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm
> (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> per_pwrdm
> (ON),OFF:15,RET:22,INA:0,ON:38,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm
> (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0 
>
> cam_pwrdm
> (RET),OFF:2,RET:3,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm
> (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-ME
> MBANK2-OFF:0 
>
> neon_pwrdm (ON),OFF:15,RET:30,INA:0,ON:46,RET-LOGIC-OFF:0 
>
> mpu_pwrdm
> (ON),OFF:15,RET:30,INA:0,ON:46,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm
> (RET),OFF:2,RET:3,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-M
> EMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0 
>
> per_clkdm->per_pwrdm (9) 
>
> usbhost_clkdm->usbhost_pwrdm (0) 
>
> cam_clkdm->cam_pwrdm (0) 
>
> dss_clkdm->dss_pwrdm (0) 
>
> core_l4_clkdm->core_pwrdm (11) 
>
> core_l3_clkdm->core_pwrdm (4) 
>
> d2d_clkdm->core_pwrdm (0) 
>
> sgx_clkdm->sgx_pwrdm (0) 
>
> iva2_clkdm->iva2_pwrdm (0) 
>
> neon_clkdm->neon_pwrdm (0) 
>
> mpu_clkdm->mpu_pwrdm (0) 
>
> prm_clkdm->wkup_pwrdm (0) 
>
> cm_clkdm->core_pwrdm (0) 
>
>
>
> SUSPEND:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (6 sec) 
>
> SUSPEND:RET test | FAIL | OFF: 0->0| RET:0 ->0 (7 sec) 
>
> IDLE:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec) 
>
> IDLE:RET test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec) 
>
> # cat /sys/kernel/debug/pm_debug/registers/current 
>
> MOD: CM_IVA2 (48014000) 
>
>   04 => 00000037  20 => 00000001  34 => 00000001  40 => 0009680c 
>
>   44 => 00000001  48 => 00000003 
>
> MOD: CM_OCP (48004800) 
>
>   00 => 00000010  10 => 00000001 
>
> MOD: CM_MPU (48004900) 
>
>   04 => 00000037  24 => 00000001  34 => 00000001  40 => 0011f40c 
>
>   44 => 00000001  48 => 00000003  4c => 00000001 
>
> MOD: CM_CORE (48004a00) 
>
>   00 => 00006000  10 => 0103e042  20 => ffff9fbd  24 => 0000001f 
>
>   28 => 0000000d  30 => fffffed9  34 => 0000001f  38 => 0000000c 
>
>   40 => 0000030a  48 => 0000003f  4c => 00000003 
>
> MOD: CM_SGX (48004b00) 
>
>   20 => 00000001  40 => 00000002  48 => 00000003 
>
> MOD: CM_WKUP (48004c00) 
>
>   10 => 0000002e  20 => 000002f1  30 => 0000003f  40 => 00000015 
>
> MOD: CM_CCR (48004d00) 
>
>   00 => f0371037  04 => 00000031  20 => 00000a0b  30 => 00000009 
>
>   34 => 00000001  40 => 094c0c00  44 => 0001b00c  48 => 00000009 
>
>   4c => 0000780c  50 => 00000001  70 => 00000003 
>
> MOD: CM_DSS (48004e00) 
>
>   20 => 00000002  30 => 00000001  40 => 00001002  48 => 00000003 
>
>   4c => 00000001 
>
> MOD: CM_CAM (48004f00) 
>
>   20 => 00000001  30 => 00000001  40 => 00000004  48 => 00000003 
>
> MOD: CM_PER (48005000) 
>
>   00 => 00000800  10 => 0003e800  20 => 000017ff  30 => 0003ffff 
>
>   40 => 000000ff  44 => 00000006  48 => 00000003  4c => 00000001 
>
> MOD: CM_EMU (48005100) 
>
>   40 => 03020a50  48 => 00000002  4c => 00000001 
>
> MOD: CM_NEON (48005300) 
>
>   48 => 00000003 
>
> MOD: CM_USB (48005400) 
>
>   20 => 00000003  30 => 00000001  48 => 00000003 
>
> MOD: PRM_IVA2 (48316000) 
>
>   50 => 00000007  e0 => 00ff0f05  e4 => 00000555  e8 => 00000555 
>
>   f8 => 00000002 
>
> MOD: PRM_OCP (48306800) 
>
>   04 => 00000010  14 => 00000001  18 => 00000050  1c => 00000201 
>
> MOD: PRM_MPU (48306900) 
>
>   58 => 00000004  d4 => 00000012  e0 => 00030105  e4 => 000000c7 
>
>   e8 => 00000045 
>
> MOD: PRM_CORE (48306a00) 
>
>   58 => 00000300  a0 => c33ffe18  a4 => c33ffe18  e0 => 000f0305 
>
>   e4 => 000000f7  e8 => 000000f7  f0 => 00000004  f8 => 00000004 
>
> MOD: PRM_SGX (48306b00) 
>
>   e0 => 00030104 
>
> MOD: PRM_WKUP (48306c00) 
>
>   a0 => 0000000b  a4 => 0000010b 
>
> MOD: PRM_CCR (48306d00) 
>
>   40 => 00000003 
>
> MOD: PRM_DSS (48306e00) 
>
>   a0 => 00000001  e0 => 00030105  e4 => 00000003  e8 => 00000003 
>
> MOD: PRM_CAM (48306f00) 
>
>   58 => 00000001  e0 => 00030105  e4 => 00000001  e8 => 00000001 
>
> MOD: PRM_PER (48307000) 
>
>   58 => 00000004  a0 => 0003e807  a4 => 0003e807  c8 => 00000006 
>
>   e0 => 00030105  e4 => 00000007  e8 => 00000005 
>
> MOD: PRM_EMU (48307100) 
>
>   58 => 00000004  e4 => 00000103 
>
> MOD: PRM_GLBL (48307200) 
>
>   38 => 00000018  54 => 00001006  58 => 00000001  64 => 00000050 
>
>   70 => 00000088  9c => 0000000a  c4 => 00000001  e4 => 00000001 
>
> MOD: PRM_NEON (48307300) 
>
>   58 => 00000004  c8 => 00000002  e0 => 00000005  e4 => 00000003 
>
>   e8 => 00000001 
>
> MOD: PRM_USB (48307400) 
>
>   58 => 00000004  a0 => 00000001  a4 => 00000001  a8 => 00000001 
>
>   e0 => 00030105  e4 => 00000001  e8 => 00000001
