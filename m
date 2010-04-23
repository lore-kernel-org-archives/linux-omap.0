From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/2 v3] omap3: pm: cpufreq: BUG_ON cleanup
Date: Thu, 22 Apr 2010 17:25:09 -0700
Message-ID: <87iq7jxbfe.fsf@deeprootsystems.com>
References: <1271812987-14505-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:56943 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab0DWAZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 20:25:14 -0400
Received: by pzk32 with SMTP id 32so5944100pzk.21
        for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 17:25:13 -0700 (PDT)
In-Reply-To: <1271812987-14505-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Tue\, 20 Apr 2010 20\:23\:07 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Thara Gopinath <thara@ti.com>

Nishanth Menon <nm@ti.com> writes:

> BUG_ON should not ideally contain a functional code.
> Ref: http://marc.info/?l=linux-kernel&m=109391212925546&w=2
>
> To do this, we change the return of omap3_pm_init_opp from
> void to int and return back error value for caller to adequately
> handle further decisions. to reduce code duplication, the
> registration and error handling are done in loop now.
>
> Cc: Ambresh K <ambresh@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Tero Kristo <tero.kristo@nokia.com>
> Cc: Thara Gopinath <thara@ti.com>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Ref:
> v1: https://patchwork.kernel.org/patch/86793/
> v2: https://patchwork.kernel.org/patch/93701/
> v3: cosmetic changes including cleaning up the while loop for
> recovery path, also fix omap3_pm_init_opp_table when CPU_FREQ
> is not present in the line of rest of opp apis

Thanks, applied to pm-wip-opp.

Kevin
