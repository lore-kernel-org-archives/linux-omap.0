From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: OMAP3: enabling CPU idle leads to panic
Date: Fri, 27 Nov 2009 13:02:15 +0300
Message-ID: <48239d390911270202s3f6fcdbchaa7053bace5c36@mail.gmail.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
	 <873a43wzfm.fsf@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
	 <48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com>
	 <87iqcyh5p5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39715 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbZK0KCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 05:02:12 -0500
Received: by ewy19 with SMTP id 19so1240110ewy.21
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 02:02:17 -0800 (PST)
In-Reply-To: <87iqcyh5p5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sorry, I forgot to reply to list with this email.

On Wed, Nov 25, 2009 at 8:31 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Sergey Lapin <slapinid@gmail.com> writes:
>
>> On Tue, Nov 24, 2009 at 11:21 PM, Premi, Sanjeev <premi@ti.com> wrote:
>>> From: Kevin Hilman [khilman@deeprootsystems.com]
>>> Sent: Tuesday, November 24, 2009 11:57 PM
>>> To: Sergey Lapin; Premi, Sanjeev
>>> Cc: linux-omap@vger.kernel.org
>>> Subject: Re: OMAP3: enabling CPU idle leads to panic
>>>
>>> Sergey Lapin <slapinid@gmail.com> writes:
>>>
>>>> I use PM branch merged with linux-omap branch.
>>>
>>> Not sure what this means.  PM branch is already based at linux-omap
>>> master branch.  You'll need to be more specific, ideally with commit
>>> IDs.
>>
>> I do git branch tmp origin/master
>> git checkout -f tmp
>> git merge origin/pm
>
> The pm branch is already based on l-o master, but perhaps not the very
> latest.  Instead of the above can you just do
>
> git branch tmp origin/pm
> git checkout -f tmp
>
>> git merge origin/mybranch
>
> It might if you base your 'mybranch' at the same merge point that the
> pm branch is based at.  You can find the merge point using:
>
> git merge-base origin/master origin/pm

Well, thanks for advice, I changed my merge script accordingly, but
nothing changed. I still get panic.

