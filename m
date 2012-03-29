From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap2+: pm: fix compilation break.
Date: Thu, 29 Mar 2012 09:55:37 -0700
Message-ID: <87aa2zmjna.fsf@ti.com>
References: <1333015762-476-1-git-send-email-govindraj.raja@ti.com>
	<20120329151128.GT9859@atomide.com>
	<20120329163309.GW9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:44602 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758436Ab2C2Qzl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 12:55:41 -0400
Received: by mail-yx0-f170.google.com with SMTP id l5so1860487yen.29
        for <linux-omap@vger.kernel.org>; Thu, 29 Mar 2012 09:55:40 -0700 (PDT)
In-Reply-To: <20120329163309.GW9859@atomide.com> (Tony Lindgren's message of
	"Thu, 29 Mar 2012 09:33:10 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [120329 08:14]:
>> * Govindraj.R <govindraj.raja@ti.com> [120329 03:12]:
>> > From: "Govindraj.R" <govindraj.raja@ti.com>
>> >=20
>> > Fix the compilation break observed on latest mainline.
>> >=20
>> > Fixes below compilation break:
>> >=20
>> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
>> > arch/arm/mach-omap2/pm.c:239: error: implicit declaration of funct=
ion 'disable_hlt'
>> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
>> > arch/arm/mach-omap2/pm.c:247: error: implicit declaration of funct=
ion 'enable_hlt'
>>=20
>> Care to mention which commit broke the compile?
>
> Seems like it was 9f97da78 (Disintegrate asm/system.h for ARM),
> and also needs to be fixed for omap1 too. Using the updated
> patch below.
>
> Tony
>
>
> From: Govindraj.R <govindraj.raja@ti.com>
> Date: Thu, 29 Mar 2012 09:30:28 -0700
> Subject: [PATCH] ARM: OMAP: pm: fix compilation break
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Fix the compilation break observed on latest mainline caused
> by 9f97da78 (Disintegrate asm/system.h for ARM):
>
> arch/arm/mach-omap1/pm.c: In function =E2=80=98omap_pm_prepare=E2=80=99=
:
> arch/arm/mach-omap1/pm.c:587: error: implicit declaration of function=
 =E2=80=98disable_hlt=E2=80=99
> arch/arm/mach-omap1/pm.c: In function =E2=80=98omap_pm_finish=E2=80=99=
:
> arch/arm/mach-omap1/pm.c:624: error: implicit declaration of function=
 =E2=80=98enable_hlt=E2=80=99
> arch/arm/mach-omap1/pm.c: In function =E2=80=98omap_pm_init=E2=80=99:
> arch/arm/mach-omap1/pm.c:681: error: =E2=80=98arm_pm_idle=E2=80=99 un=
declared (first use in this function)
> ...
>
> arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
> arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function=
 'disable_hlt'
> arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
> arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function=
 'enable_hlt'
>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> [tony@atomide.com: updated to fix omap1 too]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Kevin Hilman <khilman@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
