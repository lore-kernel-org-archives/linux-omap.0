From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [RFC 0/3] Use clknames to reference parent/bypass/ref clks
Date: Wed, 16 Feb 2011 17:52:02 +0530
Message-ID: <df183faec42045a4dfae041ead8edb16@mail.gmail.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37368 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932546Ab1BPMWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:22:05 -0500
Received: by mail-fx0-f47.google.com with SMTP id 17so1260002fxm.34
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:22:03 -0800 (PST)
In-Reply-To: <1295446466-23655-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com

Hi Paul,

> -----Original Message-----
> From: Rajendra Nayak [mailto:rnayak@ti.com]
> Sent: Wednesday, January 19, 2011 7:44 PM
> To: linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Rajendra Nayak
> Subject: [RFC 0/3] Use clknames to reference parent/bypass/ref clks
>
> This RFC series adds support to allow clock
> framework to reference clk parents, reference
> clocks and bypass clocks (for DPLL's) by names
> along with the current support to reference
> them by pointers.

Did you get a chance to look at this RFC series?
I was waiting to hear from you before I repost
based on Felipe and Kevin's comments on the
patches.

Regards,
Rajendra

>
> Referencing through clk pointers makes it difficult
> to support different revs of a single chip when
> seperate clk nodes, one for each rev have to be modelled,
> and especially when these are non-leaf nodes.
> A case for this exists in the current series as well.
>
> The series is boot tested on 3430sdp and fixes the
> multiple WARN's otherwise seen like the one below
>
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: at arch/arm/mach-omap2/clkt_clksel.c:194
omap2_clksel_recalc+0xd4/0xe4()
> [    0.000000] clock: Could not find fieldval 0 for clock dpll2_fck
parent core_ck
> [    0.000000] Modules linked in:
> [    0.000000] [<c006208c>] (unwind_backtrace+0x0/0xe4) from
[<c0092bfc>] (warn_slowpath_common+0x4c/0x64)
> [    0.000000] [<c0092bfc>] (warn_slowpath_common+0x4c/0x64) from
[<c0092c94>]
> (warn_slowpath_fmt+0x2c/0x3c)
> [    0.000000] [<c0092c94>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c0073dc4>] (omap2_clksel_recalc+0xd4/0xe4)
> [    0.000000] [<c0073dc4>] (omap2_clksel_recalc+0xd4/0xe4) from
[<c0077e1c>] (propagate_rate+0x24/0x50)
> [    0.000000] [<c0077e1c>] (propagate_rate+0x24/0x50) from [<c0077e28>]
(propagate_rate+0x30/0x50)
> [    0.000000] ---[ end trace 1b75b31a2719ed1d ]---
>
> Rajendra Nayak (3):
>   OMAP: clocks: Use clk names instead of clk pointers
>   OMAP3: PM: Fix CLK_SRC mask for IVA2 and MPU on 3430ES2
>   OMAP4: clocks: Remove unused clksel definitions
>
>  arch/arm/mach-omap2/clock2420_data.c    |   86 +++++++-------
>  arch/arm/mach-omap2/clock2430_data.c    |   88 ++++++++--------
>  arch/arm/mach-omap2/clock3xxx_data.c    |  183
+++++++++++++++++--------------
>  arch/arm/mach-omap2/clock44xx_data.c    |  145 +++++++++++-------------
>  arch/arm/mach-omap2/cm-regbits-34xx.h   |    2 +
>  arch/arm/plat-omap/clock.c              |   48 +++++++-
>  arch/arm/plat-omap/include/plat/clock.h |   11 ++-
>  7 files changed, 308 insertions(+), 255 deletions(-)
