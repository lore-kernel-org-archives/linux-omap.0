From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 00/22] OMAP3: PM: Smartreflex and voltage revamp
Date: Tue, 20 Apr 2010 16:49:35 -0700
Message-ID: <8739ypbs6o.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:32782 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab0DTXtj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 19:49:39 -0400
Received: by pwj9 with SMTP id 9so4724586pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Apr 2010 16:49:38 -0700 (PDT)
In-Reply-To: <1271408597-3066-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:32\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> The main motivations behind this patch series are the following
> 1. Making smartreflex a platform driver with omap-device layer.
> 2. Separating voltage specific code from smartreflex.c and other
>    locations and consolidating them into voltage.c and voltage.h.
> 3. Smartreflex module can have Class 1 Class 2 or Class 3 implementations
>    depending on the PMIC in use. Making smartreflex.c capable
>    of handling both the Class 2 and 3  implementaions and separating out
>    class specific code into a separate class driver.
> 4. Remove dependencies on opp id in the smartreflex and
>    voltage drivers
> 5. Implementating  latest TI recommended register settings for
>   Smartreflex and Voltage processor module as well as recommended
>   sequences for enabling and disabling of Smartreflex and Voltage
>   processor modules.
> 6. Implementing VP force update method of voltage scaling which is
>    again TI hardware recommended.
>
> What this patch series does not address are
> 1. Separating PMIC specific portions from smartreflex and voltage code.
> 2. OMAP3630 and OMP4 smartreflex support.
>
> This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
> and is dependent on the following patches not yet applied onto this branch.
>
>         http://patchwork.kernel.org/patch/81504/
>         http://patchwork.kernel.org/patch/81606/
>
> This patch series has been tested on OMAP3430 SDP with basic power
> management tests including the dvfs scripts.

Will get to reviewing this later this week.  In the mean time, I 
pushed a new pm-wip-sr branch with this version of the series.

Thanks,

Kevin
