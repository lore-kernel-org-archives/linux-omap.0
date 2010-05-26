From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/10] OMAP4: hwmod: Replace OCPIF_HAS_IDLEST by HWMOD_NO_IDLEST
Date: Wed, 26 May 2010 14:34:14 -0700
Message-ID: <874ohuny95.fsf@deeprootsystems.com>
References: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
	<1273247055-15165-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39837 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab0EZVeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 17:34:19 -0400
Received: by pwi7 with SMTP id 7so401087pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 14:34:18 -0700 (PDT)
In-Reply-To: <1273247055-15165-5-git-send-email-b-cousson@ti.com> (Benoit Cousson's message of "Fri\,  7 May 2010 17\:44\:09 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Benoit Cousson <b-cousson@ti.com> writes:

> Some initiator modules in OMAP2 & 3 does not have IDLEST bit,
> in that case we cannot detect the module readiness by
> polling that bit and must exist the function immediately
> assuming that the module is ready.
>
> The previous flag was affected to the OCP interface. While it is
> technically true that the idlest is related to the L4 slave
> interface of the module, the PRCM status belong to the module.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

We had some discussions off-list on this patch... summarizing below.

> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |    2 +-
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 4a134c4..6459d07 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -808,7 +808,7 @@ static int _wait_target_ready(struct omap_hwmod *oh)
>  
>  	os = *oh->slaves + oh->_mpu_port_index;
>  
> -	if (!(os->flags & OCPIF_HAS_IDLEST))
> +	if (oh->flags & HWMOD_NO_IDLEST)
>  		return 0;

This changes the default from assuming a module doesn't have an IDLEST
to assuming it does.

Because of this, we now get a bunch of failures in _enable() on
OMAP2/3 due to missing fields in the hwmods, in particular the members
of the 'struct omap_hwmod_omap2_prcm' are required to get correct
_wait_for_ready() behavior.

Therefore, when creating new hwmods, please be sure the fields of this
struct are filled out and correct.

Kevin
