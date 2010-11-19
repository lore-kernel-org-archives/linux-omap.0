From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 11/13] OMAP3630: PM: Errata i608: disable RTA
Date: Fri, 19 Nov 2010 10:57:12 +0100
Message-ID: <AANLkTin03HpggFOFtwrxYrFwrU6sARkM82KqgsCL9HpB@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-12-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55784 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab0KSJ5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 04:57:13 -0500
Received: by qyk7 with SMTP id 7so48266qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 01:57:12 -0800 (PST)
In-Reply-To: <1290131698-6194-12-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

On Fri, Nov 19, 2010 at 2:54 AM, Nishanth Menon <nm@ti.com> wrote:
> Errata id: i608
> RTA (Retention Till Access) feature is not supported and leads to dev=
ice
> stability issues when enabled. This impacts modules with embedded mem=
ories
> on OMAP3630
>
> Workaround is to disable RTA on boot and coming out of core off.
> For disabling rta coming out of off mode, we do this by overriding th=
e
> restore pointer for 3630 to allow us restore handler as the first poi=
nt of
> entry before caches are touched and is common for GP and HS devices.
> to disable earlier than this could be possible by modifying the ppa f=
or HS
> devices, but not for GP devices.
>
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> =A0arch/arm/mach-omap2/control.c =A0 | =A0 =A05 ++++-
> =A0arch/arm/mach-omap2/control.h =A0 | =A0 =A05 +++++
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 12 ++++++++++++
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 25 +++++++++++++++++++++++++
> =A04 files changed, 46 insertions(+), 1 deletions(-)
>
=2E..

> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sl=
eep34xx.S
> index 5a4468f..7259541 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
=2E..
> =A0/* Function call to get the restore pointer for for ES3 to resume =
from OFF */
> @@ -246,6 +256,19 @@ copy_to_sram:
This code is from 'restore_es3' which ends with a pass-through to 'rest=
ore:'...

> =A0 =A0 =A0 =A0bne =A0 =A0 copy_to_sram
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, sram_base
> =A0 =A0 =A0 =A0blx =A0 =A0 r1
> +
=2E. and so adding restore_3630 here has the result that is also run by
34xx >=3D ES3.x.
Is that a concern? Was it tested on 34xx >=3D ES3.x?

> +restore_3630:
> + =A0 =A0 =A0 /*b restore_es3630*/ =A0 =A0 =A0 =A0 =A0 =A0@ Enable to=
 debug restore code
> + =A0 =A0 =A0 ldr =A0 =A0 r1, pm_prepwstst_core_p
> + =A0 =A0 =A0 ldr =A0 =A0 r2, [r1]
> + =A0 =A0 =A0 and =A0 =A0 r2, r2, #0x3
> + =A0 =A0 =A0 cmp =A0 =A0 r2, #0x0 =A0 =A0 =A0 =A0@ Check if previous=
 power state of CORE is OFF
> + =A0 =A0 =A0 bne =A0 =A0 restore
> + =A0 =A0 =A0 /* Disable rta before giving control */
> + =A0 =A0 =A0 ldr =A0 =A0 r1, control_mem_rta
> + =A0 =A0 =A0 mov =A0 =A0 r2, #OMAP36XX_RTA_DISABLE
> + =A0 =A0 =A0 str =A0 =A0 r2, [r1]
> + =A0 =A0 =A0 /* Fall thru for the remaining logic */
> =A0restore:
> =A0 =A0 =A0 =A0/* b restore*/ =A0@ Enable to debug restore code
> =A0 =A0 =A0 =A0 /* Check what was the reason for mpu reset and store =
the reason in r9*/
> @@ -650,6 +673,8 @@ cache_pred_disable_mask:
> =A0 =A0 =A0 =A0.word =A0 0xFFFFE7FB
> =A0control_stat:
> =A0 =A0 =A0 =A0.word =A0 CONTROL_STAT
> +control_mem_rta:
> + =A0 =A0 =A0 .word =A0 CONTROL_MEM_RTA_CTRL
> =A0kernel_flush:
> =A0 =A0 =A0 =A0.word v7_flush_dcache_all
> =A0 =A0 =A0 =A0/* these 2 words need to be at the end !!! */
> --
> 1.6.3.3
>
>

A more general remark: since pm34xx.c and sleep34xx.S now contain 34xx
and 36xx specific code, should those (and possibly other files) be
renamed to e.g. pm3xxx.c and sleep3xxx.S?

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
