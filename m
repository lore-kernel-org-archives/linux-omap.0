From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3 pm: dependency between opp layer and cpufreq
Date: Thu, 27 May 2010 18:56:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDE2F@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E71FDE25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab0E0N1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 09:27:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4RDQxTj006630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 08:27:02 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4RDQxRK011757
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 18:56:59 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDE25@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Thursday, May 27, 2010 6:50 PM
> To: linux-omap@vger.kernel.org
> Subject: RE: omap3 pm: dependency between opp layer and cpufreq
> 

[snip]--[snip]

>  
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 2b9ebf0..18d291f 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>  # OPP support in (OMAP3+ only at the moment)
>  # XXX The OPP TWL/TPS code should only be included when a TWL/TPS
>  # PMIC is selected.
> -ifdef CONFIG_CPU_FREQ
> +ifdef CONFIG_TWL4030_POWER
>  obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
>  endif
> 
After sending the mail, I realized that inclusion of opp_twl_tps.o should
depend upon CONFIG_TWL4030_POWER and opp.o should be included as default.

~sanjeev

[snip]--[snip]
