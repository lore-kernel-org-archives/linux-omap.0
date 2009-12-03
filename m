From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 3/4] OMAP: McBSP: Introduce caching in register write
 operations
Date: Thu, 3 Dec 2009 09:49:21 +0200
Message-ID: <20091203094921.1106827a.jhnikula@gmail.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
	<200912010415.52570.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40818 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbZLCHsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 02:48:10 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so858355bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 23:48:16 -0800 (PST)
In-Reply-To: <200912010415.52570.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, 1 Dec 2009 04:15:50 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

>  #define MCBSP_WRITE(mcbsp, reg, val) \
> -		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
> +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
> +		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
> +			= val)
> +#define MCBSP_READ_CACHE(mcbsp, reg) \
> +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1])
>  
These divisions by DDR1 are confusing. Use rather sizeof:

reg_cache[OMAP_MCBSP_REG_##reg / sizeof(*mcbsp->reg_cache)]


-- 
Jarkko
