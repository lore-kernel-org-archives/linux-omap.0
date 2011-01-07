From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Fri, 07 Jan 2011 07:33:34 -0600
Message-ID: <4D27162E.6070203@ti.com>
References: <1294405659-25662-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43634 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753348Ab1AGNdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:33:39 -0500
Received: by gxk9 with SMTP id 9so4210033gxk.33
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 05:33:38 -0800 (PST)
In-Reply-To: <1294405659-25662-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi wrote, on 01/07/2011 07:07 AM:
> +		if (omap3_has_720mhz()) {
> +			pr_info("Enabled OPP corresponding to 720MHz\n");
> +
> +			omap34xx_opp_def_list[INDEX_MPU_720MHZ]
> +				.default_available = true;
> +			omap34xx_opp_def_list[INDEX_IVA_720MHZ]
> +				.default_available = true;
for many reasons, I dont like this indexing - I am ok with most part of 
the patch otherwise - how about opp_enable(dev, freq) instead?

-- 
Regards,
Nishanth Menon
