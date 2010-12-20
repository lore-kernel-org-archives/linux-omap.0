From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 0/7] OMAP: idle path errata fixes
Date: Mon, 20 Dec 2010 11:17:41 +0100
Message-ID: <AANLkTi=Bnn9PAN75NmqgqNTiMkTfG6sZkUEdSVz0_EFE@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44403 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab0LTKRm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:17:42 -0500
Received: by qwa26 with SMTP id 26so2619761qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:17:41 -0800 (PST)
In-Reply-To: <1292712817-24999-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> Hi,
> as discussed in [1], here is step 2 - idle path errata fixes.
> this is the next rev incorporating comments from V2 post
> of this series.
>
> Tested:
> this series:
> =A0 =A0 =A0 =A0SDP3430
> =A0 =A0 =A0 =A0SDP3630
> this series + ASM cleanup series[2]
> =A0 =A0 =A0 =A0SDP3430
> =A0 =A0 =A0 =A0SDP3630
> Test Script:
> http://elinux.org/OMAP_Power_Management#Quick_verification_of_suspend=
-idle_functionality

This series + ASM cleanup series[2]:
Tested OK on Beagleboard with full RET and OFF modes,
using cpuidle.

Tested-by: Jean Pihet <j-pihet@ti.com>

>
> V3: http://marc.info/?t=3D129140247800030&r=3D1&w=3D2
>
> V2: http://marc.info/?l=3Dlinux-omap&m=3D129106200408109&w=3D2
>
> Major change in V3:
> =A0 =A0 =A0 =A0Erratas are now handled per silicon - it is much clean=
er :)
> =A0 =A0 =A0 =A0no more redundant cpu_is_omap34xx check anymore
> =A0 =A0 =A0 =A0errata configure is __init as it should be
>
> Eduardo Valentin (1):
> =A0OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
>
> Nishanth Menon (3):
> =A0omap3: pm: introduce errata handling
> =A0OMAP3630: PM: Erratum i608: disable RTA
> =A0OMAP3: PM: make omap3_cpuidle_update_states independent of
> =A0 =A0enable_off_mode
>
> Peter 'p2' De Schrijver (2):
> =A0OMAP3: PM: Erratum i581 support: dll kick strategy
> =A0OMAP3630: PM: Disable L2 cache while invalidating L2 cache
>
> Richard Woodruff (1):
> =A0OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all
>
> =A0arch/arm/mach-omap2/control.c =A0 =A0 | =A0 13 +++-
> =A0arch/arm/mach-omap2/control.h =A0 =A0 | =A0 =A07 +-
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 29 ++++--
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0| =A0 15 +++-
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 46 +++++++++-
> =A0arch/arm/mach-omap2/sleep34xx.S =A0 | =A0187 +++++++++++++++++++++=
++--------------
> =A06 files changed, 211 insertions(+), 86 deletions(-)
>
> bloat-o-meter report Vs 2.6.37-rc6
> add/remove: 2/0 grow/shrink: 7/0 up/down: 297/0 (297)
> function =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 old =A0 =A0 new =A0 delta
> omap3_pm_off_mode_enable =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08=
0 =A0 =A0 160 =A0 =A0 +80
> omap3_pm_init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 1792 =A0 =A01872 =A0 =A0 +80
> omap3630_ctrl_disable_rta =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
- =A0 =A0 =A044 =A0 =A0 +44
> omap3_save_scratchpad_contents =A0 =A0 =A0 =A0 =A0 =A0 =A0 732 =A0 =A0=
 760 =A0 =A0 +28
> static.__func__ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
13783 =A0 13808 =A0 =A0 +25
> vermagic =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A045 =A0 =A0 =A060 =A0 =A0 +15
> linux_banner =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 132 =A0 =A0 147 =A0 =A0 +15
> prcm_interrupt_handler =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26=
8 =A0 =A0 276 =A0 =A0 =A0+8
> pm34xx_errata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0- =A0 =A0 =A0 2 =A0 =A0 =A0+2
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D129045338806957&w=3D2
> [2] http://marc.info/?l=3Dlinux-omap&m=3D129268746417556&w=3D2
>
> Cc: Charulatha Varadarajan <charu@ti.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tao Hu <tghk48@motorola.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>
> ---
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
