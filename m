From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: DRA7: hwmod: Add data for GPTimers 13 through
 16
Date: Tue, 24 Mar 2015 18:05:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503241804470.16497@utopia.booyaka.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com> <1426539294-28375-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58937 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbCXSFE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 14:05:04 -0400
In-Reply-To: <1426539294-28375-2-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 16 Mar 2015, Suman Anna wrote:

> Add the hwmod data for GPTimers 13, 14, 15 and 16. All these
> timers are present in the L4PER3 clock domain.
> 
> The corresponding DT nodes are already present but disabled.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 96 +++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

Thanks, queued for v4.1.


- Paul
