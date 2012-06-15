From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Fri, 15 Jun 2012 17:34:27 +0530
Message-ID: <CAP05o4KaZ93Nt58h5ZccWeM2EazLtwOcV5rkmLvijuB5HRbJ8g@mail.gmail.com>
References: <87zk8yxx9l.fsf@ti.com>
	<4FBD7FDC.9050307@ti.com>
	<CAP05o4KNnrKdmgJ=Ky=MS4pwEoEErH+Agkm2EwN1i1UDb-CbPQ@mail.gmail.com>
	<871um9wlzx.fsf@ti.com>
	<878vghut1u.fsf@ti.com>
	<4FCE46E7.60702@ti.com>
	<CAP05o4L+0E6fa1VoP_UPTJgKjXb-VqZorUfzsTB3d-KVoFrXfw@mail.gmail.com>
	<CAP05o4KuoQHhTRTCtdpiywgC1HjwzXZHhROKOgSLhoK76Z2aaQ@mail.gmail.com>
	<87fwa56gxp.fsf@ti.com>
	<CAP05o4JEEp-yXjijeeejN3j8uVBDQ35DMGqP9UKj3f7sNnO8LA@mail.gmail.com>
	<CAP05o4LYhFQpEFukyCT2fA7XHPU2L5K8=8W0fncMJk6YEUWdOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:34922 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868Ab2FOMEb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 08:04:31 -0400
Received: by lboj14 with SMTP id j14so3463198lbo.35
        for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 05:04:28 -0700 (PDT)
In-Reply-To: <CAP05o4LYhFQpEFukyCT2fA7XHPU2L5K8=8W0fncMJk6YEUWdOQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Ameya Palande <ameya.palande@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

On Tue, Jun 12, 2012 at 6:28 PM, Munegowda, Keshava
<keshava_mgowda@ti.com> wrote:
> hi kevin
> =A0=A0=A0=A0=A0=A0=A0 now I am using initramfs with kernel linux3.5.r=
c1,
> but the retention is not working in 3430 sdp.=A0 I am seeing the foll=
owing
> error followed by a crash
>
>
> echo mem > /sys/power/state
> [=A0=A0 35.609252] PM: Syncing filesystems ... done.
> [=A0=A0 35.614654] PM: Preparing system for mem sleep
> [=A0=A0 35.658630] Freezing user space processes ... (elapsed 0.01 se=
conds)
> done.
> [=A0=A0 35.689727] Freezing remaining freezable tasks ... (elapsed 0.=
02 seconds)
> done.
> [=A0=A0 35.697692] PM: Entering mem sleep
> [=A0=A0 35.722442] usb usb1: usb auto-resume
> [=A0=A0 35.726409] ehci-omap ehci-omap.0: resume root hub
> [=A0=A0 35.775451] hub 1-0:1.0: hub_resume
> [=A0=A0 35.779846] hub 1-0:1.0: hub_suspend
> [=A0=A0 35.784240] usb usb1: bus suspend, wakeup 0
> [=A0=A0 35.788665] ehci-omap ehci-omap.0: suspend root hub
> [=A0=A0 35.805786] PM: suspend of devices complete after 99.304 msecs
> [=A0=A0 35.816497] PM: late suspend of devices complete after 4.364 m=
secs
> [=A0=A0 35.831573] PM: noirq suspend of devices complete after 8.331 =
msecs
> [=A0=A0 35.838500] Disabling non-boot CPUs ...
> [=A0=A0 36.312164] Powerdomain (core_pwrdm) didn't enter target state=
 1
