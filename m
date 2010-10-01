From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog,
 UART, i2c
Date: Fri, 1 Oct 2010 17:38:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010011737250.22941@utopia.booyaka.com>
References: <8762xpenf8.fsf@deeprootsystems.com> <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com> <20100930021819.GD3117@atomide.com> <20100930022937.GF3117@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43844 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab0JAXiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:38:09 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Thu, 30 Sep 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Thursday, September 30, 2010 8:00 AM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; Nayak, Rajendra;
> > Raja, Govindraj; Kevin Hilman
> > Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions:
> > watchdog, UART, i2c
> > 
> > * Tony Lindgren <tony@atomide.com> [100929 19:10]:
> > >
> > > Then trying to build for omap1 OSK fails with:
> > >
> > > In file included from arch/arm/plat-omap/common.c:35:
> > > arch/arm/plat-omap/include/plat/control.h:20:40: error:
> > mach/ctrl_module_core_44xx.h: No such file or directory
> > > arch/arm/plat-omap/include/plat/control.h:21:40: error:
> > mach/ctrl_module_wkup_44xx.h: No such file or directory
> > > arch/arm/plat-omap/include/plat/control.h:22:44: error:
> > mach/ctrl_module_pad_core_44xx.h: No such file or directory
> > > arch/arm/plat-omap/include/plat/control.h:23:44: error:
> > mach/ctrl_module_pad_wkup_44xx.h: No such file or directory
> > 
> > This seems to be related to Santosh' commit 802edcb7.
> >
> :(
>  
> > Santosh, can you do a patch to fix this against the current
> > omap-for-linus branch?
> >
> Below is the patch(also attached)which fixes the OMAP1 build issue.
> ---------
> >From c06e887f402ceff03e6c28bb377bcbfe35318719 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Thu, 30 Sep 2010 12:23:07 +0530
> Subject: [PATCH] omap: control: Fix the omap1 build break
> 
> The commit 802edcb7 broke the omap1 build
> 
> In file included from arch/arm/plat-omap/common.c:35:
> arch/arm/plat-omap/include/plat/control.h:20:
> fatal error: mach/ctrl_module_core_44xx.h: No such file or directory
> compilation terminated.
> make[1]: *** [arch/arm/plat-omap/common.o] Error 1
> make: *** [arch/arm/plat-omap] Error 2
> 
> Fix it by creating the headers needed for compiling under
> mach-omap1/include/mach and mach-omap2/include/mach.
> Also move omap4 specific headers under mach-omap2/control.h
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap1/include/mach/control.h |    3 +++
>  arch/arm/mach-omap2/include/mach/control.h |    8 ++++++++
>  arch/arm/plat-omap/include/plat/control.h  |    5 +----
>  3 files changed, 12 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/include/mach/control.h
>  create mode 100644 arch/arm/mach-omap2/include/mach/control.h
> 
> diff --git a/arch/arm/mach-omap1/include/mach/control.h b/arch/arm/mach-omap1/include/mach/control.h
> new file mode 100644
> index 0000000..c1fd4c0
> --- /dev/null
> +++ b/arch/arm/mach-omap1/include/mach/control.h
> @@ -0,0 +1,3 @@
> +/*
> + * arch/arm/mach-omap1/include/mach/control.h
> + */

OMAP1 doesn't have a SCM, so this is the wrong fix.  A better approach is 
here:

https://patchwork.kernel.org/patch/218992/


> diff --git a/arch/arm/mach-omap2/include/mach/control.h b/arch/arm/mach-omap2/include/mach/control.h
> new file mode 100644
> index 0000000..dd41272
> --- /dev/null
> +++ b/arch/arm/mach-omap2/include/mach/control.h
> @@ -0,0 +1,8 @@
> +/*
> + * arch/arm/mach-omap2/include/mach/control.h
> + */
> +#include <mach/ctrl_module_core_44xx.h>
> +#include <mach/ctrl_module_wkup_44xx.h>
> +#include <mach/ctrl_module_pad_core_44xx.h>
> +#include <mach/ctrl_module_pad_wkup_44xx.h>
> +
> diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
> index 19c9b2a..7b047e5 100644
> --- a/arch/arm/plat-omap/include/plat/control.h
> +++ b/arch/arm/plat-omap/include/plat/control.h
> @@ -17,10 +17,7 @@
>  #define __ASM_ARCH_CONTROL_H
>  
>  #include <mach/io.h>
> -#include <mach/ctrl_module_core_44xx.h>
> -#include <mach/ctrl_module_wkup_44xx.h>
> -#include <mach/ctrl_module_pad_core_44xx.h>
> -#include <mach/ctrl_module_pad_wkup_44xx.h>
> +#include <mach/control.h>
>  
>  #ifndef __ASSEMBLY__
>  #define OMAP242X_CTRL_REGADDR(reg)					\
> -- 
> 1.6.0.4
> 
>  
> 
> 


- Paul
