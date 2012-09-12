From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check
 for common functions
Date: Wed, 12 Sep 2012 15:18:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209121518170.17903@utopia.booyaka.com>
References: <1345820064-5243-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40330 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759995Ab2ILPSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 11:18:43 -0400
In-Reply-To: <1345820064-5243-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

On Fri, 24 Aug 2012, Vaibhav Hiremath wrote:

> Add missing soc_is_am33xx() check for DPLL common control & clock
> related functions, without this dpll programmability would be broken
> for am33xx family of devices.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> Not sure whether this should go as a fix in -rc, as AM33XX device
> doesn't still boot without hwmod data (which is not yet upstream).
> 
>  arch/arm/mach-omap2/clkt_dpll.c |    4 ++--
>  arch/arm/mach-omap2/dpll3xxx.c  |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thanks, queued for 3.7 along with the AM33xx hwmod patches.


- Paul