> [=A0=A0 36.318481] Could not enter target state in pm_suspend
> [=A0=A0 36.324859] Unable to handle kernel NULL pointer dereference a=
t virtual
> address 00000018
> [=A0=A0 36.333557] pgd =3D c6280000
> [=A0=A0 36.336639] [00000018] *pgd=3D85c8f831, *pte=3D00000000, *ppte=
=3D00000000
> [=A0=A0 36.343414] Internal error: Oops: 17 [#1] SMP ARM
> [=A0=A0 36.348388] Modules linked in:
> [=A0=A0 36.351623] CPU: 0=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0=A0=A0 W=A0=
=A0=A0=A0 (3.5.0-rc1 #1)
> [=A0=A0 36.357574] PC is at _od_resume_noirq+0x14/0x58
> [=A0=A0 36.362365] LR is at dpm_run_callback+0x2c/0x74
> [=A0=A0 36.367126] pc : [<c003c150>]=A0=A0=A0 lr : [<c02d75e4>]=A0=A0=
=A0 psr: a0000013
> [=A0=A0 36.367126] sp : c5ebfe80=A0 ip : c0a72fc0=A0 fp : 00000006
> [=A0=A0 36.379150] r10: c78af4b8=A0 r9 : c0a3607c=A0 r8 : c003c13c
> [=A0=A0 36.384643] r7 : 00000000=A0 r6 : 00000000=A0 r5 : c78af408=A0=
 r4 : c78af408
> [=A0=A0 36.391479] r3 : 00000000=A0 r2 : 00000000=A0 r1 : c78af408=A0=
 r0 : c78af400
> [=A0=A0 36.398315] Flags: NzCv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0=
 ISA ARM=A0 Segment
> user
> [=A0=A0 36.405792] Control: 10c5387d=A0 Table: 86280019=A0 DAC: 00000=
015
> [=A0=A0 36.411834] Process sh (pid: 1254, stack limit =3D 0xc5ebe2f8)
> [=A0=A0 36.417785] Stack: (0xc5ebfe80 to 0xc5ec0000)
> [=A0=A0 36.422363] fe80: c78af408 c02d75e4 c0a36020 c0a36040 00000000=
 00000000
> c78af408 c0f9e4a8
> [=A0=A0 36.430938] fea0: 00000010 c0a36014 c0a36074 c02d8178 58566b0d=
 00000008
> 58566b0d 00000008
> [=A0=A0 36.439514] fec0: c0a1df38 00000010 ffffffff 00000003 c0a4d11c=
 00000000
> 00000000 c09da45c
> [=A0=A0 36.448089] fee0: 000ed008 c02d8a14 c0a62c28 c0080360 00000003=
 c05b9ce8
> 00000000 00000004
> [=A0=A0 36.456665] ff00: 00000000 c04c9704 c78012c0 c00806a4 c5c8e000=
 00000003
> c05b9ce8 c007f8a8
> [=A0=A0 36.465240] ff20: c5c8d4c0 c5c8d4d8 c5ebff80 c7863e00 c02674a8=
 c02674c0
> 00000004 c016d7fc
> [=A0=A0 36.473815] ff40: c5d94a80 00000004 b6ff6000 c5ebff80 00000000=
 00000000
> 00000000 c010c244
> [=A0=A0 36.482421] ff60: c0014400 c5c92280 c5d94a80 b6ff6000 00000004=
 00000004
> 00000000 c010c398
> [=A0=A0 36.490997] ff80: 00000000 00000000 b6f235e8 00000000 00000004=
 b6ff6000
> b6f235e8 c00144a8
> [=A0=A0 36.499572] ffa0: c5ebe000 c00142e0 00000004 b6ff6000 00000001=
 b6ff6000
> 00000004 00000000
> [=A0=A0 36.508148] ffc0: 00000004 b6ff6000 b6f235e8 00000004 00000004=
 00000964
> 0000000a 000ed008
> [=A0=A0 36.516723] ffe0: b6ff6000 bee815d0 b6e61c70 b6eb1abc 60000010=
 00000001
> 00000000 00000000
> [=A0=A0 36.525360] [<c003c150>] (_od_resume_noirq+0x14/0x58) from [<c=
02d75e4>]
> (dpm_run_callback+0x2c/0x74)
> [=A0=A0 36.534973] [<c02d75e4>] (dpm_run_callback+0x2c/0x74) from [<c=
02d8178>]
> (dpm_resume_noirq+0xdc/0x2f4)
> [=A0=A0 36.544677] [<c02d8178>] (dpm_resume_noirq+0xdc/0x2f4) from [<=
c02d8a14>]
> (dpm_resume_start+0xc/0x18)
> [=A0=A0 36.554290] [<c02d8a14>] (dpm_resume_start+0xc/0x18) from [<c0=
080360>]
> (suspend_devices_and_enter+0x114/0x2d8)
> [=A0=A0 36.564819] [<c0080360>] (suspend_devices_and_enter+0x114/0x2d=
8) from
> [<c00806a4>] (pm_suspend+0x180/0x1fc)
> [=A0=A0 36.575042] [<c00806a4>] (pm_suspend+0x180/0x1fc) from [<c007f=
8a8>]
> (state_store+0x90/0x124)
> [=A0=A0 36.583953] [<c007f8a8>] (state_store+0x90/0x124) from [<c0267=
4c0>]
> (kobj_attr_store+0x18/0x1c)
> [=A0=A0 36.593109] [<c02674c0>] (kobj_attr_store+0x18/0x1c) from [<c0=
16d7fc>]
> (sysfs_write_file+0xfc/0x180)
> [=A0=A0 36.602722] [<c016d7fc>] (sysfs_write_file+0xfc/0x180) from [<=
c010c244>]
> (vfs_write+0xb0/0x134)
> [=A0=A0 36.611877] [<c010c244>] (vfs_write+0xb0/0x134) from [<c010c39=
8>]
> (sys_write+0x40/0x70)
> [=A0=A0 36.620300] [<c010c398>] (sys_write+0x40/0x70) from [<c00142e0=
>]
> (ret_fast_syscall+0x0/0x3c)
> [=A0=A0 36.629180] Code: e1a04000 e2500008 01a02000 15902248 (e5d2301=
8)
> [=A0=A0 36.635833] ---[ end trace b3b167c1e86e5512 ]---
>
>
> which kernel version are you using? do you have any good commit on wh=
ich
> retention works because of usb host?
>
>
> regards
> keshava
>
>
>
> On Fri, Jun 8, 2012 at 7:55 PM, Munegowda, Keshava <keshava_mgowda@ti=
=2Ecom>
> wrote:
>>
>> yes! I am using the ramfs.
>>
>> regards
>> keshava
>>
>>
>>
>> On Fri, Jun 8, 2012 at 7:31 PM, Kevin Hilman <khilman@ti.com> wrote:
>>>
>>> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
>>>
>>> > =A0 =A0hi Ameya
>>> > =A0 =A0 =A0 =A0 I was trying to reproduce the 3430 usb pm issues =
; but i see
>>> > that
>>> > =A0 =A0NFS is not working in 3430 sdp;
>>>
>>> You don't need NFS to reproduce this. =A0If you can't get NFS to wo=
rk,
>>> just use a busybox initramfs.
>>>
>>> This bug needs to be fixed for v3.5-rc.
>>>
>>> Kevin
>>>
>>> > =A0 =A0it is because of the following the UART patch series (21 p=
atch). I
>>> > =A0 =A0couldn't able to figure out the actual patch which
>>> > =A0 =A0 =A0breaks NFS because individual patches in this series d=
oes not
>>> > =A0 =A0compile.
>>> > =A0 =A0these patches are already in lo master.
>>> > =A0 =A0here is the patch list:
>>> >
>>> > =A0--------------------------------------------------------------=
---------
>>> > =A0 =A0----------------------------------------------------------=
--------
>>> > =A0 =A0commit da27468655540b083525177f5dc6f3b1f6e3b869
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Wed Dec 14 21:24:11 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Fix compilation/sparse warnings
>>> >
>>> > =A0 =A0 =A0 =A0Fixes below compilation warning.
>>> >
>>> > =A0 =A0 =A0 =A0drivers/tty/serial/omap-serial.c: In function 'ser=
ial_omap_irq':
>>> > =A0 =A0 =A0 =A0drivers/tty/serial/omap-serial.c:228:29: warning: =
'ch' may be
>>> > used
>>> > =A0 =A0uninitialized in this function [-Wuninitialized]
>>> >
>>> > =A0 =A0 =A0 =A0Fix below sparse warning.
>>> >
>>> > =A0 =A0 =A0 =A0drivers/tty/serial/omap-serial.c:392:52: warning: =
incorrect type
>>> > in
>>> > =A0 =A0argument 2 (different signedness)
>>> > =A0 =A0 =A0 =A0drivers/tty/serial/omap-serial.c:392:52: =A0 =A0ex=
pected int *status
>>> > =A0 =A0 =A0 =A0drivers/tty/serial/omap-serial.c:392:52: =A0 =A0go=
t unsigned int
>>> > =A0 =A0*<noident>
>>> >
>>> > =A0 =A0 =A0 =A0Reported-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 2fd149645eb46d26130d7070c6de037dddf34880
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Wed Nov 9 17:41:21 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Remove omap_uart_can_sleep and =
add pm_qos
>>> >
>>> > =A0 =A0 =A0 =A0Omap_uart_can_sleep function blocks system wide lo=
w power state
>>> > =A0 =A0until
>>> > =A0 =A0 =A0 =A0uart is active remove this func and add qos reques=
ts to prevent
>>> > =A0 =A0 =A0 =A0MPU from transitioning.
>>> >
>>> > =A0 =A0 =A0 =A0Keep qos request to default value which will allow=
 MPU to
>>> > =A0 =A0transition
>>> > =A0 =A0 =A0 =A0and while uart baud rate is available calculate th=
e latency
>>> > value
>>> > =A0 =A0 =A0 =A0from the baudrate and use the same to hold constra=
int while uart
>>> > =A0 =A0clocks
>>> > =A0 =A0 =A0 =A0are enabled, and if uart is auto-idled the constra=
int is updated
>>> > =A0 =A0with
>>> > =A0 =A0 =A0 =A0default constraint value allowing MPU to transitio=
n.
>>> >
>>> > =A0 =A0 =A0 =A0Qos requests are blocking notifier calls so put th=
ese requests
>>> > to
>>> > =A0 =A0 =A0 =A0work queue, also the driver uses irq_safe version =
of runtime
>>> > API's
>>> > =A0 =A0 =A0 =A0and callbacks can be called in interrupt disabled =
context.
>>> > =A0 =A0 =A0 =A0So to avoid warn on slow path warning while using =
qos update
>>> > =A0 =A0 =A0 =A0API's from runtime callbacks use the qos_work_queu=
e.
>>> >
>>> > =A0 =A0 =A0 =A0During bootup the runtime_resume call backs might =
not be called
>>> > and
>>> > =A0 =A0runtime
>>> > =A0 =A0 =A0 =A0callback gets called only after uart is idled by s=
etting the
>>> > =A0 =A0autosuspend
>>> > =A0 =A0 =A0 =A0timeout. So qos_request from runtime resume callba=
ck might not
>>> > =A0 =A0activated during
>>> > =A0 =A0 =A0 =A0boot if uart baudrate is calculated during bootup =
for console
>>> > uart,
>>> > =A0 =A0so schedule
>>> > =A0 =A0 =A0 =A0the qos_work queue once we calc_latency while conf=
iguring the
>>> > uart
>>> > =A0 =A0port.
>>> >
>>> > =A0 =A0 =A0 =A0Flush and complete any pending qos jobs in work qu=
eue while
>>> > =A0 =A0suspending.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 36fc2d15b120ef85be74c68b5ad74ac04fbefa8a
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Wed Sep 21 16:54:12 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Do not gate uart clocks if used=
 for
>>> > debug_prints
>>> >
>>> > =A0 =A0 =A0 =A0If OMAP UART is used as console uart and debug is =
enabled,
>>> > =A0 =A0 =A0 =A0avoid gating of uart clocks to print all debug pri=
nts.
>>> >
>>> > =A0 =A0 =A0 =A0If uart clocks are gated then the debug prints fro=
m omap_device
>>> > =A0 =A0 =A0 =A0framework or hwmod framework can cause uart to ent=
er recursive
>>> > =A0 =A0 =A0 =A0pm_runtime calls, which can cause a deadlock over =
power lock
>>> > usage.
>>> >
>>> > =A0 =A0 =A0 =A0For example: Say, uart clocks are cut and we get a=
 print from
>>> > =A0 =A0 =A0 =A0omap_device_disable stating disabling uart clocks.=
 This print
>>> > =A0 =A0 =A0 =A0calls omap_uart driver console_write which will ca=
ll runtime API
>>> > =A0 =A0 =A0 =A0get_sync which means we enter from runtime API put=
 context to
>>> > =A0 =A0 =A0 =A0runtime API get context.
>>> >
>>> > =A0 =A0 =A0 =A0--> runtime put (take power lock)
>>> > =A0 =A0 =A0 =A0 =A0 =A0--> print disabling uart clocks
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--> call uart console write
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--> call get_sync (try to =
take power lock)
>>> >
>>> > =A0 =A0 =A0 =A0Also any clock enable API call from uart driver sh=
ould not call
>>> > any
>>> > =A0 =A0uart
>>> > =A0 =A0 =A0 =A0operation until clocks are enabled back. Like get_=
sync having
>>> > debug
>>> > =A0 =A0print
>>> > =A0 =A0 =A0 =A0calling uart console write even before clocks are =
enabled.
>>> >
>>> > =A0 =A0 =A0 =A0So to avoid these scenarios, identify from bootarg=
s if
>>> > =A0 =A0OMAP_UART(ttyO) is used
>>> > =A0 =A0 =A0 =A0in debug mode. If so, do not set device_may_wakeup=
=2E This will
>>> > =A0 =A0prevent
>>> > =A0 =A0 =A0 =A0pm_runtime_enable in uart driver and will avoid ua=
rt clock
>>> > gating.
>>> > =A0 =A0 =A0 =A0Debug is enabled either by adding debug word in bo=
otarg or by
>>> > =A0 =A0setting
>>> > =A0 =A0 =A0 =A0loglevel=3D10
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 08f86b3eab9807e6d36de7e00025abad893ff557
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Tue Oct 18 17:09:10 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Avoid uart idling on suspend fo=
r
>>> > =A0 =A0no_console_suspend usecase
>>> >
>>> > =A0 =A0 =A0 =A0If no_console_suspend is used we have prevent uart=
 idling during
>>> > =A0 =A0suspend
>>> > =A0 =A0 =A0 =A0to provide debug prints.
>>> >
>>> > =A0 =A0 =A0 =A0Power domain hooks can idle uarts if left enabled =
during system
>>> > =A0 =A0wide suspend
>>> > =A0 =A0 =A0 =A0so re-use the omap_device_disable_idle_on_suspend =
API's to
>>> > ensure
>>> > =A0 =A0console_uart
>>> > =A0 =A0 =A0 =A0is not idled during suspend.
>>> >
>>> > =A0 =A0 =A0 =A0omap_device_disable_idle_on_suspend API was used o=
n all uarts
>>> > since
>>> > =A0 =A0the uart
>>> > =A0 =A0 =A0 =A0driver was not runtime adapted, now with runtime a=
daptation we
>>> > can
>>> > =A0 =A0re-use this
>>> > =A0 =A0 =A0 =A0API only for no_console_suspend use cases.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 8612bd22f30369745d0fda0d540aca39ab591cc5
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Nov 7 19:05:44 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Avoid console uart idling durin=
g bootup
>>> >
>>> > =A0 =A0 =A0 =A0Omap-uart can be used as console uart to print ear=
ly boot
>>> > messages
>>> > =A0 =A0using
>>> > =A0 =A0 =A0 =A0earlyprintk so for console uart prevent hwmod rese=
t or idling
>>> > =A0 =A0during bootup.
>>> >
>>> > =A0 =A0 =A0 =A0Identify omap-uart used as console and avoid idlin=
g rather than
>>> > =A0 =A0preventing
>>> > =A0 =A0 =A0 =A0all omap-uarts from idling during bootup. Update t=
he comments
>>> > for
>>> > =A0 =A0the same.
>>> >
>>> > =A0 =A0 =A0 =A0Remove the uart idling and enabling back using
>>> > =A0 =A0hwmod_idle/omap_device_enable
>>> > =A0 =A0 =A0 =A0for all uarts that where left enabled from boot to=
 set the hwmod
>>> > =A0 =A0framework
>>> > =A0 =A0 =A0 =A0state machine right. This need not be taken care a=
ny more
>>> > serial.c
>>> > =A0 =A0rather
>>> > =A0 =A0 =A0 =A0can be handled within the hwmod framework.
>>> > =A0 =A0 =A0 =A0Reference: http://www.spinics.net/lists/linux-omap=
/msg60300.html
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 969996a57fd2345a1141280dddcf9e10fa5f6690
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Tue Oct 18 16:32:14 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: remove temporary variable used =
to count uart
>>> > =A0 =A0instance
>>> >
>>> > =A0 =A0 =A0 =A0Reuse the num_uarts variable itself to count numbe=
r of uarts.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit a9e210e0b7a344c0e44aa6bf6888176bbc635c42
>>> > =A0 =A0Author: Jon Hunter <jon-hunter@ti.com>
>>> > =A0 =A0Date: =A0 Wed Nov 9 17:34:49 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Make the RX_TIMEOUT for DMA con=
figurable for
>>> > =A0 =A0each UART
>>> >
>>> > =A0 =A0 =A0 =A0When using DMA there are two timeouts defined. The=
 first
>>> > timeout,
>>> > =A0 =A0 =A0 =A0rx_timeout, is really a polling rate in which soft=
ware polls the
>>> > =A0 =A0 =A0 =A0DMA status to see if the DMA has finished. This is=
 necessary for
>>> > =A0 =A0 =A0 =A0the RX side because we do not know how much data w=
e will
>>> > receive.
>>> > =A0 =A0 =A0 =A0The secound timeout, RX_TIMEOUT, is a timeout afte=
r which the
>>> > =A0 =A0 =A0 =A0DMA will be stopped if no more data is received. T=
o make this
>>> > =A0 =A0 =A0 =A0clearer, rename rx_timeout as rx_poll_rate and ren=
ame the
>>> > =A0 =A0 =A0 =A0function serial_omap_rx_timeout() to serial_omap_r=
xdma_poll().
>>> >
>>> > =A0 =A0 =A0 =A0The OMAP-Serial driver defines an RX_TIMEOUT of 3 =
seconds that
>>> > is
>>> > =A0 =A0 =A0 =A0used to indicate when the DMA for UART can be stop=
ped if no more
>>> > =A0 =A0 =A0 =A0data is received. The value is a global definition=
 that is
>>> > applied
>>> > =A0 =A0 =A0 =A0to all instances of the UART.
>>> >
>>> > =A0 =A0 =A0 =A0Each UART may be used for a different purpose and =
so the timeout
>>> > =A0 =A0 =A0 =A0required may differ. Make this value configurable =
for each UART
>>> > so
>>> > =A0 =A0 =A0 =A0that this value can be optimised for power savings=
=2E
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit c86845db77ce220f77e6645b18800744684946ac
>>> > =A0 =A0Author: Deepak K <deepak.k@ti.com>
>>> > =A0 =A0Date: =A0 Wed Nov 9 17:33:38 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Allow UART parameters to be con=
figured from
>>> > =A0 =A0board file.
>>> >
>>> > =A0 =A0 =A0 =A0The following UART parameters are defined within t=
he UART
>>> > driver:
>>> >
>>> > =A0 =A0 =A0 =A01). Whether the UART uses DMA (dma_enabled), by de=
fault set to 0
>>> > =A0 =A0 =A0 =A02). The size of dma buffer (set to 4096 bytes)
>>> > =A0 =A0 =A0 =A03). The time after which the dma should stop if no=
 more data is
