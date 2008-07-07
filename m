From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Mon, 07 Jul 2008 10:34:11 +0300
Message-ID: <87vdzi2ln0.fsf@trdhcp146196.ntc.nokia.com>
References: <486BDD2A.5070500@googlemail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com>
	<AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
	<486F21F6.7020208@googlemail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25129 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYGGHfV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 03:35:21 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com>
	(ext Gadiyar's message of "Sat, 5 Jul 2008 18:52:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

"ext Gadiyar, Anand" <gadiyar@ti.com> writes:

> Hi All,
>
> <snip>
>
>> > > Tried that and I get the same hang, so I don't think the RTC is =
to  blame.
>> >
>> > Short update just in case anybody has an idea:
>> >
>> > Gadiyar spent some time with git-bisect (thanks!):
>> >
>> > It seems that the bad commit is probably between:
>> > # good: [3ffec4e18484c34838fa341de3848306c29ecd5d] 24XX: PM: Move =
pm.c to pm24xx.c
>> > and sleep.S to sleep24xx.S
>> > and # bad: [458776cfe389ff03bd6c56c47e059df0778cdfca] OMAP3430SDP:
>> > Enable config options CONFIG_OMAP_RESET_CLOCKS and CONFIG_SUSPEND
>> >
>> > This is a 9-patch series by Jouni Hogander related to suspend and
>> > power-management.
>> >
>> > Dirk
>>
>> I'm still working on the git-bisect. I'm currently waiting
>> for ten minutes
>> after boot before marking a commit good or bad. If the hang
>> happens more
>> than ten minutes after boot, I might miss that and mark the
>> commit good - so
>> I will re-check the good commits one more time and confirm.
>>
>> - Anand
>
> As far as I can tell, the beagle hang issue aries after this commit:
>
> 397f49cde4e75cf662a23814097db35f3e6c6b62 is first bad commit
> commit 397f49cde4e75cf662a23814097db35f3e6c6b62
> Author: Jouni Hogander <jouni.hogander@nokia.com>
> Date:   Fri May 16 13:58:25 2008 +0300
>
>     34XX: PM: Initial version of suspend and dynamic retention
>
>     This is initial version of suspend and dynamic retention for
>     34xx. Omap is tried to put to full retention on suspend and pm_id=
le.
>
>     Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>     Signed-off-by: Tony Lindgren <tony@atomide.com>
>
>
> Could someone please test and confirm if the previous commit works wi=
thout a hang?
> I waited for around 20 minutes and did not observe a hang.
>
> These were the last two good commits I got from git-bisect.
> # good: [1c66e10c850950a84da68cafb07022eab5e7eec0] 34XX: Suspend: Tak=
e suspend sram code from ti cdp kernel
> git-bisect good 1c66e10c850950a84da68cafb07022eab5e7eec0
> # good: [131ce2d1dd5081f97885419678a8b3211c7c2dee] 34XX: Add miscella=
neous definitions related to 34xx

Unfortunately I have only sdp board here and I'm not able to reproduce
this with it. Are you using omap3_beagle_defconfig without modification=
s there?

You mentioned prcm interrupts in this thread. Are you normally seeing
them? I'm wondering this because you shouldn't see them with current
l-o tree and default beagle config. Are you enabling sleep_while_idle
(echo 1 > /sys/power/sleep_while_idle)?

You have end up to conclusion that "34XX: PM: Initial version of
suspend and dynamic retention" is causing this? Could you try to apply
this on top of mentioned commit and see if you still can see that
hang:

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 202c269..308835b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -380,11 +380,11 @@ int __init omap3_pm_init(void)
                goto err1;
        }
=20
-       ret =3D pwrdm_for_each(pwrdms_setup);
-       if (ret) {
-               printk(KERN_ERR "Failed to setup powerdomains\n");
-               goto err2;
-       }
+/*     ret =3D pwrdm_for_each(pwrdms_setup); */
+/*     if (ret) { */
+/*             printk(KERN_ERR "Failed to setup powerdomains\n"); */
+/*             goto err2; */
+/*     } */
=20
        mpu_pwrdm =3D pwrdm_lookup("mpu_pwrdm");
        if (mpu_pwrdm =3D=3D NULL) {

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
