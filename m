From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 11/14] omap4: Fix silicon version detection for early
 samples
Date: Fri, 17 Sep 2010 05:18:25 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014F13A77F@dlee02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57985 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab0IQKSa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 06:18:30 -0400
In-Reply-To: <1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Friday, September 17, 2010 4:48 AM

[..]

> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index ae70ae9..0412233 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -308,6 +308,15 @@ static void __init omap4_check_revision(void)
>  	hawkeye = (idcode >> 12) & 0xffff;
>  	rev = (idcode >> 28) & 0xff;
> 
> +	/*
> +	 * Few initial ES2.0 samples IDCODE is same as ES1.0
> +	 * Use ARM register to detect the correct ES version
> +	 */
> +	if (!rev) {
> +		idcode = read_cpuid(CPUID_ID);
> +		rev = (idcode & 0xf) - 1;
> +	}
> +

Squash this to patch 10?

Regards,
Nishanth Menon

