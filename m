From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: 32k counter: resolve sparse warnings
Date: Tue, 25 Dec 2012 21:52:14 +0530
Message-ID: <50D9D2B6.4060906@ti.com>
References: <20121224012304.13698.43551.stgit@dusk.lan> <20121224012456.13698.41839.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58643 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866Ab2LYQVh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Dec 2012 11:21:37 -0500
In-Reply-To: <20121224012456.13698.41839.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Monday 24 December 2012 06:54 AM, Paul Walmsley wrote:
> Commit 1fe97c8f6a1de67a5f56e029a818903d5bed8017 ("ARM: OMAP: Make OMAP
> clocksource source selection using kernel param") results in a new warning
> from sparse:
>
> arch/arm/plat-omap/counter_32k.c:86:12: warning: symbol 'omap_init_clocksource_32k' was not declared. Should it be static?
>
> Fix by adding a temporary header file, needed until the 32k counter
> code is moved to drivers/.
> arch/arm/plat-omap/include/plat/counter-32k.h can't be added due to
> ARM CONFIG_ARCH_MULTIPLATFORM restrictions on the use of the "plat/"
> include path shortcut.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Looks good to my eyes.
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>

