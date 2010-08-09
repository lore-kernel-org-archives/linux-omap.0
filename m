From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/8]usb: musb: HWMOD database structures fixes OMAP4
Date: Mon, 09 Aug 2010 13:52:04 +0200
Message-ID: <4C5FEBE4.1060707@ti.com>
References: <1281110249-4098-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56238 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756256Ab0HILwQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Aug 2010 07:52:16 -0400
In-Reply-To: <1281110249-4098-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Hema,

On 8/6/2010 5:57 PM, Kalliguddi, Hema wrote:
> From: Hema HK<hemahk@ti.com>
>
> Fixed the missing sysc settings for OMAP4 and enabled the OMAP4
> hwmod data structure.
>
> Signed-off-by: Hema HK<hemahk@ti.com>
> Cc: Felipe Balbi<felipe.balbi@nokia.com>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>

It is a good practice, if not mandatory, to CC the authors of the file 
you are modifying with your patch.
Neither Paul, nor myself are in CC of this patch. Could you please add 
us to this one and the other ones when applicable?

> ---
>
> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c	2010-08-06 08:31:45.885868560 -0400
> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c	2010-08-06 08:35:41.250112281 -0400
> @@ -4516,8 +4516,15 @@
>    */
>
>   static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
> -	.sysc_flags	= SYSS_MISSING,
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +
> +	.rev_offs	= 0x0400,
> +	.sysc_offs	= 0x0404,
> +	.syss_offs	= 0x0408,
> +	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
> +			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +			  SYSC_HAS_AUTOIDLE,
> +	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
> +	.sysc_fields	=&omap_hwmod_sysc_type1,
>   };

This part if fine except the missing MIDLE_XXX modes. Here is the 
modified version using the same convention as other modules:

 >  static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
 > -       .sysc_flags     = SYSS_MISSING,
 > -       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 > +       .rev_offs       = 0x0400,
 > +       .sysc_offs      = 0x0404,
 > +       .syss_offs      = 0x0408,
 > +       .sysc_flags     = (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
 > +                          SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
 > +                          SYSC_HAS_SOFTRESET),
 > +       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 > +                          MSTANDBY_FORCE | MSTANDBY_NO | 
MSTANDBY_SMART),
 > +       .sysc_fields    = &omap_hwmod_sysc_type1,
 >  };

I don't have any preference for the parens, but in order to be 
consistent with the already existing hwmods, let's keep them.

Regards,
Benoit