>>> > =A0 =A0received.
>>> > =A0 =A0 =A0 =A04). The auto suspend delay that will be passed for
>>> > =A0 =A0pm_runtime_autosuspend
>>> > =A0 =A0 =A0 =A0 =A0 =A0where uart will be disabled after timeout
>>> >
>>> > =A0 =A0 =A0 =A0Different UARTs may be used for different purpose =
such as the
>>> > =A0 =A0console,
>>> > =A0 =A0 =A0 =A0for interfacing bluetooth chip, for interfacing to=
 a modem chip,
>>> > =A0 =A0etc.
>>> > =A0 =A0 =A0 =A0Therefore, it is necessary to be able to customize=
 the above
>>> > =A0 =A0settings
>>> > =A0 =A0 =A0 =A0for a given board on a per UART basis.
>>> >
>>> > =A0 =A0 =A0 =A0This change allows these parameters to be configur=
ed from the
>>> > board
>>> > =A0 =A0file
>>> > =A0 =A0 =A0 =A0and allows the parameters to be configured for eac=
h UART
>>> > =A0 =A0independently.
>>> >
>>> > =A0 =A0 =A0 =A0If a board does not define its own custom paramete=
rs for the
>>> > UARTs,
>>> > =A0 =A0then
>>> > =A0 =A0 =A0 =A0use the default parameters in the structure
>>> > =A0 =A0"omap_serial_default_info".
>>> > =A0 =A0 =A0 =A0The default parameters are defined to be the same =
as the current
>>> > =A0 =A0settings
>>> > =A0 =A0 =A0 =A0in the UART driver to avoid breaking the UART for =
any cuurnelty
>>> > =A0 =A0supported
>>> > =A0 =A0 =A0 =A0boards. By default, make all boards use the defaul=
t UART
>>> > =A0 =A0parameters.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Deepak K <deepak.k@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 634bd6e4817cd6a7109be8d2eee5c578a283d1ee
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Nov 7 19:01:24 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Remove old and unused clocks ha=
ndling funcs
>>> >
>>> > =A0 =A0 =A0 =A0With runtime adaptation done remove clock_enable/d=
isbale API's
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 62f3ec5fbd5fddce62b7a71adc04723a5eb903da
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Thu Oct 13 14:11:09 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Add wakeup mechanism for omap-u=
arts
>>> >
>>> > =A0 =A0 =A0 =A0From the runtime callbacks enable hwmod wakeups fo=
r uart which
>>> > will
>>> > =A0 =A0 =A0 =A0internally enable io-pad wakeups for uarts if they=
 have rx-pad
