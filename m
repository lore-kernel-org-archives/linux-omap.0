From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: SMP local timers and their CPUfreq notifiers setup on OMAP3
Date: Fri, 17 Feb 2012 16:10:57 +0530
Message-ID: <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com> <0401fed02a58f7bc48cc274050adbac7@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00248c768f9ea3bfb804b92695e1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52425 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752514Ab2BQKlS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 05:41:18 -0500
Received: by mail-qw0-f42.google.com with SMTP id y23so679283qad.15
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 02:41:17 -0800 (PST)
In-Reply-To: <0401fed02a58f7bc48cc274050adbac7@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

--00248c768f9ea3bfb804b92695e1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2012 at 3:17 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Santosh,
>
> On Fri, 17 Feb 2012 13:18:37 +0530, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>>

[...]

>> =A0arch/arm/kernel/smp_twd.c | =A0 =A04 +++-
>> =A01 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 4285daa..753ae37 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -30,6 +30,7 @@ void __iomem *twd_base;
>>
>> =A0static struct clk *twd_clk;
>> =A0static unsigned long twd_timer_rate;
>> +static bool twd_initialised;
>>
>> =A0static struct clock_event_device __percpu **twd_evt;
>>
>> @@ -129,7 +130,7 @@ static struct notifier_block twd_cpufreq_nb =3D {
>>
>> =A0static int twd_cpufreq_init(void)
>> =A0{
>> - =A0 =A0 if (!IS_ERR(twd_clk))
>> + =A0 =A0 if ((!IS_ERR(twd_clk)) && twd_initialised)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cpufreq_register_notifier(&twd_cpufre=
q_nb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_TRANSITION_NOTIFIER)=
;
>
> Testing twd_evt and *__this_cpu_ptr(twd_evt) should have a similar effect=
,
> and save the additional variable.
>
Indeed.
Updated patch below.

>From 4d351f59e5dabe065d51304455ee01b191cb56d6 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 17 Feb 2012 11:11:28 +0530
Subject: [PATCH] ARM: smp_twd: Don't register CPUFREQ notifiers if
local timers are not initialised.

Current ARM local timer code registers CPUFREQ notifiers even in case
the twd_timer_setup() isn't called. That seems to be wrong and
would eventually lead to kernel crash on the CPU frequency transitions
on the SOCs where the local timer doesn't exist or broken because of
hardware BUG. Fix it by testing twd_evt and *__this_cpu_ptr(twd_evt).

The issue was observed with v3.3-rc3 and building an OMAP2+ kernel
on OMAP3 SOC which doesn't have TWD.

Below is the dump for reference :

 Unable to handle kernel paging request at virtual address 007e900
 pgd =3D cdc20000
 [007e9000] *pgd=3D00000000
 Internal error: Oops: 5 [#1] SMP
 Modules linked in:
 CPU: 0    Not tainted  (3.3.0-rc3-pm+debug+initramfs #9)
 PC is at twd_update_frequency+0x34/0x48
 LR is at twd_update_frequency+0x10/0x48
 pc : [<c001382c>]    lr : [<c0013808>]    psr: 60000093
 sp : ce311dd8  ip : 00000000  fp : 00000000
 r10: 00000000  r9 : 00000001  r8 : ce310000
 r7 : c0440458  r6 : c00137f8  r5 : 00000000  r4 : c0947a74
 r3 : 00000000  r2 : 007e9000  r1 : 00000000  r0 : 00000000
 Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment usr
 Control: 10c5387d  Table: 8dc20019  DAC: 00000015
 Process sh (pid: 599, stack limit =3D 0xce3102f8)
 Stack: (0xce311dd8 to 0xce312000)
 1dc0:                                                       6000c
 1de0: 00000001 00000002 00000000 00000000 00000000 00000000 00000
 1e00: ffffffff c093d8f0 00000000 ce311ebc 00000001 00000001 ce310
 1e20: c001386c c0437c4c c0e95b60 c0e95ba8 00000001 c0e95bf8 ffff4
 1e40: 00000000 00000000 c005ef74 ce310000 c0435cf0 ce311ebc 00000
 1e60: ce352b40 0007a120 c08d5108 c08ba040 c08ba040 c005f030 00000
 1e80: c08bc554 c032fe2c 0007a120 c08d4b64 ce352b40 c08d8618 ffff8
 1ea0: c08ba040 c033364c ce311ecc c0433b50 00000002 ffffffea c0330
 1ec0: 0007a120 0007a120 22222201 00000000 22222222 00000000 ce357
 1ee0: ce3d6000 cdc2aed8 ce352ba0 c0470164 00000002 c032f47c 00034
 1f00: c0331cac ce352b40 00000007 c032f6d0 ce352bbc 0003d090 c0930
 1f20: c093d8bc c03306a4 00000007 ce311f80 00000007 cdc2aec0 ce358
 1f40: ce8d20c0 00000007 b6fe5000 ce311f80 00000007 ce310000 0000c
 1f60: c000de74 ce987400 ce8d20c0 b6fe5000 00000000 00000000 0000c
 1f80: 00000000 00000000 001fbac8 00000000 00000007 001fbac8 00004
 1fa0: c000df04 c000dd60 00000007 001fbac8 00000001 b6fe5000 00000
 1fc0: 00000007 001fbac8 00000007 00000004 b6fe5000 00000000 00202
 1fe0: 00000000 beb565f8 00101ffc 00008e8c 60000010 00000001 00000
 [<c001382c>] (twd_update_frequency+0x34/0x48) from [<c008ac4c>] )
 [<c008ac4c>] (smp_call_function_single+0x17c/0x1c8) from [<c0013)
 [<c0013890>] (twd_cpufreq_transition+0x24/0x30) from [<c0437c4c>)
 [<c0437c4c>] (notifier_call_chain+0x44/0x84) from [<c005efe4>] ()
 [<c005efe4>] (__srcu_notifier_call_chain+0x70/0xa4) from [<c005f)
 [<c005f030>] (srcu_notifier_call_chain+0x18/0x20) from [<c032fe2)
 [<c032fe2c>] (cpufreq_notify_transition+0xc8/0x1b0) from [<c0333)
 [<c033364c>] (omap_target+0x1b4/0x28c) from [<c032f47c>] (__cpuf)
 [<c032f47c>] (__cpufreq_driver_target+0x50/0x64) from [<c0331d24)
 [<c0331d24>] (cpufreq_set+0x78/0x98) from [<c032f6d0>] (store_sc)
 [<c032f6d0>] (store_scaling_setspeed+0x5c/0x74) from [<c03306a4>)
 [<c03306a4>] (store+0x58/0x74) from [<c014d868>] (sysfs_write_fi)
 [<c014d868>] (sysfs_write_file+0x80/0xb4) from [<c00f2c2c>] (vfs)
 [<c00f2c2c>] (vfs_write+0xa8/0x138) from [<c00f2e9c>] (sys_write)
 [<c00f2e9c>] (sys_write+0x40/0x6c) from [<c000dd60>] (ret_fast_s)
 Code: e594300c e792210c e1a01000 e5840004 (e7930002)
 ---[ end trace 5da3b5167c1ecdda ]---

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/smp_twd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 4285daa..265a18a 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb =3D {

 static int twd_cpufreq_init(void)
 {
-	if (!IS_ERR(twd_clk))
+	if ((!twd_evt) && (!__this_cpu_ptr(twd_evt)) && (!IS_ERR(twd_clk)))
 		return cpufreq_register_notifier(&twd_cpufreq_nb,
 			CPUFREQ_TRANSITION_NOTIFIER);

--=20
1.7.4.1

--00248c768f9ea3bfb804b92695e1
Content-Type: application/octet-stream;
	name="0001-ARM-smp_twd-Don-t-register-CPUFREQ-notifiers-if-loca.patch"
Content-Disposition: attachment;
	filename="0001-ARM-smp_twd-Don-t-register-CPUFREQ-notifiers-if-loca.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gyr38csz0

RnJvbSA0ZDM1MWY1OWU1ZGFiZTA2NWQ1MTMwNDQ1NWVlMDFiMTkxY2I1NmQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBGcmksIDE3IEZlYiAyMDEyIDExOjExOjI4ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gQVJNOiBzbXBfdHdkOiBEb24ndCByZWdpc3RlciBDUFVGUkVRIG5vdGlmaWVycyBpZiBs
b2NhbCB0aW1lcnMgYXJlIG5vdCBpbml0aWFsaXNlZC4KCkN1cnJlbnQgQVJNIGxvY2FsIHRpbWVy
IGNvZGUgcmVnaXN0ZXJzIENQVUZSRVEgbm90aWZpZXJzIGV2ZW4gaW4gY2FzZQp0aGUgdHdkX3Rp
bWVyX3NldHVwKCkgaXNuJ3QgY2FsbGVkLiBUaGF0IHNlZW1zIHRvIGJlIHdyb25nIGFuZAp3b3Vs
ZCBldmVudHVhbGx5IGxlYWQgdG8ga2VybmVsIGNyYXNoIG9uIHRoZSBDUFUgZnJlcXVlbmN5IHRy
YW5zaXRpb25zCm9uIHRoZSBTT0NzIHdoZXJlIHRoZSBsb2NhbCB0aW1lciBkb2Vzbid0IGV4aXN0
IG9yIGJyb2tlbiBiZWNhdXNlIG9mCmhhcmR3YXJlIEJVRy4gRml4IGl0IGJ5IHRlc3RpbmcgdHdk
X2V2dCBhbmQgKl9fdGhpc19jcHVfcHRyKHR3ZF9ldnQpLgoKVGhlIGlzc3VlIHdhcyBvYnNlcnZl
ZCB3aXRoIHYzLjMtcmMzIGFuZCBidWlsZGluZyBhbiBPTUFQMisga2VybmVsCm9uIE9NQVAzIFNP
QyB3aGljaCBkb2Vzbid0IGhhdmUgVFdELgoKQmVsb3cgaXMgdGhlIGR1bXAgZm9yIHJlZmVyZW5j
ZSA6CgogVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBh
ZGRyZXNzIDAwN2U5MDAKIHBnZCA9IGNkYzIwMDAwCiBbMDA3ZTkwMDBdICpwZ2Q9MDAwMDAwMDAK
IEludGVybmFsIGVycm9yOiBPb3BzOiA1IFsjMV0gU01QCiBNb2R1bGVzIGxpbmtlZCBpbjoKIENQ
VTogMCAgICBOb3QgdGFpbnRlZCAgKDMuMy4wLXJjMy1wbStkZWJ1Zytpbml0cmFtZnMgIzkpCiBQ
QyBpcyBhdCB0d2RfdXBkYXRlX2ZyZXF1ZW5jeSsweDM0LzB4NDgKIExSIGlzIGF0IHR3ZF91cGRh
dGVfZnJlcXVlbmN5KzB4MTAvMHg0OAogcGMgOiBbPGMwMDEzODJjPl0gICAgbHIgOiBbPGMwMDEz
ODA4Pl0gICAgcHNyOiA2MDAwMDA5Mwogc3AgOiBjZTMxMWRkOCAgaXAgOiAwMDAwMDAwMCAgZnAg
OiAwMDAwMDAwMAogcjEwOiAwMDAwMDAwMCAgcjkgOiAwMDAwMDAwMSAgcjggOiBjZTMxMDAwMAog
cjcgOiBjMDQ0MDQ1OCAgcjYgOiBjMDAxMzdmOCAgcjUgOiAwMDAwMDAwMCAgcjQgOiBjMDk0N2E3
NAogcjMgOiAwMDAwMDAwMCAgcjIgOiAwMDdlOTAwMCAgcjEgOiAwMDAwMDAwMCAgcjAgOiAwMDAw
MDAwMAogRmxhZ3M6IG5aQ3YgIElSUXMgb2ZmICBGSVFzIG9uICBNb2RlIFNWQ18zMiAgSVNBIEFS
TSAgU2VnbWVudCB1c3IKIENvbnRyb2w6IDEwYzUzODdkICBUYWJsZTogOGRjMjAwMTkgIERBQzog
MDAwMDAwMTUKIFByb2Nlc3Mgc2ggKHBpZDogNTk5LCBzdGFjayBsaW1pdCA9IDB4Y2UzMTAyZjgp
CiBTdGFjazogKDB4Y2UzMTFkZDggdG8gMHhjZTMxMjAwMCkKIDFkYzA6ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDYwMDBjCiAxZGUwOiAwMDAw
MDAwMSAwMDAwMDAwMiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMAog
MWUwMDogZmZmZmZmZmYgYzA5M2Q4ZjAgMDAwMDAwMDAgY2UzMTFlYmMgMDAwMDAwMDEgMDAwMDAw
MDEgY2UzMTAKIDFlMjA6IGMwMDEzODZjIGMwNDM3YzRjIGMwZTk1YjYwIGMwZTk1YmE4IDAwMDAw
MDAxIGMwZTk1YmY4IGZmZmY0CiAxZTQwOiAwMDAwMDAwMCAwMDAwMDAwMCBjMDA1ZWY3NCBjZTMx
MDAwMCBjMDQzNWNmMCBjZTMxMWViYyAwMDAwMAogMWU2MDogY2UzNTJiNDAgMDAwN2ExMjAgYzA4
ZDUxMDggYzA4YmEwNDAgYzA4YmEwNDAgYzAwNWYwMzAgMDAwMDAKIDFlODA6IGMwOGJjNTU0IGMw
MzJmZTJjIDAwMDdhMTIwIGMwOGQ0YjY0IGNlMzUyYjQwIGMwOGQ4NjE4IGZmZmY4CiAxZWEwOiBj
MDhiYTA0MCBjMDMzMzY0YyBjZTMxMWVjYyBjMDQzM2I1MCAwMDAwMDAwMiBmZmZmZmZlYSBjMDMz
MAogMWVjMDogMDAwN2ExMjAgMDAwN2ExMjAgMjIyMjIyMDEgMDAwMDAwMDAgMjIyMjIyMjIgMDAw
MDAwMDAgY2UzNTcKIDFlZTA6IGNlM2Q2MDAwIGNkYzJhZWQ4IGNlMzUyYmEwIGMwNDcwMTY0IDAw
MDAwMDAyIGMwMzJmNDdjIDAwMDM0CiAxZjAwOiBjMDMzMWNhYyBjZTM1MmI0MCAwMDAwMDAwNyBj
MDMyZjZkMCBjZTM1MmJiYyAwMDAzZDA5MCBjMDkzMAogMWYyMDogYzA5M2Q4YmMgYzAzMzA2YTQg
MDAwMDAwMDcgY2UzMTFmODAgMDAwMDAwMDcgY2RjMmFlYzAgY2UzNTgKIDFmNDA6IGNlOGQyMGMw
IDAwMDAwMDA3IGI2ZmU1MDAwIGNlMzExZjgwIDAwMDAwMDA3IGNlMzEwMDAwIDAwMDBjCiAxZjYw
OiBjMDAwZGU3NCBjZTk4NzQwMCBjZThkMjBjMCBiNmZlNTAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwYwogMWY4MDogMDAwMDAwMDAgMDAwMDAwMDAgMDAxZmJhYzggMDAwMDAwMDAgMDAwMDAwMDcg
MDAxZmJhYzggMDAwMDQKIDFmYTA6IGMwMDBkZjA0IGMwMDBkZDYwIDAwMDAwMDA3IDAwMWZiYWM4
IDAwMDAwMDAxIGI2ZmU1MDAwIDAwMDAwCiAxZmMwOiAwMDAwMDAwNyAwMDFmYmFjOCAwMDAwMDAw
NyAwMDAwMDAwNCBiNmZlNTAwMCAwMDAwMDAwMCAwMDIwMgogMWZlMDogMDAwMDAwMDAgYmViNTY1
ZjggMDAxMDFmZmMgMDAwMDhlOGMgNjAwMDAwMTAgMDAwMDAwMDEgMDAwMDAKIFs8YzAwMTM4MmM+
XSAodHdkX3VwZGF0ZV9mcmVxdWVuY3krMHgzNC8weDQ4KSBmcm9tIFs8YzAwOGFjNGM+XSApCiBb
PGMwMDhhYzRjPl0gKHNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZSsweDE3Yy8weDFjOCkgZnJvbSBb
PGMwMDEzKQogWzxjMDAxMzg5MD5dICh0d2RfY3B1ZnJlcV90cmFuc2l0aW9uKzB4MjQvMHgzMCkg
ZnJvbSBbPGMwNDM3YzRjPikKIFs8YzA0MzdjNGM+XSAobm90aWZpZXJfY2FsbF9jaGFpbisweDQ0
LzB4ODQpIGZyb20gWzxjMDA1ZWZlND5dICgpCiBbPGMwMDVlZmU0Pl0gKF9fc3JjdV9ub3RpZmll
cl9jYWxsX2NoYWluKzB4NzAvMHhhNCkgZnJvbSBbPGMwMDVmKQogWzxjMDA1ZjAzMD5dIChzcmN1
X25vdGlmaWVyX2NhbGxfY2hhaW4rMHgxOC8weDIwKSBmcm9tIFs8YzAzMmZlMikKIFs8YzAzMmZl
MmM+XSAoY3B1ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbisweGM4LzB4MWIwKSBmcm9tIFs8YzAzMzMp
CiBbPGMwMzMzNjRjPl0gKG9tYXBfdGFyZ2V0KzB4MWI0LzB4MjhjKSBmcm9tIFs8YzAzMmY0N2M+
XSAoX19jcHVmKQogWzxjMDMyZjQ3Yz5dIChfX2NwdWZyZXFfZHJpdmVyX3RhcmdldCsweDUwLzB4
NjQpIGZyb20gWzxjMDMzMWQyNCkKIFs8YzAzMzFkMjQ+XSAoY3B1ZnJlcV9zZXQrMHg3OC8weDk4
KSBmcm9tIFs8YzAzMmY2ZDA+XSAoc3RvcmVfc2MpCiBbPGMwMzJmNmQwPl0gKHN0b3JlX3NjYWxp
bmdfc2V0c3BlZWQrMHg1Yy8weDc0KSBmcm9tIFs8YzAzMzA2YTQ+KQogWzxjMDMzMDZhND5dIChz
dG9yZSsweDU4LzB4NzQpIGZyb20gWzxjMDE0ZDg2OD5dIChzeXNmc193cml0ZV9maSkKIFs8YzAx
NGQ4Njg+XSAoc3lzZnNfd3JpdGVfZmlsZSsweDgwLzB4YjQpIGZyb20gWzxjMDBmMmMyYz5dICh2
ZnMpCiBbPGMwMGYyYzJjPl0gKHZmc193cml0ZSsweGE4LzB4MTM4KSBmcm9tIFs8YzAwZjJlOWM+
XSAoc3lzX3dyaXRlKQogWzxjMDBmMmU5Yz5dIChzeXNfd3JpdGUrMHg0MC8weDZjKSBmcm9tIFs8
YzAwMGRkNjA+XSAocmV0X2Zhc3RfcykKIENvZGU6IGU1OTQzMDBjIGU3OTIyMTBjIGUxYTAxMDAw
IGU1ODQwMDA0IChlNzkzMDAwMikKIC0tLVsgZW5kIHRyYWNlIDVkYTNiNTE2N2MxZWNkZGEgXS0t
LQoKUmVwb3J0ZWQtYnk6IEtldmluIEhpbG1hbiA8a2hpbG1hbkB0aS5jb20+ClNpZ25lZC1vZmYt
Ynk6IFNhbnRvc2ggU2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWthckB0aS5jb20+Ci0tLQogYXJj
aC9hcm0va2VybmVsL3NtcF90d2QuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9z
bXBfdHdkLmMgYi9hcmNoL2FybS9rZXJuZWwvc21wX3R3ZC5jCmluZGV4IDQyODVkYWEuLjI2NWEx
OGEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2tlcm5lbC9zbXBfdHdkLmMKKysrIGIvYXJjaC9hcm0v
a2VybmVsL3NtcF90d2QuYwpAQCAtMTI5LDcgKzEyOSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sgdHdkX2NwdWZyZXFfbmIgPSB7CiAKIHN0YXRpYyBpbnQgdHdkX2NwdWZyZXFfaW5p
dCh2b2lkKQogewotCWlmICghSVNfRVJSKHR3ZF9jbGspKQorCWlmICgoIXR3ZF9ldnQpICYmICgh
X190aGlzX2NwdV9wdHIodHdkX2V2dCkpICYmICghSVNfRVJSKHR3ZF9jbGspKSkKIAkJcmV0dXJu
IGNwdWZyZXFfcmVnaXN0ZXJfbm90aWZpZXIoJnR3ZF9jcHVmcmVxX25iLAogCQkJQ1BVRlJFUV9U
UkFOU0lUSU9OX05PVElGSUVSKTsKIAotLSAKMS43LjQuMQoK
--00248c768f9ea3bfb804b92695e1--
