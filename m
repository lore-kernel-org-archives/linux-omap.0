From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 0/5] extra module resets to ensure full-chip idle
Date: Mon, 01 Dec 2008 08:36:02 -0800
Message-ID: <87oczvn98t.fsf@deeprootsystems.com>
References: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:18823 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYLAQgH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 11:36:07 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2532402rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 08:36:05 -0800 (PST)
In-Reply-To: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Mon\,  1 Dec 2008 08\:22\:41 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Various bootloaders have been known to leave modules in a state
> which prevents full-chip retention.  This series forces
> MMC, IVA2 and D2D/modem into known reset/idle states so that
> the OMAP3 can hit full-chip idle.
>
> Tested on OMAP3 Beagle, and custom OMAP3 hardware.
>
> NOTE: this is similar to the set I posted for the PM branch
>       but this series is rebased onto linux-omap and includes
>       the MMC reset.

I forgot (again) to mention that this series applies on top of today's
HEAD plus the "OMAP2/3 clock: fix DPLL rate calculation" patch posted
by Paul Walmsley earlier today.

Kevin


> Kevin Hilman (5):
>   OMAP3: PM: HSMMC: force MMC module reset on boot
>   OMAP3: PM: Force IVA2 into idle during bootup
>   OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
>   OMAP3: PM: D2D clockdomain supports SW supervised transitions
>   OMAP3: PM: Ensure modem is reset during PRCM init
>
>  arch/arm/mach-omap2/clock34xx.h           |   37 ++++++++++++-
>  arch/arm/mach-omap2/clockdomains.h        |    2 +-
>  arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 +++++
>  arch/arm/mach-omap2/devices.c             |   85 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm34xx.c              |   65 ++++++++++++++++++++++-
>  arch/arm/plat-omap/include/mach/control.h |    5 ++
>  6 files changed, 204 insertions(+), 4 deletions(-)