>>> > pins
>>> > =A0 =A0 =A0 =A0set as wakeup capabale.
>>> >
>>> > =A0 =A0 =A0 =A0Use the io-ring wakeup mechanism after uart clock =
gating and
>>> > leave
>>> > =A0 =A0 =A0 =A0the PM_WKST set for uart to default reset values c=
leanup the
>>> > =A0 =A0 =A0 =A0code in serial.c which was handling PM_WKST reg.
>>> > =A0 =A0 =A0 =A0Irq_chaing(PRM_DRIVER) is used to wakeup uart afte=
r uart clocks
>>> > are
>>> > =A0 =A0gated
>>> > =A0 =A0 =A0 =A0using pad wakeup mechanism.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 94734749af794c080f6af6ac3ce8c1c13ee2dbbd
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Nov 7 19:00:33 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Move errata handling from seria=
l.c to
>>> > =A0 =A0omap-serial
>>> >
>>> > =A0 =A0 =A0 =A0Move the errata handling mechanism from serial.c t=
o omap-serial
>>> > =A0 =A0file
>>> > =A0 =A0 =A0 =A0and utilise the same func in driver file.
>>> >
>>> > =A0 =A0 =A0 =A0Errata i202, i291 are moved to be handled with oma=
p-serial
>>> > =A0 =A0 =A0 =A0Moving the errata macro from serial.c file to driv=
er header file
>>> > =A0 =A0 =A0 =A0as from on errata will be handled in driver file i=
tself.
>>> > =A0 =A0 =A0 =A0Corrected errata id from chapter reference 2.15 to=
 errata id
