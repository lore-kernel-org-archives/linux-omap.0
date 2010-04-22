From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v4 1/1] Registering sgx device and it's platform data
Date: Thu, 22 Apr 2010 16:37:34 +0300
Message-ID: <20100422133733.GB2262@gandalf>
References: <19F8576C6E063C45BE387C64729E7394044E1EB744@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35126 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab0DVNgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 09:36:53 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E1EB744@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Agarwal, Preshit" <preshit.agarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pais, Allen" <allen.pais@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

On Thu, Apr 22, 2010 at 05:36:16PM +0530, Agarwal, Preshit wrote:
> In this patch SGX powervr_device is registered with it's platform specific
> data to provide information about setting constraint through
> omap_pm_set_min_bus_tput.
> This patch removes the requirement of EXPORT_SYMBOL for the same function.
> 
> Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

please remove my SOB. I never tested this patch.

> diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> new file mode 100644
> index 0000000..6c7aad1
> --- /dev/null
> +++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> @@ -0,0 +1,29 @@
> +/*
> + *  arch/arm/mach-omap2/include/mach/omap_sgxdef.h

and SGX is used by other archs too, you might as well move this to some
common location under include/linux/

although this is only the omap set_min_bus_tput...

-- 
balbi
