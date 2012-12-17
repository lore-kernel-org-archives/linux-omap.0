From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Drop plat/cpu.h for omap2plus
Date: Mon, 17 Dec 2012 10:04:32 +0100
Message-ID: <1555457.YNrhJNmIOs@avalon>
References: <20121216200236.24238.38151.stgit@muffinssi.local> <20121216200317.24238.63954.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33540 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab2LQJDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 04:03:17 -0500
In-Reply-To: <20121216200317.24238.63954.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>

Hi Tony,

Thanks for the patch.

On Sunday 16 December 2012 12:03:17 Tony Lindgren wrote:
> The cpu_is_omap macros are now local to arch/arm/mach-omap2
> in soc.h and plat/cpu.h can finally be dropped for omap2+.
> Thanks everybody for help with fixing the drivers.
> 
> Note that we can now also remove the unused plat/cpu.h from
> smartreflex.c and isp.c as they will cause compile errors
> with ARCH_MULTIPLATFORM enabled.
> 
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

For the OMAP3 ISP part,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-omap2/drm.c             |    1 -
>  arch/arm/mach-omap2/dss-common.c      |    3 +--
>  arch/arm/mach-omap2/prm2xxx.c         |    3 +--
>  arch/arm/mach-omap2/prm3xxx.c         |    3 +--
>  arch/arm/plat-omap/include/plat/cpu.h |    4 ----
>  drivers/media/platform/omap3isp/isp.c |    2 --
>  drivers/power/avs/smartreflex.c       |    2 --
>  7 files changed, 3 insertions(+), 15 deletions(-)

-- 
Regards,

Laurent Pinchart

