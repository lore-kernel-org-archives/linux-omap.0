From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 06/16] OMAP3: PM: Smartreflex class related changes for smartreflex.c
Date: Tue, 02 Mar 2010 15:37:46 -0800
Message-ID: <871vg2thv9.fsf@deeprootsystems.com>
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
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50881 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab0CBXhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 18:37:50 -0500
Received: by gwb15 with SMTP id 15so432981gwb.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 15:37:49 -0800 (PST)
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

I think the class should be part of 'struct omap_sr'.  This should be
coded in a way to allow a different class type or each SR module (even
if that is never useful in practice.)

Kevin
