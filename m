From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Drop plat/cpu.h for omap2plus
Date: Mon, 17 Dec 2012 11:48:11 +0100
Message-ID: <CAORVsuXOmzz1cSSrKOy+nCLGJkby+LycqOXXNddJJ4cbnjVGtg@mail.gmail.com>
References: <20121216200236.24238.38151.stgit@muffinssi.local>
	<20121216200317.24238.63954.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39012 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab2LQKsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 05:48:12 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so8998965ieb.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 02:48:11 -0800 (PST)
In-Reply-To: <20121216200317.24238.63954.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Tony,

On Sun, Dec 16, 2012 at 9:03 PM, Tony Lindgren <tony@atomide.com> wrote:
> The cpu_is_omap macros are now local to arch/arm/mach-omap2
> in soc.h and plat/cpu.h can finally be dropped for omap2+.
> Thanks everybody for help with fixing the drivers.
Great!

> Note that we can now also remove the unused plat/cpu.h from
> smartreflex.c and isp.c as they will cause compile errors
> with ARCH_MULTIPLATFORM enabled.
>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/drm.c             |    1 -
>  arch/arm/mach-omap2/dss-common.c      |    3 +--
>  arch/arm/mach-omap2/prm2xxx.c         |    3 +--
>  arch/arm/mach-omap2/prm3xxx.c         |    3 +--
>  arch/arm/plat-omap/include/plat/cpu.h |    4 ----
>  drivers/media/platform/omap3isp/isp.c |    2 --
>  drivers/power/avs/smartreflex.c       |    2 --
>  7 files changed, 3 insertions(+), 15 deletions(-)

For the smartreflex driver:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

...

> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index a17d084..6b2238b 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -27,8 +27,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/power/smartreflex.h>
>
> -#include <plat/cpu.h>
> -
>  #define SMARTREFLEX_NAME_LEN   16
>  #define NVALUE_NAME_LEN                40
>  #define SR_DISABLE_TIMEOUT     200
>
