From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] BRIDGE checkpatch cleanup
Date: Sat, 30 Aug 2008 09:05:29 +0100
Message-ID: <20080830080529.GA20242@flint.arm.linux.org.uk>
References: <27F9C60D11D683428E133F85D2BB4A53448FFBBE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47232 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbYH3IFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 04:05:50 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53448FFBBE@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <x00omar@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pasam, Vijay" <vpasam@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

On Fri, Aug 29, 2008 at 10:09:29PM -0500, Ramirez Luna, Omar wrote:
> From: Omar Ramirez Luna <x00omar@ti.com>
> Date: Fri, 29 Aug 2008 21:20:39 -0500
> Subject: [PATCH] Bridge Checkpatch Cleanup
> 
> Deleted unused function typedefs and structures associated with them

This says delete.

> diff --git a/arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h b/arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h
> index f6a6c69..4bc2633 100644
> --- a/arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h
> +++ b/arch/arm/plat-omap/include/mach/bridge/_chnl_sm.h
> @@ -110,6 +110,8 @@ struct loadMonStruct {
> 
>  #endif
> 
> +       typedef u32 SMWORD;
> +

This looks like adding to me.

> +       typedef bool(CDECL *COD_ALLOCFXN) (void *pPrivRef, u32 space,
> +                                           u32 ulNumBytes, u32 ulAlign,
> +                                           u32 *ulDspAddr, bool fReserved);
> +
> +       typedef bool(CDECL *COD_FREEFXN) (void *pPrivReg, u32 ulDspAddr,
> +                                          u32 space, u32 ulNumBytes,
> +                                          bool fReserved);

More typedef adding.

> +#ifndef _SIZE_T                        /* Linux sets _SIZE_T on defining size_t */
> +typedef unsigned int size_t;
> +#define _SIZE_T
> +#endif

More adding...