>>> > i291.
>>> >
>>> > =A0 =A0 =A0 =A0Removed errata and dma_enabled fields from omap_ua=
rt_state
>>> > struct
>>> > =A0 =A0 =A0 =A0as they are no more needed with errata handling do=
ne within
>>> > =A0 =A0omap-serial.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Alan Cox <alan@linux.intel.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit ec3bebc6ec64aac23500e6b8ef5c0aaaeda735cf
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Tue Oct 11 19:11:27 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Get context loss count to conte=
xt restore
>>> >
>>> > =A0 =A0 =A0 =A0Avoid unconditional context restore every time we =
gate uart
>>> > =A0 =A0 =A0 =A0clocks. Check whether context loss happened based =
on which
>>> > =A0 =A0 =A0 =A0we can context restore uart regs from uart_port st=
ructure.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 32212897eeb8c2b2b3c74dbd44d842963084d808
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Nov 7 18:58:55 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Remove uart reset function.
>>> >
>>> > =A0 =A0 =A0 =A0Remove the uart reset function which is configurin=
g the
>>> > =A0 =A0 =A0 =A0TX empty irq which can now be handled within omap-=
serial driver.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit c538d20c7f437e56c5301357c492230d1d6d1b80
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Nov 7 18:57:03 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Ensure all reg values configure=
d are
>>> > available
>>> > =A0 =A0from port structure
>>> >
>>> > =A0 =A0 =A0 =A0Add missing uart regs to uart_port structure which=
 can be used
