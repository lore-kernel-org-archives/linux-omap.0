From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/5] OMAP: hwmod: if IDLEST fields are not set, use module defaults
Date: Fri, 18 Jun 2010 09:43:21 -0700
Message-ID: <87hbl070ly.fsf@deeprootsystems.com>
References: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
	<1274994816-30335-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55935 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757687Ab0FRQn0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 12:43:26 -0400
Received: by pvg6 with SMTP id 6so528280pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 09:43:24 -0700 (PDT)
In-Reply-To: <1274994816-30335-3-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 27 May 2010 14\:13\:33 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> In the _setup() hook, check for valid IDLEST fields.  If not set, use
> the module defaults since they are the same as the module defaults
> for most hwmods.
>
> Problem found because _wait_target_ready() will fail if IDLEST
> fields are not valid.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>


FYI... dropping this patch in favor of simply updating the hwmod data
files to have valid idlest_* fields.

Kevin


>  arch/arm/mach-omap2/omap_hwmod.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index a127c9b..77fef90 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1036,6 +1036,12 @@ static int _setup(struct omap_hwmod *oh)
>  
>  	oh->_state = _HWMOD_STATE_INITIALIZED;
>  
> +	/* if IDLEST values are not set, use module defaults */
> +	if (!oh->prcm.omap2.idlest_reg_id)
> +		oh->prcm.omap2.idlest_reg_id = oh->prcm.omap2.prcm_reg_id;
> +	if (!oh->prcm.omap2.idlest_idle_bit)
> +		oh->prcm.omap2.idlest_idle_bit = oh->prcm.omap2.module_bit;
> +
>  	r = _enable(oh);
>  	if (r) {
>  		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
> -- 
> 1.7.0.2
