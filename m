From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP: features: export symbol omap3_features
Date: Fri, 24 Sep 2010 07:58:09 -0700
Message-ID: <874odfkx32.fsf@deeprootsystems.com>
References: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33429 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab0IXO6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 10:58:12 -0400
Received: by pzk34 with SMTP id 34so641882pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 07:58:11 -0700 (PDT)
In-Reply-To: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Thu, 23 Sep 2010 22:41:04 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> From: Kevin Hilman <khilman@deeprootsystems.com>

Minor nit, can you make the subject something like:

   OMAP: features: make feature checks available to modules

Thanks,

Kevin

> Since omap3_features is a global variable, only code
> built-in the kernel can make use of it and thus use
> omap_has ##feat functions; exporting this as a kernel
> symbol makes modules able to use feature detection
> framework too.
>
> Thread: http://marc.info/?l=linux-omap&m=128528822902211&w=2
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Nishanth Menon <nm@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>
> CC: Sanjeev Premi <premi@ti.com>
> CC: linux-omap@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm/mach-omap2/id.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 9a879f9..a8c6d19 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -31,6 +31,7 @@ static struct omap_chip_id omap_chip;
>  static unsigned int omap_revision;
>  
>  u32 omap3_features;
> +EXPORT_SYMBOL(omap3_features);
>  
>  unsigned int omap_rev(void)
>  {