[   21.591064] Unable to handle kernel NULL pointer dereference at
virtual address 00000020
[   21.599212] pgd = c0004000
[   21.601928] [00000020] *pgd=00000000
[   21.605529] Internal error: Oops: 5 [#1] PREEMPT
[   21.610168] last sysfs file:
[   21.613159] Modules linked in:
[   21.616241] CPU: 0    Not tainted  (2.6.32-rc8-07040-g4594b2e #117)
[   21.622558] PC is at pwrdm_for_each_clkdm+0x34/0x88
[   21.627441] LR is at pwrdm_for_each_clkdm+0x24/0x88
[   21.632354] pc : [<c003b5c0>]    lr : [<c003b5b0>]    psr: 600000d3
[   21.632385] sp : c03f3f68  ip : fa004800  fp : 00000000
[   21.643920] r10: c003e840  r9 : 411fc082  r8 : 00000000
[   21.649169] r7 : a00000d3  r6 : 00000000  r5 : 00000004  r4 : 00000001
[   21.655731] r3 : 00000002  r2 : c03f2000  r1 : 00000001  r0 : 00000000
[   21.662292] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[   21.669830] Control: 10c5387d  Table: 80004019  DAC: 00000017
[   21.675598] Process swapper (pid: 0, stack limit = 0xc03f22e8)
[   21.681457] Stack: (0xc03f3f68 to 0xc03f4000)
[   21.685852] 3f60:                   c042e4bc 00000003 00000003
c042e4bc 800263f4 411fc082
[   21.694091] 3f80: 0000001f c003e790 00000000 c022f3b8 000253d2
00000000 00000005 0ee4d5e4
[   21.702301] 3fa0: c03f8640 c03f8650 c042dadc c03f8640 c0474d4c
c022e01c c03f2000 c042dadc
[   21.710540] 3fc0: c0027e14 c03f5bd0 800263f4 c002f49c c0459fe4
c0008914 c0008478 00000000
[   21.718780] 3fe0: 00000000 c0027e18 00000000 10c53c7d c042dbf0
80008034 00000000 00000000
[   21.727020] [<c003b5c0>] (pwrdm_for_each_clkdm+0x34/0x88) from
[<c003e790>] (omap3_enter_idle+0xc0/0x15c)
[   21.736663] [<c003e790>] (omap3_enter_idle+0xc0/0x15c) from
[<c022e01c>] (cpuidle_idle_call+0xa4/0x180)
[   21.746124] [<c022e01c>] (cpuidle_idle_call+0xa4/0x180) from
[<c002f49c>] (cpu_idle+0x48/0x98)
[   21.754791] [<c002f49c>] (cpu_idle+0x48/0x98) from [<c0008914>]
(start_kernel+0x250/0x2a8)
[   21.763122] [<c0008914>] (start_kernel+0x250/0x2a8) from
[<80008034>] (0x80008034)
[   21.770751] Code: e3a06000 e1a05008 e1a04006 ea000002 (e595101c)
[   21.777008] ---[ end trace 2d4ee201e3556cfe ]---
[   21.781707] Kernel panic - not syncing: Attempted to kill the idle task!

If I add the following patch:

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
b/arch/arm/mach-omap2/cpuidle34xx.c
index 1cfa5a6..6a12e53 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -346,6 +346,7 @@ int __init omap3_idle_init(void)

       mpu_pd = pwrdm_lookup("mpu_pwrdm");
       core_pd = pwrdm_lookup("core_pwrdm");
+       BUG_ON(!core_pd);

       omap_init_power_states();
       cpuidle_register_driver(&omap3_idle_driver);

kernel dies right on BUG_ON.
Also, I patched pwrdm_lookup to print all perdms if returning NULL,
ant there was no core_pwrdm there :(

Is core_pwrdm used only with idle? When I disable cpu idle,
I have no panics.

Update: I continued my investigation.
I added the following patch to kernel:
diff --git a/arch/arm/mach-omap2/powerdomain.c
b/arch/arm/mach-omap2/powerdomain.c
index b6990e3..35a5bd0 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -185,7 +185,15 @@ void pwrdm_init(struct powerdomain **pwrdm_list)

        if (pwrdm_list) {
                for (p = pwrdm_list; *p; p++) {
-                       pwrdm_register(*p);
+#ifdef CONFIG_DEBUG_LL
+                       int i;
+                       extern void printascii(char *);
+                       printascii((*p)->name);
+                       printascii("\n");
+#endif
+                       i = pwrdm_register(*p);
+                       if (i < 0)
+                               printascii("Damn\n");
                        _pwrdm_setup(*p);
                }
        }


And got the following output with CONFIG_DEBUG_LL enabled:
gfx_pwrdm
Damn
wkup_pwrdm
iva2_pwrdm
mpu_pwrdm
neon_pwrdm
core_pwrdm
Damn
core_pwrdm
Damn
cam_pwrdm
dss_pwrdm
per_pwrdm
emu_pwrdm
sgx_pwrdm
Damn
usbhost_pwrdm
Damn
dpll1_pwrdm
dpll2_pwrdm
dpll3_pwrdm
dpll4_pwrdm
dpll5_pwrdm
Damn
<3>clockdomain: cm_clkdm: powerdomain core_pwrdm does not exist
<3>clockdomain: d2d_clkdm: powerdomain core_pwrdm does not exist
<3>clockdomain: core_l3_clkdm: powerdomain core_pwrdm does not exist
<3>clockdomain: core_l4_clkdm: powerdomain core_pwrdm does not exist
<6>Clocking rate (Crystal/Core/MPU): 26.0/166/500 MHz
<6>Reprogramming SDRC clock to 166000000 Hz

So, as I see here, core_pwrdm and some others are failed to register.
Any ideas?

S.


S.
