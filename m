From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] OMAP: ID: introduce chip detection for OMAP4460
Date: Thu, 30 Jun 2011 23:25:05 -0700
Message-ID: <20110701062505.GW23145@atomide.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>
 <1309486081-8257-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:14454 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751365Ab1GAGZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 02:25:08 -0400
Content-Disposition: inline
In-Reply-To: <1309486081-8257-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Aneesh V <aneesh@ti.com>, Nishanth Menon <nm@ti.com>

* Rajendra Nayak <rnayak@ti.com> [110630 19:03]:
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -331,8 +331,8 @@ static void __init omap3_check_revision(void)
>  static void __init omap4_check_revision(void)
>  {
>  	u32 idcode;
> -	u16 hawkeye;
>  	u8 rev;
> +	u16 hawkeye;
>  
>  	/*
>  	 * The IC rev detection is done with hawkeye and rev.

Please leave out this change, there's no need for it.

Tony
