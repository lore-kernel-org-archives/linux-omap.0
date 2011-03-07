From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP1: McBSP: fix build break for non-multi-OMAP1
 configs
Date: Mon, 7 Mar 2011 16:30:47 +0200
Message-ID: <20110307163047.a65c51d2.jhnikula@gmail.com>
References: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47752 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1CGOaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 09:30:52 -0500
Received: by bwz15 with SMTP id 15so3784354bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 06:30:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Kishon Vijay Abraham I <kishon@ti.com>, linux-arm-kernel@lists.infradead.org

On Fri, 4 Mar 2011 15:36:46 -0700 (MST)
Paul Walmsley <paul@pwsan.com> wrote:

> 
> Commit 3cf32bba8ca0e0052ca41d74d455a5805b7fea85 ("OMAP: McBSP: Convert
> McBSP to platform device model") in the current omap-for-linus branch
> breaks compilation with non-multi-OMAP1 configs:
> 
>   CC      arch/arm/mach-omap1/mcbsp.o
> arch/arm/mach-omap1/mcbsp.c: In function 'omap1_mcbsp_init':
> arch/arm/mach-omap1/mcbsp.c:384: warning: dereferencing 'void *' pointer
> arch/arm/mach-omap1/mcbsp.c:387: error: invalid use of void expression
> arch/arm/mach-omap1/mcbsp.c:390: warning: dereferencing 'void *' pointer
> arch/arm/mach-omap1/mcbsp.c:393: error: invalid use of void expression
> 
> +#define omap7xx_mcbsp_res_0		omap7xx_mcbsp_res[0]
> +
...
>  	if (cpu_is_omap7xx())
> -		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res[0],
> +		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res_0,
>  					OMAP7XX_MCBSP_RES_SZ,
>  					omap7xx_mcbsp_pdata,
>  					OMAP7XX_MCBSP_COUNT);

omapxxx_mcbsp_res_0 doesn't look the best here in readability point of
view but provides the smallest fix as no need to rename array and
modify the _RES_SZ and _COUNT macros. So this fix is needed here and a
small readability update can be done later.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
