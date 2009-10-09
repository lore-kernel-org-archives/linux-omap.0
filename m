From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH v3] OMAP3: introduce OMAP3630
Date: Fri, 9 Oct 2009 08:55:05 -0500
Message-ID: <A24693684029E5489D1D202277BE89444CC6C59E@dlee02.ent.ti.com>
References: <1255045627-23405-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35361 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757554AbZJINzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 09:55:50 -0400
In-Reply-To: <1255045627-23405-1-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Nishanth, 

From: Menon, Nishanth 
Sent: Thursday, October 08, 2009 6:47 PM

<snip>

> diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
> b/arch/arm/plat-omap/include/mach/cpu.h
> index 431fec4..af1080f 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -383,6 +383,12 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define OMAP3430_REV_ES2_1	0x34302034
>  #define OMAP3430_REV_ES3_0	0x34303034
>  #define OMAP3430_REV_ES3_1	0x34304034
> +/* NOTE: Add 36xx series below
> + * If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
> + * added above the 3630 defines and series renumbered to ensure
> + * rev() > checks to work
> + */
> +#define OMAP3630_REV_ES1_0	0x34305034

Just for the sake of curiosity...

Why not defining 3630 like this?

#define OMAP3630_REV_ES1_0	0x36301034

Sorry if i'm asking something dumb.

Regards,
Sergio

>  
>  #define OMAP443X_CLASS		0x44300034
>  
> -- 
> 1.6.0.4
> 
> 