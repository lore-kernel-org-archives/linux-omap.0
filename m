From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
Date: Mon, 21 Jun 2010 08:54:16 -0700
Message-ID: <8739wg2xg7.fsf@deeprootsystems.com>
References: <1277151798-26232-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44801 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab0FUPyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 11:54:23 -0400
Received: by pvh11 with SMTP id 11so299705pvh.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 08:54:20 -0700 (PDT)
In-Reply-To: <1277151798-26232-1-git-send-email-tarun.kanti@ti.com> (Tarun Kanti DebBarma's message of "Tue\, 22 Jun 2010 01\:53\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Generation of 1ms granular GPTIMER events using 32KHz or system
> clocks as inputs does not have whole number count value to load
> into the register. This inaccurate count value with respect to 1ms
> period leads to time drift subsequently. OMAP3 and later silicons
> have dedicated registers for GPTIMER1, GPTIMER2 and GPTIMER10,
> which can be programmed with computed values to keep this error
> controlled within specified limit.
>
> Version 2:
> (i) optimized omap_dm_timer_ms_correction() function and corrected
> error in computing the positive and negative increments.
> (ii) typo corrections in comment section and warning removal related
> to 80-character limit
>
> Tested on Zoom3 using Linus tree.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Please coordinate this change with the GPTIMER hwmod changes.  The timers
that have/need this feature should be flagged at the hwmod level (probably by
a dev_attr flag.)

Kevin