>>> > in
>>> > =A0 =A0 =A0 =A0context restore. Store dll, dlh, mdr1, scr, efr, l=
cr, mcr reg
>>> > =A0 =A0values
>>> > =A0 =A0 =A0 =A0into uart_port structure while configuring individ=
ual port in
>>> > =A0 =A0termios
>>> > =A0 =A0 =A0 =A0function.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 9f9ac1e84a24670eea1430040e0aef278b4daffa
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Nov 7 18:56:12 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Remove context_save and move co=
ntext restore
>>> > to
>>> > =A0 =A0driver
>>> >
>>> > =A0 =A0 =A0 =A0Remove context save function from serial.c and mov=
e context
>>> > restore
>>> > =A0 =A0 =A0 =A0function to omap-serial. Remove all regs stored in
>>> > omap_uart_state
>>> > =A0 =A0 =A0 =A0for contex_save/restore, reg read write funcs used=
 in
>>> > =A0 =A0context_save/restore,
>>> > =A0 =A0 =A0 =A0io_addresses populated for read/write funcs.
>>> >
>>> > =A0 =A0 =A0 =A0Clock gating mechanism was done in serial.c and ha=
d no info on
>>> > uart
>>> > =A0 =A0state
>>> > =A0 =A0 =A0 =A0thus we needed context save and restore in serial.=
c
>>> > =A0 =A0 =A0 =A0With runtime conversion and clock gating done with=
in uart driver
>>> > =A0 =A0 =A0 =A0context restore can be done from regs value availa=
ble from
>>> > =A0 =A0uart_omap_port
>>> > =A0 =A0 =A0 =A0structure.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit fcdca75728ac376f3de74376c791e1078ee83820
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Feb 28 18:12:23 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Add runtime pm support for omap=
-serial driver
>>> >
>>> > =A0 =A0 =A0 =A0Adapts omap-serial driver to use pm_runtime API's.
>>> > =A0 =A0 =A0 =A0Use runtime runtime API's to handle uart clocks an=
d obtain
>>> > =A0 =A0 =A0 =A0device_usage statics. Set runtime API's usage to i=
rq_safe so
>>> > that
>>> > =A0 =A0 =A0 =A0we can use get_sync from irq context. Auto-suspend=
 for port
>>> > =A0 =A0specific
>>> > =A0 =A0 =A0 =A0activities and put for reg access. Moving suspend/=
resume hooks
>>> > =A0 =A0 =A0 =A0to dev_pm_ops structure and bind with config_suspe=
nd to avoid
>>> > any
>>> > =A0 =A0 =A0 =A0compilation warning if config_suspend is disabled.
>>> >
>>> > =A0 =A0 =A0 =A0By default uart autosuspend delay is set to -1 to =
avoid
>>> > character
>>> > =A0 =A0loss
>>> > =A0 =A0 =A0 =A0if uart's are autoidled and woken up on rx pin.
>>> >
>>> > =A0 =A0 =A0 =A0After boot up UART's can be autoidled by setting a=
utosuspend
>>> > delay
>>> > =A0 =A0from sysfs.
>>> >
>>> > =A0 =A0 =A0 =A0echo 3000 >
>>> > =A0 =A0/sys/devices/platform/omap/omap_uart.X/power/autosuspend_d=
elay_ms
>>> > =A0 =A0 =A0 =A0X=3D0,1,2,3 for UART1/2/3/4. Number of uarts avail=
able may vary
>>> > =A0 =A0across omap_soc.
>>> >
>>> > =A0 =A0 =A0 =A0Also if uart is not wakeup capable we can prevent =
runtime
>>> > =A0 =A0autosuspend by
>>> > =A0 =A0 =A0 =A0forbiding runtime.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Alan Cox <alan@linux.intel.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit edd70ad757e9b336116433e6e62de79ae1dfef54
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Tue Oct 11 14:55:41 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Remove mapbase/membase fields f=
rom pdata.
>>> >
>>> > =A0 =A0 =A0 =A0The mapbase (start_address), membase(io_remap cook=
ie) part of
>>> > =A0 =A0 =A0 =A0pdata struct omap_uart_port_info are removed as th=
is should be
>>> > =A0 =A0 =A0 =A0derived within driver.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 7496ba309f2adbce74d917fbb8bd3da26222d49f
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Mon Nov 7 18:55:05 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Add default mux for all uarts.
>>> >
>>> > =A0 =A0 =A0 =A0Padconf wakeup is used to wakeup uart after uart f=
clks/iclks are
>>> > =A0 =A0gated.
>>> > =A0 =A0 =A0 =A0Rx-Pad wakeup was done by writing to rx-pad offset=
 value
>>> > populated
>>> > =A0 =A0in
>>> > =A0 =A0 =A0 =A0serial.c idle_init. Remove the direct reading and =
writing into
>>> > rx
>>> > =A0 =A0pad.
>>> > =A0 =A0 =A0 =A0Remove the padconf field part of omap_uart_state s=
truct and pad
>>> > =A0 =A0offsets
>>> > =A0 =A0 =A0 =A0populated.
>>> >
>>> > =A0 =A0 =A0 =A0Now with mux framework support we can use mux_util=
ities
>>> > =A0 =A0 =A0 =A0along with hmwod framework to handle io-pad config=
uration and
>>> > =A0 =A0enable rx-pad
>>> > =A0 =A0 =A0 =A0wake-up mechanism.
>>> >
>>> > =A0 =A0 =A0 =A0To avoid breaking any board support add default mu=
x data for all
>>> > =A0 =A0uart's
>>> > =A0 =A0 =A0 =A0if mux info is not passed from board file.
>>> > =A0 =A0 =A0 =A0With the default pads populated in serial.c wakeup=
 capability
>>> > for
>>> > =A0 =A0 =A0 =A0rx pads is set, this can be used to enable uart_rx=
 io-pad wakeup
>>> > =A0 =A0from
>>> > =A0 =A0 =A0 =A0hwmod framework. The pad values in 3430sdp/4430sdp=
/omap4panda
>>> > board
>>> > =A0 =A0file
>>> > =A0 =A0 =A0 =A0are same as the default pad values populated in se=
rial.c. Remove
>>> > =A0 =A0pad values
>>> > =A0 =A0 =A0 =A0from 3430sdp/4430sdp/omap4panda board file and use=
 the default
