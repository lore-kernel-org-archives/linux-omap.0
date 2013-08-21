From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 06/13] ARM: OMAP2+: PRCM: AM43x definitions
Date: Wed, 21 Aug 2013 03:20:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308210313410.6426@utopia.booyaka.com>
References: <cover.1375443858.git.afzal@ti.com> <ec65e24f1637245257f55906e5533ca54b010418.1375443858.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46461 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab3HUDUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 23:20:21 -0400
In-Reply-To: <ec65e24f1637245257f55906e5533ca54b010418.1375443858.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, benoit.cousson@gmail.com

On Fri, 2 Aug 2013, Afzal Mohammed wrote:

> Add AM43x CMINST, CDOFFS, RM_RSTST & RM_RSTCTRL definitions - minimal
> ones that would be used.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

...

> +/* PRM instances */
> +#define AM43XX_PRM_OCP_SOCKET_INST			0x0000
> +#define AM43XX_PRM_MPU_INST				0x0300
> +#define AM43XX_PRM_GFX_INST				0x0400
> +#define AM43XX_PRM_RTC_INST				0x0500
> +#define AM43XX_PRM_TAMPER_INST				0x0600
> +#define AM43XX_PRM_CEFUSE_INST				0x0700
> +#define AM43XX_PRM_PER_INST				0x0800
> +#define AM43XX_PRM_WKUP_INST				0x2000
> +#define AM43XX_PRM_DEVICE_INST				0x4000
> +

...

> +/* CM instances */
> +#define AM43XX_CM_WKUP_INST				0x2800
> +#define AM43XX_CM_DEVICE_INST				0x4100
> +#define AM43XX_CM_DPLL_INST				0x4200
> +#define AM43XX_CM_MPU_INST				0x8300
> +#define AM43XX_CM_GFX_INST				0x8400
> +#define AM43XX_CM_RTC_INST				0x8500
> +#define AM43XX_CM_TAMPER_INST				0x8600
> +#define AM43XX_CM_CEFUSE_INST				0x8700
> +#define AM43XX_CM_PER_INST				0x8800

That's a pretty broad address range to span, in PRCM terms.  Seems pretty 
unlikely that the whole area is really decoded to a single PRCM IP block?  
Or is it actually decoded into smaller PRM and CM sub-blocks, similar to 
OMAP4?

Just by looking at the offsets, it looks to me like you've got:

1. one IP block at 0x0000-0x1fff? that covers system PRM

2. one IP block at 0x2000-0x3fff? that covers WKUP PRM & CM
  
3. one IP block at 0x4000-? that covers device & PLL PRM & CM

4. one IP block at 0x8000-? that covers system CM



- Paul
