From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v4 07/13] OMAP4: DMA: hwmod: add system DMA
Date: Tue, 9 Nov 2010 10:32:51 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FA77A@dbde02.ent.ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
 <1289225272-9767-8-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38837 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab0KIFDA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 00:03:00 -0500
In-Reply-To: <1289225272-9767-8-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


One minor comment,
 
<<snip>>

> +
>  static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	/* dmm class */
>  	&omap44xx_dmm_hwmod,
> @@ -1077,6 +1174,8 @@ static __initdata struct omap_hwmod 
> *omap44xx_hwmods[] = {
>  	&omap44xx_uart2_hwmod,
>  	&omap44xx_uart3_hwmod,
>  	&omap44xx_uart4_hwmod,
> +	/* dma class */
> +	&omap44xx_dma_system_hwmod,

Add a blank line between each class. See [1]
Same is applicable to patches 4, 5 and 6

[1] https://patchwork.kernel.org/patch/305062/

