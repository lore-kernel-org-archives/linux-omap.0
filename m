From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Integration branch base switchover to Tony's omap-for-linus branch
Date: Tue, 8 Mar 2011 09:04:48 +0100
Message-ID: <4D75E320.60804@ti.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com> <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com> <4D6F89FB.7080201@ti.com> <4D70F25C.4040206@ti.com> <alpine.DEB.2.00.1103071622540.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39220 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab1CHIL5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 03:11:57 -0500
In-Reply-To: <alpine.DEB.2.00.1103071622540.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Salut Paul,

On 3/8/2011 12:25 AM, Paul Walmsley wrote:
> Hi Rajendra, Santosh,
>
> On Fri, 4 Mar 2011, Rajendra Nayak wrote:
>
>> On Thursday 03 March 2011 06:00 PM, Rajendra Nayak wrote:
>>
>>> Also some more testing showed up a lockup in suspend on OMAP4 which=
 I
>>> could narrow down to a similar case with GPT1. Either keeping the
>>> staticdep between MPU and L4_WKUP _or_ forcing GPT1 to use software
>>> idle control seems to help.
>>
>> This however is still not rootcaused and is not the same as the issu=
e
>> seen with i2c as the WE for GPT1 is already programmed for enabling
>> wakeup.
>>
>> The one way to fix this for now is to put GPT1 block in software
>> controlled idle as was done by your test patch for i2c.
>
> OK, thanks for the update.
>
> Beno=EEt, do you have any more OMAP4 hwmod patches for 2.6.39?  If no=
t, want
> to send an Acked-by:, and either Tony or I will take this one?

I already slightly modified this one and added it with the revert patch=
=20
last Friday. It was in the reply to this email.

I was hoping for a definitive fix instead of a temporary one :-(

You can find them in the following place:
git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data_fixes

Regards
Benoit

---
 From aa22c44486c12c388eb96e9fe9b1476267856006 Mon Sep 17 00:00:00 2001
=46rom: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 4 Mar 2011 16:01:43 +0100
Subject: [PATCH 1/2] Revert "OMAP4: hwmod data: Prevent timer1 to be
reset and idle during init"

The following commit: 38698be:
OMAP2+: clockevent: set up GPTIMER clockevent hwmod right before timer =
init

=46ixed properly the issue with early init for the timer1

So reverts commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6 that is now
generated a warning at boot time.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
   1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7dbcdf7..7b72316 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,7 +4005,6 @@ static struct omap_hwmod_ocp_if
*omap44xx_timer1_slaves[] =3D {
   static struct omap_hwmod omap44xx_timer1_hwmod =3D {
   	.name		=3D "timer1",
   	.class		=3D &omap44xx_timer_1ms_hwmod_class,
-	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
   	.mpu_irqs	=3D omap44xx_timer1_irqs,
   	.mpu_irqs_cnt	=3D ARRAY_SIZE(omap44xx_timer1_irqs),
   	.main_clk	=3D "timer1_fck",
--
1.7.0.4


---
 From cdaaad0d1ce032129102b6ebc56e372d6f345861 Mon Sep 17 00:00:00 2001
=46rom: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 4 Mar 2011 19:33:45 +0530
Subject: [PATCH 2/2] OMAP4: hwmod data: Temporary disable
hardware-controlled idle for timer1

Some issues seen (which cause lockups in suspend) with timer1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing timer1 in software
controlled idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[b-cousson: Update the changelog and the subject]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
   1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7b72316..cfe957a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,6 +4005,7 @@ static struct omap_hwmod_ocp_if
*omap44xx_timer1_slaves[] =3D {
   static struct omap_hwmod omap44xx_timer1_hwmod =3D {
   	.name		=3D "timer1",
   	.class		=3D &omap44xx_timer_1ms_hwmod_class,
+	.flags		=3D HWMOD_SWSUP_SIDLE,
   	.mpu_irqs	=3D omap44xx_timer1_irqs,
   	.mpu_irqs_cnt	=3D ARRAY_SIZE(omap44xx_timer1_irqs),
   	.main_clk	=3D "timer1_fck",
--
1.7.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
