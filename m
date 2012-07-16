From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 2/8] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add recursive
 usecount tracking
Date: Mon, 16 Jul 2012 15:45:14 +0530
Message-ID: <5003E9B2.8060504@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com> <1342189185-5306-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36671 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292Ab2GPKPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 06:15:22 -0400
Received: by obbtb18 with SMTP id tb18so9033161obb.7
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 03:15:20 -0700 (PDT)
In-Reply-To: <1342189185-5306-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> This patch fixes the usecount tracking for omap3+, previously the
> usecount numbers were rather bogus and were not really useful for
> any purpose. Now usecount numbers track the number of really active
> clients on each domain. This patch also adds support for usecount
> tracking on powerdomain level and autoidle flag for clocks that
> are hardware controlled and should be skipped in usecount
> calculations.
>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@ti.com>

Reviewed by: Rajendra Nayak <rnayak@ti.com>

> ---
>   arch/arm/mach-omap2/clkt_iclk.c         |   21 +++++++++++
>   arch/arm/mach-omap2/clockdomain.c       |   59 +++++++++++++++++++++++++++++-
>   arch/arm/mach-omap2/clockdomain.h       |    2 +
>   arch/arm/mach-omap2/dpll3xxx.c          |   19 ++++++++++
>   arch/arm/mach-omap2/powerdomain.c       |   35 ++++++++++++++++++
>   arch/arm/mach-omap2/powerdomain.h       |    5 +++
>   arch/arm/plat-omap/clock.c              |    6 +++
>   arch/arm/plat-omap/include/plat/clock.h |    2 +
>   8 files changed, 147 insertions(+), 2 deletions(-)
>

>
>   	list_add(&clk->node,&clocks);
> +	/*
> +	 * If clock has no ops, it is handled by hardware and thus will
> +	 * idle automatically
> +	 */
> +	if (clk->ops ==&clkops_null)
> +		clk->autoidle = true;

I was a little skeptical about this when I first saw it. But I am
sure you would have thought through :)


