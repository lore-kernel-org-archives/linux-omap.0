From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/16] OMAP3: PM: Smartreflex and voltage revamp.
Date: Fri, 05 Mar 2010 16:58:43 -0800
Message-ID: <87k4tqw9j0.fsf@deeprootsystems.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f184.google.com ([209.85.211.184]:54094 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab0CFBFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 20:05:49 -0500
Received: by ywh14 with SMTP id 14so1838024ywh.15
        for <linux-omap@vger.kernel.org>; Fri, 05 Mar 2010 17:05:48 -0800 (PST)
In-Reply-To: <1267003757-22456-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 24 Feb 2010 14\:59\:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, "Thara Gopinath (none)" <thara@omaplbp.india.ti.com>

Thara Gopinath <thara@ti.com> writes:

> From: Thara Gopinath <thara@omaplbp.(none)>
>
> This main motivations behind this patch series are the following
> 1. Making smartreflex a platform driver with omap-device layer.
> 2. Separating voltage specific code from smartreflex.c and other
>    locations and consolidating them into voltage.c and voltage.h.
> 3. Smartreflex module can have Class 3 or Class 2 implementations
>    depending on the PMIC in use. Making smartreflex.c capable
>    of handling both the class implementaions and separating out
>    class specific code into a separate class driver.
> 4. Implementating  latest TI recommended register settings for
>   Smartreflex and Voltage processor module as well as recommended
>   sequences for enabling and disabling of Smartreflex and Voltage
>   processor modules.
> 5. Implementing VP force update method of voltage scaling which is
>    again TI hardware recommended.
>
> What this patch series does not address are
> 1. Separating PMIC specific portions from smartreflex and voltage code.
> 2. OMAP3630 and OMP4 smartreflex support.
>
> This patch series is based on Kevin's PM tree origin/pm-wip-opp branch
> and is dependent on the following patches not yet applied onto this branch.

Hi Thara,

One other request for V2.

Could you separate out any patches to SRF (resourc34xx) into their own
patches please?  This will facilitate upstream merging when SR is
finalized because while SR will be (hopefully) going upstream soon,
SRF will not.

A quick look shows patches 5, 8, 9 as having changes to
resource*.[ch].  Please separate those out as separate patches.

Once again, thanks for your efforts on this much needed SR rework,

Kevin
