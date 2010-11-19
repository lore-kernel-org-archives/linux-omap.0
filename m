From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Fri, 19 Nov 2010 11:18:49 +0100
Message-ID: <AANLkTikLuJ2nY-VC=zNAs9TF5NCcjN48JXZF=p=WNf_X@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57631 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0KSKSu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 05:18:50 -0500
Received: by qyk30 with SMTP id 30so367523qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 02:18:49 -0800 (PST)
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Hi,

On Fri, Nov 19, 2010 at 2:54 AM, Nishanth Menon <nm@ti.com> wrote:
> Bunch of fixes as part of phase 1 targetting mainly OMAP3630 HS devic=
es
> for OFF mode logic.
>
> It is important to note - for proper functionality of HS OFF mode on =
OMAP3630,
> =A0 CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE=3Dy and
> =A0 CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID should be set to the co=
rrect
> =A0 service that the security PPA supports on the platform.
>
> Based on kernel.org 2.6.37-rc2 tag
>
> Smoke tested on:
> SDP3630 -GP
> Zoom3 (3630): GP & EMU (Es1.1, ES1.2)
> SDP3430 - GP & EMU (ES3.1)
>
> These are fixes for corner case bugs seen, so tests of off and ret do=
ne with
> wakeup timer - behavior between 2.6.37-rc2 before and after applying =
patch
> seen consistent.
>
> Request for testing this series for comparison between master and thi=
s
> series requested for additional platforms where available.
>
> Archana Sriram (1):
> =A0OMAP3: PM: Errata i582: per domain reset issue: uart
>
> Eduardo Valentin (3):
> =A0OMAP3: PM: Deny MPU idle while saving secure RAM
> =A0OMAP3: PM: Apply errata i540 before save secure ram
> =A0OMAP3630: PM: Errata i583: disable coreoff if < ES1.2
>
> Nishanth Menon (3):
> =A0OMAP3: PM: make secure ram save size configurable
> =A0OMAP3: PM: Fix secure save size for OMAP3
> =A0OMAP3630: PM: Errata i608: disable RTA
>
> Peter 'p2' De Schrijver (2):
> =A0OMAP3: PM: Errata i581 suppport: dll kick strategy
> =A0OMAP3630: PM: Disable L2 cache while invalidating L2 cache
>
> Richard Woodruff (1):
> =A0OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all
>
> Tero Kristo (3):
> =A0OMAP3: PM: Save secure RAM context before entering WFI
> =A0OMAP3: PM: optional save secure RAM context every core off cycle
> =A0OMAP3: PM: allocate secure RAM context memory from low-mem
>
> =A0arch/arm/mach-omap2/control.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +-
> =A0arch/arm/mach-omap2/control.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 =
++
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 40 =
+++++++
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0184 ++++=
++++++++++++++++++++-----
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 80 ++++=
+++++++++
> =A0arch/arm/mach-omap2/sleep34xx.S =A0 =A0 =A0 =A0 =A0| =A0187 ++++++=
++++++++++++-----------
> =A0arch/arm/plat-omap/include/plat/serial.h | =A0 =A04 +
> =A08 files changed, 412 insertions(+), 104 deletions(-)
>
> Regards,
> Nishanth Menon
>

This is a nice set of changes, thanks! I sent my remarks.

After having reviewed the patches I think the best is to merge those
in, then apply the clean-up and possibly the move to DDR patches on
top of that.

What do you think?

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
