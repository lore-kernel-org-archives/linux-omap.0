From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 8/9 v2] omap3: pm: introduce dynamic OPP
Date: Fri, 13 Nov 2009 17:31:28 -0800
Message-ID: <87hbsxnb7z.fsf@deeprootsystems.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>
	<1258092322-30833-2-git-send-email-nm@ti.com>
	<1258092322-30833-3-git-send-email-nm@ti.com>
	<1258092322-30833-4-git-send-email-nm@ti.com>
	<1258092322-30833-5-git-send-email-nm@ti.com>
	<1258092322-30833-6-git-send-email-nm@ti.com>
	<1258092322-30833-7-git-send-email-nm@ti.com>
	<1258092322-30833-8-git-send-email-nm@ti.com>
	<1258092322-30833-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:38197 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbZKNBbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 20:31:25 -0500
Received: by pwi3 with SMTP id 3so2312499pwi.21
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2009 17:31:30 -0800 (PST)
In-Reply-To: <1258092322-30833-9-git-send-email-nm@ti.com> (Nishanth Menon's message of "Fri\, 13 Nov 2009 00\:05\:21 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Nishanth Menon <nm@ti.com> writes:

> OPP tables have been used as static arrays till now this causes
> limitations in terms of ability to dynamically making decisions
> for cpu types and populating it with the right values. This
> implementation is based on the discussions in the thread:
> http://marc.info/?l=linux-omap&m=125482970102327&w=2
> inputs from Romit, Benoit, Kevin, Sanjeev, Santosh acked.
>
> omap3_pm_init_opp_table is introduced here, and the default omap3
> tables have been renamed to omap34xx_ tables, original omap3_xx
> tables are now dynamically allocated and populated.
>
> Corresponding board files calling omap2_init_common_hw with the
> active opp table params have been updated with this patch.
>
> This now paves way to introduce 3630 OPP tables.
>
> Tested on: SDP3430 - SDP3630 boot breaks with this patch
> (as SDP3630 needs corresponding correct VDD2 freq w.r.t SDRC clk.
> The next patch in this series fixes things)
>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Romit Dasgupta <romit@ti.com>
> Cc: Sanjeev Premi <premi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> Cc: SuiLun Lam <s-lam@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

[...]

> +void __init omap3_pm_init_opp_table(void)
> +{
> +	/* Populate the base CPU rate tables here */
> +	omap3_mpu_rate_table = kmalloc(sizeof(omap34xx_mpu_rate_table),
> +			GFP_KERNEL);
> +	omap3_dsp_rate_table = kmalloc(sizeof(omap34xx_dsp_rate_table),
> +			GFP_KERNEL);
> +	omap3_l3_rate_table = kmalloc(sizeof(omap34xx_l3_rate_table),
> +			GFP_KERNEL);
> +
> +	BUG_ON(!omap3_mpu_rate_table || !omap3_dsp_rate_table ||
> +		!omap3_l3_rate_table);
> +
> +	memcpy(omap3_mpu_rate_table, omap34xx_mpu_rate_table,
> +			sizeof(omap34xx_mpu_rate_table));
> +	memcpy(omap3_dsp_rate_table, omap34xx_dsp_rate_table,
> +			sizeof(omap34xx_dsp_rate_table));
> +	memcpy(omap3_l3_rate_table, omap34xx_l3_rate_table,
> +			sizeof(omap34xx_l3_rate_table));
> +}
> +

Minor issue, but FYI... rather than the kmalloc + memcpy, you can use
kmemdup() to do the same thing.

Kevin
