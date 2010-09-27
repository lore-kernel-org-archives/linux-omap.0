From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2 07/10] TWL CORE: Fix sparse warning
Date: Mon, 27 Sep 2010 13:07:50 +0200
Message-ID: <20100927110750.GE2560@sortiz-mobl>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
 <1285063280-4057-8-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8299 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755743Ab0I0LHa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Sep 2010 07:07:30 -0400
Content-Disposition: inline
In-Reply-To: <1285063280-4057-8-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Hi Manjunath,

On Tue, Sep 21, 2010 at 03:31:17PM +0530, G, Manjunath Kondaiah wrote:
> Fixes below sparse warning.
> 
> drivers/mfd/twl-core.c:258:20: warning: symbol 'twl_map' was not declared. Should it be static?
> 
Patch applied, thanks.

Cheers,
Samuel.

> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
>  drivers/mfd/twl-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 720e099..53c371a 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -255,7 +255,7 @@ struct twl_mapping {
>  	unsigned char sid;	/* Slave ID */
>  	unsigned char base;	/* base address */
>  };
> -struct twl_mapping *twl_map;
> +static struct twl_mapping *twl_map;
>  
>  static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
>  	/*
> -- 
> 1.7.0.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
