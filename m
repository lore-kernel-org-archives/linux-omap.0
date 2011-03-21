From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Mon, 21 Mar 2011 14:08:25 +0100
Message-ID: <4D874DC9.6020203@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60312 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab1CUNIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Mar 2011 09:08:31 -0400
In-Reply-To: <1300493932-17362-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>

Hi Kevin,

On 3/19/2011 1:18 AM, Hilman, Kevin wrote:
> The voltage domain pointer currently in struct omap_hwmod is not used
> and does not belong here.  Instead, voltage domains will be associated
> with powerdomains in forthcoming patches.

Technically speaking, an IP, and thus the hwmod does belong to a voltage 
domain, a power domain and a clock domain.

What is maybe important to add is that since clkdm < pwrdm < voltdm, we 
can potentially avoid providing the information for the each domain type.

At some point the hwmod will have to contain a clkdm instead of relying 
on the main_clk to get it... but that's another topic...

> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1adea9c..a5fa7c1 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -520,7 +520,6 @@ struct omap_hwmod {
>   	struct clk			*_clk;
>   	struct omap_hwmod_opt_clk	*opt_clks;
>   	char				*vdd_name;

And what about vdd_name? It should probably be removed as well.

Benoit

