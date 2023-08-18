Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B3AC71155
	for <linux-omap@archiver.kernel.org>; Fri, 18 Aug 2023 15:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351221AbjHRPPP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378121AbjHRPO5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 18 Aug 2023 11:14:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B44231;
        Fri, 18 Aug 2023 08:14:27 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363278999"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363278999"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="858726915"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="858726915"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2023 08:14:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qX1Am-00DNyr-0o;
        Fri, 18 Aug 2023 18:14:00 +0300
Date:   Fri, 18 Aug 2023 18:13:59 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, j-keerthy@ti.com,
        vz@mleia.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org,
        shubhrajyoti.datta@amd.com, srinivas.neeli@amd.com,
        michal.simek@amd.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH -next 11/11] gpio: zynq: Use helper function
 devm_clk_get_enabled()
Message-ID: <ZN+Kt2SxLDSAudYR@smile.fi.intel.com>
References: <20230818093018.1051434-1-lizetao1@huawei.com>
 <20230818093018.1051434-12-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093018.1051434-12-lizetao1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Aug 18, 2023 at 05:30:18PM +0800, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
> prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
> can now be replaced by devm_clk_get_enabled() when the driver enables
> (and possibly prepares) the clocks for the whole lifetime of the device.
> Moreover, it is no longer necessary to unprepare and disable the clocks
> explicitly.

...

> -		return dev_err_probe(&pdev->dev, PTR_ERR(gpio->clk), "input clock not found.\n");
> +		return dev_err_probe(&pdev->dev, PTR_ERR(gpio->clk),
> +				     "input clock not found or unable to enable clock.\n");

With this change dropped,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


