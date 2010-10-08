From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"
Date: Fri, 08 Oct 2010 13:06:30 -0700
Message-ID: <87y6a8v48p.fsf@deeprootsystems.com>
References: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60973 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab0JHUGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 16:06:33 -0400
Received: by pvg2 with SMTP id 2so406476pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 13:06:33 -0700 (PDT)
In-Reply-To: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
	(Jean Pihet's message of "Fri, 8 Oct 2010 18:49:13 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> This patch reverts commit 914bab936fe0388a529079679e2f137aa4ff548d, which
> breaks the OFF mode on the OMAP3 platforms.
> The details are here below.
>
> The intent behind the original patch was to fix some compiler
> warnings, which I do not have on my side. Is the problem dependent on
> the setup and config used?

> From ec85bc90978cf0f257e73eaad593ffb774595863 Mon Sep 17 00:00:00 2001
> From: Jean Pihet <jean.pihet@newoldbits.com>
> Date: Fri, 8 Oct 2010 18:36:48 +0200
> Subject: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"
>
> This reverts commit 914bab936fe0388a529079679e2f137aa4ff548d, which
> breaks the OFF mode on the OMAP3 platforms.
>
> The use of a void* pointer for scratchpad_address confuses the
> compiler which generates wrong offset for the access to the L4
> address space. In that case an alignement fault is generated
> during the wake-up from OFF mode.
>
> The code that causes problem is:
> __raw_readl(scratchpad_address + OMAP343X_TABLE_ADDRESS_OFFSET);

Thanks Jean for tracking down why off-mode was broken on the master
branch.  

I completely agree this patch should be reverted.  However, the
description here could be a litle more descriptive.

Specifically, the compiler is not confused and generating the wrong
offset.  The compiler is doing what it was told told.

The problem is that the original patch rather blindly replaced a u32
pointer with a void pointer to fix a sparse warning.  However, the code
using that pointer was doing pointer math which has different results
for a void pointer than for a u32 pointer.   

I'll reply in more detail to the original patch.

Kevin
