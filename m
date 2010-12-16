From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
Date: Thu, 16 Dec 2010 10:26:24 -0800
Message-ID: <20101216182624.GH5941@atomide.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16805 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877Ab0LPS02 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 13:26:28 -0500
Content-Disposition: inline
In-Reply-To: <1292521858-3810-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [101216 09:51]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> This patch only contains clean-ups and cosmetic changes,
> no functional change.
> 
> Clean-up of the ASM sleep code, for better readability and
> easier maintenance.
> 
> Applies on top of Nishant's latest idle path errata fixes step 2,
> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
> 
> Jean Pihet (7):
>   OMAP2+: use global values for the SRAM PA addresses
>   OMAP3: remove hardcoded values from the ASM sleep code
>   OMAP3: re-organize the ASM sleep code
>   OMAP3: rework of the ASM sleep code execution paths
>   OMAP3: add comments for low power code errata
>   OMAP3: ASM sleep code format rework
>   OMAP3: remove unused code from the ASM sleep code

Thanks for splitting it into several patches, looks good to me.
Assuming Kevin will queue these, so:

Acked-by: Tony Lindgren <tony@atomide.com>
