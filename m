From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: hwmod: align the SmartReflex fck names
Date: Wed, 3 Oct 2012 10:00:59 -0700
Message-ID: <20121003170059.GD4840@atomide.com>
References: <1349279277-7634-1-git-send-email-j-pihet@ti.com>
 <1349279277-7634-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24242 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964888Ab2JCRBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 13:01:02 -0400
Content-Disposition: inline
In-Reply-To: <1349279277-7634-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbou@mail.ru>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [121003 08:48]:
> @@ -1036,8 +1036,8 @@ static struct omap_clk am33xx_clks[] = {
>  	CLK("davinci-mcasp.1",  NULL,           &mcasp1_fck,    CK_AM33XX),
>  	CLK("NULL",	"mmc2_fck",		&mmc2_fck,	CK_AM33XX),
>  	CLK(NULL,	"mmu_fck",		&mmu_fck,	CK_AM33XX),
> -	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck,	CK_AM33XX),
> -	CLK(NULL,	"smartreflex1_fck",	&smartreflex1_fck,	CK_AM33XX),
> +	CLK(NULL,	"smartreflex.0",	&smartreflex_mpu_fck,	CK_AM33XX),
> +	CLK(NULL,	"smartreflex.1",	&smartreflex_core_fck,	CK_AM33XX),
>  	CLK(NULL,	"timer1_fck",		&timer1_fck,	CK_AM33XX),
>  	CLK(NULL,	"timer2_fck",		&timer2_fck,	CK_AM33XX),
>  	CLK(NULL,	"timer3_fck",		&timer3_fck,	CK_AM33XX),

I think this should be something like this instead:

	CLK("smartreflex.0",	"fck",	&smartreflex_mpu_fck,	CK_AM33XX),
	CLK("smartreflex.1",	"fck",	&smartreflex_core_fck,	CK_AM33XX),

Where the first one is the dev name, the second one is the
alias you want to use in the client driver?

Regards,

Tony
