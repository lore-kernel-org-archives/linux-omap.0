From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/8] OMAP3: PM: Adding smartreflex hwmod data
Date: Fri, 18 Jun 2010 13:46:59 -0700
Message-ID: <87eig43w70.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
	<1275150748-15386-2-git-send-email-thara@ti.com>
	<1275150748-15386-3-git-send-email-thara@ti.com>
	<1275150748-15386-4-git-send-email-thara@ti.com>
	<1275150748-15386-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40576 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab0FRUrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 16:47:03 -0400
Received: by pwi1 with SMTP id 1so596767pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 13:47:02 -0700 (PDT)
In-Reply-To: <1275150748-15386-5-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sat\, 29 May 2010 22\:02\:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds the smartreflex hwmod data for OMAP3430
> and OMAP3630. A dev_attr is also added to the hwmod
> structure for each smartreflex module which contains
> SoC specific info like the efuse offsets, test n-values
> etc.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

> +static struct omap_hwmod_ocp_if omap3_l4_core__sr1 = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap34xx_sr1_hwmod,
> +	.clk		= "sr_l4_ick",
> +	.addr		= omap3_sr1_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap3_sr1_addr_space),
> +	.user		= OCP_USER_MPU,

For enable to work, these all nee the .prcm.omap2 sub struct filled
out.

Kevin
