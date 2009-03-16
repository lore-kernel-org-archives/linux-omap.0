From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/12] ARM: OMAP3: mmc-twl4030 allow arbitrary slot names
Date: Mon, 16 Mar 2009 10:16:48 +0000
Message-ID: <20090316101648.GB31868@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211352.16425.44160.stgit@localhost> <20090315160838.GF10786@n2100.arm.linux.org.uk> <49BE2453.9020801@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57074 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbZCPKRJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 06:17:09 -0400
Content-Disposition: inline
In-Reply-To: <49BE2453.9020801@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 16, 2009 at 12:05:07PM +0200, Adrian Hunter wrote:
>> From 9b04f19a7e88f8877176c25845c38676ee3127c1 Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Tue, 10 Mar 2009 22:13:52 +0100
> Subject: [PATCH] ARM: OMAP3: mmc-twl4030 allow arbitrary slot names
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> arch/arm/mach-omap2/mmc-twl4030.c |    6 +++++-
> arch/arm/mach-omap2/mmc-twl4030.h |    1 +
> 2 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index a612a02..88b4bed 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -328,7 +328,11 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
> 			return;
> 		}
>
> -		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
> +		if (c->name)
> +			strlcpy(twl->name, c->name, ARRAY_SIZE(twl->name));
> +		else
> +			snprintf(twl->name, ARRAY_SIZE(twl->name),
> +				 "mmc%islot%i", c->mmc, 1);

Good, except now we have a confusion over which patch does what...