>>> > pads
>>> > =A0 =A0 =A0 =A0from serial.c file.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 273558b3a0399e368d99da5b3daf1c0e11b93e06
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Tue Sep 13 14:01:01 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: Cleanup part of clock gating me=
chanism for
>>> > uart
>>> >
>>> > =A0 =A0 =A0 =A0Currently we use a shared irq handler to identify =
uart activity
>>> > and
>>> > =A0 =A0then
>>> > =A0 =A0 =A0 =A0trigger a timer. By default the timeout value is z=
ero and can be
>>> > =A0 =A0set or
>>> > =A0 =A0 =A0 =A0modified from sysfs. If there was no uart activity=
 for the
>>> > period
>>> > =A0 =A0set
>>> > =A0 =A0 =A0 =A0through sysfs, the timer will expire and call time=
r handler this
>>> > =A0 =A0will
>>> > =A0 =A0 =A0 =A0set a flag can_sleep using which decision to gate =
uart clocks
>>> > can
>>> > =A0 =A0be taken.
>>> >
>>> > =A0 =A0 =A0 =A0Since the clock gating mechanism is outside the ua=
rt driver, we
>>> > =A0 =A0currently
>>> > =A0 =A0 =A0 =A0use this mechanism. In preparation to runtime impl=
ementation for
>>> > =A0 =A0omap-serial
>>> > =A0 =A0 =A0 =A0driver we can cleanup this mechanism and use runti=
me API's to
>>> > gate
>>> > =A0 =A0uart clocks.
>>> >
>>> > =A0 =A0 =A0 =A0Removes the following:
>>> > =A0 =A0 =A0 =A0* timer related info from local uart_state struct
>>> > =A0 =A0 =A0 =A0* the code used to set timeout value from sysfs.
>>> > =A0 =A0 =A0 =A0* irqflags used to set shared irq handler.
>>> > =A0 =A0 =A0 =A0* un-used function omap_uart_check_wakeup.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@suse.de> (for=
 drivers/tty
>>> > =A0 =A0changes)
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 8a60585159067f110075ef8ffda13abd94826daf
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Tue Sep 13 13:32:32 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: cleanup 8250 console driver sup=
port
>>> >
>>> > =A0 =A0 =A0 =A0We had been using traditional 8250 driver as uart =
console driver
>>> > =A0 =A0 =A0 =A0prior to omap-serial driver. Since we have omap-se=
rial driver
>>> > =A0 =A0 =A0 =A0in mainline kernel for some time now it has been u=
sed as default
>>> > =A0 =A0 =A0 =A0uart console driver on omap2+ platforms. Remove 82=
50 support for
>>> > =A0 =A0 =A0 =A0omap-uarts.
>>> >
>>> > =A0 =A0 =A0 =A0Serial_in and serial_out override for 8250 serial =
driver is also
>>> > =A0 =A0 =A0 =A0removed. Empty fifo read fix is already taken care=
 with
>>> > omap-serial
>>> > =A0 =A0 =A0 =A0driver with data ready bit check from LSR reg befo=
re reading RX
>>> > =A0 =A0fifo.
>>> > =A0 =A0 =A0 =A0Also waiting for THRE(transmit hold reg empty) is =
done with
>>> > =A0 =A0wait_for_xmitr
>>> > =A0 =A0 =A0 =A0in omap-serial driver.
>>> >
>>> > =A0 =A0 =A0 =A0Serial_in/out overrides are not neceesary for omap=
-serial driver
>>> > =A0 =A0 =A0 =A0and things that are taken with omap-serial driver =
are removed
>>> > here.
>>> >
>>> > =A0 =A0 =A0 =A0Remove headers that were necessary to support 8250=
 support
>>> > =A0 =A0 =A0 =A0and remove all config bindings done to keep 8250 b=
ackward
>>> > =A0 =A0compatibility
>>> > =A0 =A0 =A0 =A0while adding omap-serial driver. Remove omap_uart_=
reset needed
>>> > for
>>> > =A0 =A0 =A0 =A08250 autoconf.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> > =A0 =A0commit 8384c9749f8c31c6e1e64a63c8d50af7863ce657
>>> > =A0 =A0Author: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0Date: =A0 Wed Nov 9 17:22:30 2011 +0530
>>> > =A0 =A0 =A0 =A0ARM: OMAP2+: UART: cleanup + remove uart pm specif=
ic API
>>> >
>>> > =A0 =A0 =A0 =A0In preparation to UART runtime conversion remove u=
art specific
>>> > =A0 =A0calls
>>> > =A0 =A0 =A0 =A0from pm24xx/34xx files and their definition from s=
erial.c
>>> > =A0 =A0 =A0 =A0These func calls will no more be used with upcomin=
g uart runtime
>>> > =A0 =A0design.
>>> >
>>> > =A0 =A0 =A0 =A01.) omap_uart_prepare_suspend :- can be taken care=
 with driver
>>> > =A0 =A0suspend hooks.
>>> > =A0 =A0 =A0 =A02.) omap_uart_enable_irqs :- Used to enable/disabl=
e uart irq's
>>> > in
>>> > =A0 =A0suspend
>>> > =A0 =A0 =A0 =A0 =A0 =A0path from PM code, this is removed as same=
 is handled by
>>> > =A0 =A0 =A0 =A0 =A0 =A0uart_suspend_port/uart_resume_port in omap=
-serial driver
>>> > which
>>> > =A0 =A0will
>>> > =A0 =A0 =A0 =A0 =A0 =A0do an port_shutdown on suspend freeing irq=
 and port_startup
