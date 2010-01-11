From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/6] Added DSS2/FBDEV support for OMAP3EVM & AM3517EVM
Date: Mon, 11 Jan 2010 12:03:03 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A3982CC@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1262615657-22723-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36095 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909Ab0AKGdN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 01:33:13 -0500
In-Reply-To: <1262615657-22723-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>

\

> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, January 04, 2010 8:04 PM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; tony@atomide.com; Hiremath, Vaibhav
> Subject: [PATCH 0/6] Added DSS2/FBDEV support for OMAP3EVM &
> AM3517EVM
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> This patch added DSS2 + OMAPFB support for OMAP3EVM and AM3517/05
> EVM along
> with sharp LQ043T1DG01 panel support.
> 
> Vaibhav Hiremath (4):
>   OMAP: DSS2: Fix compile warning
>   OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
>   OMAP: Enable DSS2 for OMAP3EVM board
>   OMAP: AM3517: Enable DSS2 for AM3517EVM board
> 
[Hiremath, Vaibhav] Tomi,

Do you see any issues with this patch-series? It has been reviewed multiple times. Can we merge these patches?
You had only taken warning fix patch, any specific reason?

Thanks,
Vaibhav

>  arch/arm/configs/am3517_evm_defconfig              |   52 ++++-
>  arch/arm/configs/omap3_evm_defconfig               |   51 ++++-
>  arch/arm/mach-omap2/board-am3517evm.c              |  144
> ++++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c               |  246
> +++++++++++++++++++-
>  drivers/video/omap2/displays/Kconfig               |    6 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  120
> ++++++++++
>  drivers/video/omap2/dss/core.c                     |    2 +
>  8 files changed, 609 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-sharp-
> lq043t1dg01.c

