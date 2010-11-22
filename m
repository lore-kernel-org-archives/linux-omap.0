From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Mon, 22 Nov 2010 11:16:23 -0800
Message-ID: <87r5edp3so.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58845 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab0KVTQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 14:16:27 -0500
Received: by pxi15 with SMTP id 15so1621132pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 11:16:26 -0800 (PST)
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 18 Nov 2010 19:54:45 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Bunch of fixes as part of phase 1 targetting mainly OMAP3630 HS devices
> for OFF mode logic.
>
> It is important to note - for proper functionality of HS OFF mode on OMAP3630,
>    CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE=y and
>    CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID should be set to the correct
>    service that the security PPA supports on the platform.
>
> Based on kernel.org 2.6.37-rc2 tag
>
> Smoke tested on:
> SDP3630 -GP
> Zoom3 (3630): GP & EMU (Es1.1, ES1.2)
> SDP3430 - GP & EMU (ES3.1)
>
> These are fixes for corner case bugs seen, so tests of off and ret done with
> wakeup timer - behavior between 2.6.37-rc2 before and after applying patch
> seen consistent.
>
> Request for testing this series for comparison between master and this
> series requested for additional platforms where available.

After some more thought and review, here's what I think should be the
approach moving this forward:

This can be broken up into 3 independent series as follows:  

1) fix for UART erratum (patch 10)
2) fixes for idle path errata (patches 1, 2, 11, 12, 13)
3) secure ram save path (the rest)

For (3), I'd like to see the secure ram management moved out of the PM
core, and into it's own library/driver.  Strictly speaking, context
save/restore for secure ram is not a function of the PM idle core.   As
with every other device, context save/restore is the responsibility of
the driver(s) using that device.

For secure RAM, the restore is handled by ROM code, but the save should
be managed by the secure driver(s).  IOW, any secure driver should be
using runtime PM and when the secure driver is no longer in use, it
should ensure secure RAM context is saved using its runtime_suspend
method to save secure RAM.  The code in this series should be moved out
into a library/driver which can be called by secure drivers in their
runtime PM hooks.

Stated otherwise, the PM core is doing the job that should be done by
secure driver(s).  Rather than continuing to extend that hack, it's time
for that to be fixed correctly in a way that can be maintainted.

Kevin

> Archana Sriram (1):
>   OMAP3: PM: Errata i582: per domain reset issue: uart
>
> Eduardo Valentin (3):
>   OMAP3: PM: Deny MPU idle while saving secure RAM
>   OMAP3: PM: Apply errata i540 before save secure ram
>   OMAP3630: PM: Errata i583: disable coreoff if < ES1.2
>
> Nishanth Menon (3):
>   OMAP3: PM: make secure ram save size configurable
>   OMAP3: PM: Fix secure save size for OMAP3
>   OMAP3630: PM: Errata i608: disable RTA
>
> Peter 'p2' De Schrijver (2):
>   OMAP3: PM: Errata i581 suppport: dll kick strategy
>   OMAP3630: PM: Disable L2 cache while invalidating L2 cache
>
> Richard Woodruff (1):
>   OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all
>
> Tero Kristo (3):
>   OMAP3: PM: Save secure RAM context before entering WFI
>   OMAP3: PM: optional save secure RAM context every core off cycle
>   OMAP3: PM: allocate secure RAM context memory from low-mem
>
>  arch/arm/mach-omap2/control.c            |    5 +-
>  arch/arm/mach-omap2/control.h            |    5 +
>  arch/arm/mach-omap2/io.c                 |   11 ++
>  arch/arm/mach-omap2/pm.h                 |   40 +++++++
>  arch/arm/mach-omap2/pm34xx.c             |  184 ++++++++++++++++++++++++-----
>  arch/arm/mach-omap2/serial.c             |   80 +++++++++++++
>  arch/arm/mach-omap2/sleep34xx.S          |  187 ++++++++++++++++++-----------
>  arch/arm/plat-omap/include/plat/serial.h |    4 +
>  8 files changed, 412 insertions(+), 104 deletions(-)
>
> Regards,
> Nishanth Menon