>>> > on
>>> > =A0 =A0resume
>>> > =A0 =A0 =A0 =A0 =A0 =A0enabling back irq.
>>> > =A0 =A0 =A0 =A03.) Remove prepare_idle/resume_idle calls used to =
gate uart
>>> > clocks.
>>> > =A0 =A0 =A0 =A0 =A0 =A0UART clocks can be gated within driver usi=
ng runtime funcs
>>> > =A0 =A0 =A0 =A0 =A0 =A0and be woken up using irq_chaining from om=
ap_prm driver.
>>> > =A0 =A0 =A0 =A04.) Remove console_locking from idle path as clock=
 gating is
>>> > done
>>> > =A0 =A0withing
>>> > =A0 =A0 =A0 =A0 =A0 =A0driver itself with runtime API. Remove is_=
suspending check
>>> > used
>>> > =A0 =A0to acquire
>>> > =A0 =A0 =A0 =A0 =A0 =A0console_lock.
>>> >
>>> > =A0 =A0 =A0 =A0Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>> > =A0 =A0 =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> >
>>> > =A0--------------------------------------------------------------=
---------
>>> > =A0 =A0----------------------------------------------------------=
--------
>>> >
>>> > =A0 =A0regards
>>> > =A0 =A0keshava
>>> >
>>> > =A0 =A0On Wed, Jun 6, 2012 at 5:21 PM, Munegowda, Keshava
>>> > =A0 =A0<keshava_mgowda@ti.com> wrote:
>>> >
>>> > =A0 =A0 =A0hi Kevin
>>> > =A0 =A0 =A0 I have started this; I see that mainline is not booti=
ng in 3430
>>> > sdp
>>> > =A0 =A0 =A0i will fix this first.
>>> > =A0 =A0 =A0regards
>>> > =A0 =A0 =A0keshava
>>> >
>>> > =A0 =A0On Tue, Jun 5, 2012 at 11:20 PM, Kevin Hilman <khilman@ti.=
com>
>>> > wrote:
>>> >
>>> > =A0 =A0 =A0Keshava, Felipe,
>>> > =A0 =A0 =A0ping. =A0This problem is still preventing CORE retenti=
on in
>>> > mainline.
>>> >
>>> > =A0 =A0On 05/24/2012 03:13 PM, Kevin Hilman wrote:
>>> >
>>> > =A0 =A0Kevin Hilman<khilman@ti.com> =A0writes:
>>> >
>>> > =A0 =A0 =A0"Munegowda, Keshava"<keshava_mgowda@ti.com> =A0writes:
>>> >
>>> > =A0 =A0 =A0On Thu, May 24, 2012 at 5:55 AM, Kevin Hilman<khilman@=
ti.com>
>>> > =A0 =A0 =A0wrote:
>>> >
>>> > =A0 =A0 =A0On 05/23/2012 05:01 PM, Kevin Hilman wrote:
>>> >
>>> > =A0 =A0 =A0Hi Keshava,
>>> > =A0 =A0 =A0Using current l-o master, I noticed that CORE was not =
hitting
>>> > =A0 =A0 =A0retention
>>> > =A0 =A0 =A0in idle on my 3530/Overo. =A0CORE hits retention on su=
spend just
>>> > fine.
>>> > =A0 =A0 =A0Debugging this, I found that usbtll_fck was still enab=
led during
>>> > =A0 =A0 =A0idle,
>>> > =A0 =A0 =A0thus preventing CORE from hitting retention.
>>> > =A0 =A0 =A0To test, I disabled USB host (CONFIG_MFD_OMAP_USB_HOST=
=3Dn in
>>> > .config)
>>> > =A0 =A0 =A0and
>>> > =A0 =A0 =A0was then started seeing CORE hit retention in idle aga=
in.
>>> > =A0 =A0 =A0I have nothing plugged into the USB host port on this =
board, so I
>>> > =A0 =A0 =A0would've expected that runtime PM would've kicked in a=
nd shutdown
>>> > =A0 =A0 =A0this
>>> > =A0 =A0 =A0clock.
>>> > =A0 =A0 =A0Any ideas what's going on here? =A0Is this expected be=
havior?
>>> >
>>> > =A0 =A0 =A0If it helps, attached is a bootlog after enabling debu=
g for
>>> > =A0 =A0 =A0mfd/omap-usb-host.c as well. =A0Notice there's a coupl=
e of
>>> > =A0 =A0 =A0clock-related
>>> > =A0 =A0 =A0warnings from this driver as well. =A0Not sure if they=
're relevant:
>>> > =A0 =A0 =A0usbhs_omap: alias fck already exists
>>> > =A0 =A0 =A0usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed=
 error:-22
>>> >
>>> > =A0 =A0 =A0these clocks were specific to omap4 and it should not =
cause any
>>> > =A0 =A0 =A0problem to omap3 boards.
>>> >
>>> > =A0 =A0 =A0OK, they seem unrelated to this CORE retention problem=
, but the
>>> > =A0 =A0 =A0warnings
>>> > =A0 =A0 =A0should still be understood and fixed.
>>> >
>>> > =A0 =A0 =A0I will try to reproduce this on 3430 sdp to explore fu=
rther.
>>> >
>>> > =A0 =A0 =A0Thanks for looking. =A0Note that I only saw this probl=
em on my 3530
>>> > =A0 =A0 =A0platforms (Overo, OMAP3EVM.) =A0My 3430/n900 doesn't s=
upport USBHS
>>> > =A0 =A0 =A0host
>>> > =A0 =A0 =A0AFAICT, so didn't test there.
>>> >
>>> > =A0 =A0After realizing that the same IP should exist on 3430/n900=
, I copied
>>> > =A0 =A0some board file support for USBHS host from overo into the=
 n900
>>> > board
>>> > =A0 =A0file in order to test on 3430/n900.
>>> > =A0 =A0Problem exists on n900 too.
>>> > =A0 =A0Kevin


Hi Kevin

Since 3430 sdp is very unstable , I have switched to 3630 beagle XM.

Also am observing that
core retention is not working even without usb support.

I have started using a branch "remotes/origin/for_3.5/pm-misc" in your =
tree
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

but, in this  branch also the core retention is not working even
without usb support.

Is there any working branch you have to continue working on this proble=
m.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
