From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv6 2/7] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX GIC control register change.
Date: Wed, 18 Jul 2012 03:17:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207180314250.28834@utopia.booyaka.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com> <1339428387-4800-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40395 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab2GRJRf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 05:17:35 -0400
In-Reply-To: <1339428387-4800-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi

one trivial comment

On Mon, 11 Jun 2012, Tero Kristo wrote:

> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 46ab9d9..8d7de4f 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -88,6 +88,8 @@ extern void enable_omap3630_toggle_l2_on_restore(void);
>  static inline void enable_omap3630_toggle_l2_on_restore(void) { }
>  #endif		/* defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3) */
>  
> +#define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_xxx	(1 << 0)

"xxx" isn't unique, nor is it descriptive :-)  

Looking at the mail threads on this one, it sounds like there may not be a 
public erratum number associated with this.  If there is, the 'xxx' should 
be replaced with the number.  If there isn't, then it would be good to 
make up something short, like "GICD" to replace the "xxx".


- Paul
