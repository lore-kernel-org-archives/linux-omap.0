From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/4] TI816X: Update common omap platform files
Date: Thu, 10 Feb 2011 10:25:46 -0800
Message-ID: <20110210182545.GN20795@atomide.com>
References: <1297270555-32447-1-git-send-email-hemantp@ti.com>
 <20110210013910.GF20795@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036ACA41C9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19473 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab1BJS0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 13:26:22 -0500
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036ACA41C9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

* Pedanekar, Hemant <hemantp@ti.com> [110210 09:37]:
> cvTony Lindgren wrote on Thursday, February 10, 2011 7:09 AM:
> 
> I will take care of this using separate map_io as you mentioned on
> the other mail on patch 2 comment.

OK great.
 
> Do you think the 2nd case restriction mentioned in this patch comment is OK?
> 
> " 2) OMAP3 only build with CONFIG_SOC_OMAPTI816X: This will build TI816X
>  optimized kernel. May not boot on other OMAP3 SoCs."
> 
> As I had mentioned on follow up on Paul's comment on v4, some OMAP3 specific
> code may get skipped on non-multi-omap builds with CONFIG_SOC_OMAPTI816X
> (cpu_is_ti816x() is true) such as:
> 
> -       if (omap_rev() >= OMAP3430_REV_ES2_0)     
> +       if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0)) 
>                 omap3_clk_lock_dpll5();    

I suggest that if CONFIG_ARCH_OMAP3 is selected, we do dynamic
checks for cpu_is omap macros for 34xx/36xx/ti816x.

We can use CONFIG_SOC_OMAP to optimize the size a bit if some features
are not needed, like clock data etc.

But in general the cpu_is checks should be only done during the
init for most part, so at this point doing performance optimizations
with the cpu_is macros should not really be needed.

Regards,

Tony
