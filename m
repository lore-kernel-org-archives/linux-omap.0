From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/2] ARM: OMAP3: clock: fix boot breakage in legacy mode
Date: Fri, 12 Dec 2014 11:07:19 -0800
Message-ID: <7hvblgk7q0.fsf@deeprootsystems.com>
References: <1418390521-7541-1-git-send-email-t-kristo@ti.com>
	<1418390521-7541-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47622 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbaLLTHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2014 14:07:23 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so7725662pdb.10
        for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2014 11:07:22 -0800 (PST)
In-Reply-To: <1418390521-7541-3-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 12 Dec 2014 15:22:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> The new usage of determine_rate and set_rate_and_parent calls for
> OMAP DPLLs assumes the DPLLs must have two parents defined, even
> if it is the same clock. Legacy clock data did not fullfill this
> requirement and caused a boot crash. Fixed by adding the missing
> parent information to the DPLL clocks.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Fixes: 2e1a7b014f ("ARM: OMAP3+: DPLL: use determine_rate() and...")
> Cc: Kevin Hilman <khilman@kernel.org>

I tested this on linux-next (next-20141210, same version where I found
the bug) and this doesn't fix the boot problem. 

BTW, in testing this, I noticed that the OMAP clock code is still
spitting out compile warnings[1].  These should cleaned up too.

Kevin

[1]
../arch/arm/mach-omap2/cclock3xxx_data.c:263:2: warning: initialization from incompatible pointer type [enabled by default]
../arch/arm/mach-omap2/cclock3xxx_data.c:263:2: warning: (near initialization for 'dpll1_ck_ops.determine_rate') [enabled by default]
../arch/arm/mach-omap2/cclock3xxx_data.c:376:2: warning: initialization from incompatible pointer type [enabled by default]
../arch/arm/mach-omap2/cclock3xxx_data.c:376:2: warning: (near initialization for 'dpll4_ck_ops.determine_rate') [enabled by default]
