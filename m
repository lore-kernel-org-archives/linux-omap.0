From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv7 00/21] ARM: OMAP3+: auto retention support
Date: Mon, 05 Nov 2012 17:02:15 -0800
Message-ID: <87k3tzczmw.fsf@deeprootsystems.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49786 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab2KFBCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 20:02:15 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4336827pad.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 17:02:15 -0800 (PST)
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Tue, 25 Sep 2012 19:33:32 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> This set applies on top of linux-3.6-rc5 + func-pwrst code (from Jean) +
> omap4 core retention set (from me) + PM usecounting changes set (from me).

Since the functional pwrst and usecounting changes are still under
review, I've taken the patches from this series that are not dependent
on either of those series and queued them up here for v3.8 (branch:
for_3.8/pm/voltage.)  

That includes patches the core voltage layer changes (patches 1-10 and
14-17) and the 4460 OPP data (patch 18.)

I've left out the TPS changes so I can review those closer, and also
left out the main auto-ret/auto off patch (PATCH 13/21) because of the
dependencies on the usecounting series.

With this, I tested DVFS on 3430/n900, 4430/Panda and 4460/PandaES and
voltage scaling seems to be working well.

Kevin

> Changes compared to previous version:
> - Added proper OMAP4 auto-retention support (now that the PM usecount set
>   below supports OMAP4 also properly)
> - Merged TPS6236x support to this set (patches 16,18-20), without this
>   there will be an issue with patch #21, as panda board will misbehave
>   without TPS support and auto-ret enabled
> - Patch #15 fixes the addressing of voltage channels for OMAP4, without this
>   the voltage channels either end up changing wrong voltage channel or not
>   changing anything at all
> - Patch #16 is new based on the discussion earlier on the separate TPS set
>   * uses proper I2C parameters based on board data, this is still in a data
>     table though, as calculating these runtime would be rather complicated
>     (if even possible, as it requires some higher order mathematics according
>      to my understanding)
> - Patch #17 enables high speed I2C communication for voltage channel on OMAP4
>   (this now works thanks to patch #16)
> - Patch #18 is needed for 4460 boards, otherwise the boot-up OPP detection
>   fails and voltage control doesn't work at all on 4460 boards
> - Patch #19 was pulled from the TPS support set
> - Patch #20 was pulled from the TPS support set, with following changes:
>   * board setup for the GPIOs was sanitized a bit
>   * dropped a number of unused defines from the code
>
> Working branch available:
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.6-rc5-omap-auto-ret-v7
>
> Testing done:
> - hw used: omap3 beagle rev c4, omap4460 gp panda, omap4430 emu blaze
> - suspend + cpuidle
> - measured core + mpu voltage rails on all setups to verify that the
>   voltage transitions work properly during idle
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
