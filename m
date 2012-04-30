From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 3/3] ARM: OMAP3: PM: cleanup cam_pwrdm leftovers
Date: Mon, 30 Apr 2012 13:45:01 -0700
Message-ID: <87k40xt0du.fsf@ti.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
	<1335277420-29124-4-git-send-email-khilman@ti.com>
	<CANOLnOPoTx8ypXrJnyXUh8tf1+d8bBXYRk09ZqV2uEe_=oSRyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:37236 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756754Ab2D3UpF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 16:45:05 -0400
Received: by dadz14 with SMTP id z14so16256799dad.17
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 13:45:03 -0700 (PDT)
In-Reply-To: <CANOLnOPoTx8ypXrJnyXUh8tf1+d8bBXYRk09ZqV2uEe_=oSRyQ@mail.gmail.com>
	(Grazvydas Ignotas's message of "Sat, 28 Apr 2012 17:47:45 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Tue, Apr 24, 2012 at 5:23 PM, Kevin Hilman <khilman@ti.com> wrote:
>> commit e7410cf7 (02fdb03e69699f26e1370d0e51593dbc8a4e5265) moved
>> mangement of cam_pwrdm to CPUidle but left some remnants behind,
>> namely the call to clkcm_allo_idle() for the clockdomains in the MPU
>> pwrdm. =C2=A0Remove these since they are not necessary and cause unw=
anted
>> latency in the idle path.
>
> Only noticed this now; what does
> 02fdb03e69699f26e1370d0e51593dbc8a4e5265 refer to? Doesn't seem to be
> resolving to anything here.

Oops, copy/paste problem.  I've updated the changelog locally.  Updated
patch below.

Thanks for pointing it out,

Kevin


=46rom 77d4c33d506938896cb87fb4034e3b65fe5e30f0 Mon Sep 17 00:00:00 200=
1
=46rom: Kevin Hilman <khilman@ti.com>
Date: Mon, 16 Apr 2012 17:53:51 -0700
Subject: [PATCH] ARM: OMAP3: PM: cleanup cam_pwrdm leftovers

commit e7410cf7 (OMAP3: PM: move device-specific special cases from PM
core into CPUidle) moved mangement of cam_pwrdm to CPUidle but left
some remnants behind, namely the call to clkcm_allo_idle() for the
clockdomains in the MPU pwrdm.  Remove these since they are not
necessary and cause unwanted latency in the idle path.

Acked-by: Tero Kristo <Tero Kristo <t-kristo@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 74a7f8c..66ff828 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -70,7 +70,6 @@ void (*omap3_do_wfi_sram)(void);
=20
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
-static struct powerdomain *cam_pwrdm;
=20
 static void omap3_enable_io_chain(void)
 {
@@ -395,8 +394,6 @@ void omap_sram_idle(void)
=20
 	if (mpu_next_state < PWRDM_POWER_ON)
 		pwrdm_post_transition(mpu_pwrdm);
-
-	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
=20
 static void omap3_pm_idle(void)
@@ -759,7 +756,6 @@ static int __init omap3_pm_init(void)
 	neon_pwrdm =3D pwrdm_lookup("neon_pwrdm");
 	per_pwrdm =3D pwrdm_lookup("per_pwrdm");
 	core_pwrdm =3D pwrdm_lookup("core_pwrdm");
-	cam_pwrdm =3D pwrdm_lookup("cam_pwrdm");
=20
 	neon_clkdm =3D clkdm_lookup("neon_clkdm");
 	mpu_clkdm =3D clkdm_lookup("mpu_clkdm");
--=20
1.7.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
