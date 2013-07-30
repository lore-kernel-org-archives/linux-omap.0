From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 10/33] ARM: OMAP4: remove old clock data and link in
 new clock init code
Date: Tue, 30 Jul 2013 14:42:33 -0500
Message-ID: <51F81729.5010406@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-11-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37858 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889Ab3G3TnA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 15:43:00 -0400
In-Reply-To: <1374564028-11352-11-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:

> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> deleted file mode 100644
> index 88e37a4..0000000
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ /dev/null
[...]
> -
> -int __init omap4xxx_clk_init(void)
> -{
arch/arm/mach-omap2/clock44xx.h:int omap4xxx_clk_init(void);
arch/arm/mach-omap2/io.c:       omap_clk_init = omap4xxx_clk_init;
code in drivers/clk/omap/clk-44xx.c

Seems goofy to me a little.
entire purpose of having a clk-44xx.c is:
a) doing a clk alias for device nodes
b) set_parent, rate
both of these seem to be an old style carry forward and should instead 
be fixes with generic properties IMHO voiding the need for SoC specific 
inits.

instead all we should be doing is call of_clk_init(NULL); at appropriate 
init sequence.

-- 
Regards,
Nishanth Menon
