From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 06/16] OMAP3: PM: Smartreflex class related changes for smartreflex.c
Date: Tue, 02 Mar 2010 15:52:42 -0800
Message-ID: <87iq9es2lx.fsf@deeprootsystems.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37717 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758050Ab0CBXwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 18:52:46 -0500
Received: by pwj8 with SMTP id 8so500971pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 15:52:45 -0800 (PST)
In-Reply-To: <1267003757-22456-7-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 24 Feb 2010 14\:59\:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> OMAP3 smartreflex modules are capable of two different classes
> of implementaion -
> 	Class-2: Continuous Software Calibration
> 	Class-3: Continuous Hardware Calibration.
> OMAP3 along with T2/Gaia supports the Class 3 implementaion.
> With a different PMIC it can support Class 2 implementaion also.
>
> The idea behind this patch is that smartreflex.c should be able
> to support both the classes of Smartreflex and the class specific
> details for smartreflex should stay out of this file in a separate
> class file.
> This patch introduces smartreflex class specific hooks in
> smartreflex.c. This patch only takes care of smartreflex enable
> disable hooks which differ between Class 2 and Class 3. There
> are some register setting changes between both the classes which
> will be taken care of in a later patch.
> This will form the base for adding class specific
> drivers in later patches.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c      |    8 +-
>  arch/arm/mach-omap2/smartreflex.c |  251 ++++++++++++++++++++----------------
>  arch/arm/mach-omap2/smartreflex.h |   48 ++++++--
>  3 files changed, 182 insertions(+), 125 deletions(-)
>

[...]

> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index c00925d..ba9f899 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -55,6 +55,7 @@ struct omap_sr {
>  
>  /* sr_list contains all the instances of smartreflex module */
>  static LIST_HEAD(sr_list);
> +static struct omap_smartreflex_class_data *sr_class;
>  
>  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
>  
> @@ -388,14 +389,86 @@ static int sr_reset_voltage(int srid)
>  	return 0;
>  }
>  
> -static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
> +static void sr_start_vddautocomap(int srid)

Either in this patch or in an additional patch (previous to this one)
can you fix the name of these autocomp functions: *_vddautocomap ->
*_vddautocomp.  I don't think comap means anything.

Kevin
