From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Fri, 19 Nov 2010 13:20:23 -0800
Message-ID: <877hg92ep4.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58281 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab0KSVU1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 16:20:27 -0500
Received: by gwb20 with SMTP id 20so282723gwb.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 13:20:26 -0800 (PST)
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

I haven't yet been through the entire series, but some general comments
to share before the weekend:

The secure mode code is growing in size and complexity, so I think it
should be removed from pm34xx.c and moved into it's own file
(secure3xxx.c ?)   This will help keep pm34xx.c lean, and it can call
into secure code as needed.    

Even better (and already suggested in some comments on patch 8), now
that there are board-configurable knobs, this should be set up as a very
simple platform driver/device so boards can pass configuration in a
standard way instead of having new APIs for use by board code to set
configuration settings.

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
