From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP AM33xx: hwmod data: resolve sparse warnings
Date: Wed, 26 Dec 2012 09:40:20 +0530
Message-ID: <50DA78AC.9090601@ti.com>
References: <20121224012304.13698.43551.stgit@dusk.lan> <20121224012458.13698.43620.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab2LZENH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Dec 2012 23:13:07 -0500
In-Reply-To: <20121224012458.13698.43620.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Cochran <richardcochran@gmail.com>, "David S. Miller" <davem@davemloft.net>, Vaibhav Hiremath <hvaibhav@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>

On 12/24/2012 6:55 AM, Paul Walmsley wrote:
> Commit 70384a6af0914d5dcec034643941e29d3e3e69f7 ("ARM: OMAP3+:
> hwmod: Add AM33XX HWMOD data for davinci_mdio module") adds two
> new sparse warnings:
>
> arch/arm/mach-omap2/omap_hwmod_33xx_data.c:2518:30: warning: symbol 'am33xx_mdio_addr_space' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_data.c:2526:26: warning: symbol 'am33xx_cpgmac0__mdio' was not declared. Should it be static?
>
> Fix by marking the two new records as static.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Mugunthan V N <mugunthanvnm@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
>
Looks good to me.
Acked-by : Mugunthan V N <mugunthanvnm@ti.com>
