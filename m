From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 0/5] extra module resets to ensure full-chip idle
Date: Thu, 27 Nov 2008 06:04:18 +0100
Message-ID: <492E2A52.4030200@googlemail.com>
References: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:28934 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbYK0FE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 00:04:26 -0500
Received: by nf-out-0910.google.com with SMTP id d3so435105nfc.21
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 21:04:24 -0800 (PST)
In-Reply-To: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> Various bootloaders have been known to leave modules in a state
> which prevents full-chip retention.  

Does it make sense to check if

[PATCH 1/5] OMAP3: PM: HSMMC: force MMC module reset on boot
[PATCH 2/5] OMAP3: PM: Force IVA2 into idle during bootup

can be done in U-Boot, too? If yes, I would have a look to it.

Regards

Dirk

> This series forces
> MMC, IVA2 and D2D/modem into known reset/idle states so that
> the OMAP3 can hit full-chip idle.
> 
> Tested on OMAP3 Beagle, and custom OMAP3 hardware.
> 
> NOTE: this is similar to the set I posted for the PM branch
>       but this series is rebased onto linux-omap and includes
>       the MMC reset.
> 
> Kevin Hilman (5):
>   OMAP3: PM: HSMMC: force MMC module reset on boot
>   OMAP3: PM: Force IVA2 into idle during bootup
>   OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
>   OMAP3: PM: D2D clockdomain supports SW supervised transitions
>   OMAP3: PM: Ensure modem is reset during PRCM init
> 
>  arch/arm/mach-omap2/clock34xx.h           |   37 +++++++++++++-
>  arch/arm/mach-omap2/clockdomains.h        |    2 +-
>  arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 +++++
>  arch/arm/mach-omap2/devices.c             |   76 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm34xx.c              |   65 ++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/mach/control.h |    5 ++
>  6 files changed, 195 insertions(+), 4 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

