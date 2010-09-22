From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: hwmod: Fix softreset status check for some new
 OMAP4 IPs
Date: Tue, 21 Sep 2010 18:24:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009211824200.4677@utopia.booyaka.com>
References: <1285088279-425-1-git-send-email-b-cousson@ti.com> <1285088279-425-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36668 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752Ab0IVAYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 20:24:50 -0400
In-Reply-To: <1285088279-425-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, p-basak2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>

On Tue, 21 Sep 2010, Benoit Cousson wrote:

> In OMAP3 a specific SYSSTATUS register was used to get the softreset status.
> Starting in OMAP4, some IPs does not have SYSSTATUS register and instead
> use the SYSC softreset bit to provide the status.
> 
> Other cases might exist:
> - Some IPs like McBSP does have a softreset control but no reset status.
> - Some IPs that represent subsystem, like the DSS, can contains
> a reset status without softreset control. The status is the aggregation
> of all the sub modules reset status.
> 
> - Add a new flag (SYSC_HAS_RESET_STATUS) to identify the new programming model
> and replace the previous SYSS_MISSING, that was used to flag IP with
> softreset control but without the SYSSTATUS register, with a specific
> SYSS_HAS_RESET_STATUS flag.
> 
> - MCSPI and MMC contains both programming models, so the legacy one
> will be prevented by removing the syss offset field that become useless.

Thanks, queued this for 2.6.37.


- Paul
